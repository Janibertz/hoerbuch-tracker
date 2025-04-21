<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Session;
use App\Models\Playlist;
use App\Models\Track;
use App\Services\SpotifyTokenService;

class SpotifyPlaylistController extends Controller
{
    public function checkAndImport()
{
    $token = SpotifyTokenService::getValidAccessToken();

    if (!$token) {
        // z. B. redirect oder error response
        return back()->with('error', 'Kein gültiger Spotify-Token.');
    }

    // Hole aktuell gespielten Titel
    $response = Http::withToken($token)->get('https://api.spotify.com/v1/me/player/currently-playing');

    if (!$response->ok() || !$response->json('is_playing')) {
        return response()->json(['status' => 'no_playback']);
    }

    $data = $response->json();
    $context = $data['context']['uri'] ?? null;
    $contextType = $data['context']['type'] ?? null;

    if (!$context || !in_array($contextType, ['playlist', 'album'])) {
        return response()->json(['status' => 'not_supported_context']);
    }

    // Extrahiere die Spotify-ID je nach Typ
    if ($contextType === 'playlist') {
        $spotifyId = str_replace('spotify:playlist:', '', $context);
        $apiUrl = "https://api.spotify.com/v1/playlists/{$spotifyId}";
    } else { // album
        $spotifyId = str_replace('spotify:album:', '', $context);
        $apiUrl = "https://api.spotify.com/v1/albums/{$spotifyId}";
    }

    // Schon importiert?
    if (Playlist::where('spotify_id', $spotifyId)->where('type', $contextType)->exists()) {
        return response()->json(['status' => 'already_imported']);
    }

    // Hole Playlist- oder Album-Daten
    $spotifyData = Http::withToken($token)->get($apiUrl)->json();

    $newPlaylist = Playlist::create([
        'spotify_id' => $spotifyId,
        'title' => $spotifyData['name'],
        'cover_url' => $spotifyData['images'][0]['url'] ?? null,
        'total_tracks' => $contextType === 'playlist'
            ? $spotifyData['tracks']['total']
            : count($spotifyData['tracks']['items']),
        'type' => $contextType,
    ]);

    // Tracks importieren
    $tracks = $spotifyData['tracks']['items'];

    // Bei Playlist liegt der Track direkt unter 'track'
    if ($contextType === 'playlist') {
        foreach ($tracks as $item) {
            $track = $item['track'];
            Track::create([
                'playlist_id' => $newPlaylist->id,
                'spotify_id' => $track['id'],
                'title' => $track['name'],
                'duration_ms' => $track['duration_ms'],
            ]);
        }
    } else { // album
        foreach ($tracks as $track) {
            Track::create([
                'playlist_id' => $newPlaylist->id,
                'spotify_id' => $track['id'],
                'title' => $track['name'],
                'duration_ms' => $track['duration_ms'],
            ]);
        }
    }

    return response()->json([
        'status' => 'imported',
        'type' => $contextType,
        'playlist' => $newPlaylist,
    ]);
}

}


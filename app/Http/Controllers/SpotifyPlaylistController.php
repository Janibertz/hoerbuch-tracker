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
        return back()->with('error', 'Kein gültiger Spotify-Token.');
    }

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

    $spotifyId = str_replace("spotify:{$contextType}:", '', $context);
    $apiUrl = "https://api.spotify.com/v1/{$contextType}s/{$spotifyId}";

    $playlist = Playlist::firstOrCreate(
        [
            'spotify_id' => $spotifyId,
            'type' => $contextType,
            'user_id' => auth()->id() ?? 1,
        ],
        [
            'title' => $meta['name'],
            'cover_url' => $meta['images'][0]['url'] ?? null,
            'total_tracks' => $meta['tracks']['total'] ?? 0,
        ]
    );

    // Meta-Daten der Playlist/Album holen
    $meta = Http::withToken($token)->get($apiUrl)->json();

    $newPlaylist = Playlist::create([
        'spotify_id' => $spotifyId,
        'title' => $meta['name'],
        'cover_url' => $meta['images'][0]['url'] ?? null,
        'total_tracks' => $meta['tracks']['total'] ?? count($meta['tracks']['items'] ?? []),
        'type' => $contextType,
        'user_id' => auth()->id() ?? 1, // für Cronjobs
    ]);

    $offset = 0;
    $limit = 200;
    
    while (true) {
        $res = Http::withToken($token)->get("https://api.spotify.com/v1/{$contextType}s/{$spotifyId}/tracks", [
            'limit' => $limit,
            'offset' => $offset,
        ]);
    
        $items = $res->json('items') ?? [];
    
        if (count($items) === 0) break;
    
        foreach ($items as $item) {
            $trackData = $contextType === 'playlist' ? ($item['track'] ?? null) : $item;
    
            if (!$trackData || !isset($trackData['id'])) {
                continue;
            }
    
            Track::updateOrCreate(
                ['playlist_id' => $newPlaylist->id, 'spotify_id' => $trackData['id']],
                [
                    'title' => $trackData['name'],
                    'duration_ms' => $trackData['duration_ms'] ?? 0,
                    'status' => 'unplayed',
                    'position_ms' => 0,
                ]
            );
        }
    
        $offset += $limit;
    }
    
    

    return response()->json([
        'status' => 'imported',
        'type' => $contextType,
        'playlist' => $newPlaylist,
    ]);
}

public function refresh(\App\Models\Playlist $playlist): int
{
    $token = SpotifyTokenService::getValidAccessToken();

    if (!$token) {
        echo"Hallo";die;
        return 1;
    }
    
    $spotifyId = $playlist->spotify_id;
    $type = $playlist->type;
    $limit = 100;
    $offset = 0;
    $newTracks = 0;

    while (true) {
        $res = Http::withToken($token)->get("https://api.spotify.com/v1/{$type}s/{$spotifyId}/tracks", [
            'limit' => $limit,
            'offset' => $offset,
        ]);

        $items = $res->json('items') ?? [];

        if (count($items) === 0) break;

        foreach ($items as $item) {
            $trackData = $type === 'playlist' ? ($item['track'] ?? null) : $item;

            if (!$trackData || !isset($trackData['id'])) continue;

            $exists = $playlist->tracks()->where('spotify_id', $trackData['id'])->exists();

            if (!$exists) {
                $playlist->tracks()->create([
                    'spotify_id' => $trackData['id'],
                    'title' => $trackData['name'],
                    'duration_ms' => $trackData['duration_ms'] ?? 0,
                    'status' => 'unplayed',
                    'position_ms' => 0,
                ]);
                $newTracks++;
            }
        }

        $offset += $limit;
    }

    $playlist->update(['last_refreshed_at' => now()]);

    return $newTracks;
}


}


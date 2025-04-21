<?php

namespace App\Http\Controllers;

use App\Models\Playlist;
use App\Models\Track;
use Illuminate\Support\Facades\Http;
use App\Services\SpotifyTokenService;

class ImportController extends Controller
{
    public function importCurrent()
    {
        $token = SpotifyTokenService::getValidAccessToken();

        if (!$token) {
            return response()->json(['status' => 'not_authenticated']);
        }

        $response = Http::withToken($token)
            ->get('https://api.spotify.com/v1/me/player/currently-playing');

        if (!$response->ok() || !$response->json('is_playing')) {
            return response()->json(['status' => 'not_playing']);
        }

        $data = $response->json();
        $contextType = $data['context']['type'] ?? null;
        $contextUri = $data['context']['uri'] ?? null;

        if (!$contextUri || !in_array($contextType, ['playlist', 'album'])) {
            return response()->json(['status' => 'not_supported']);
        }

        $spotifyId = str_replace("spotify:$contextType:", '', $contextUri);

        // Existiert schon?
        if (Playlist::where('spotify_id', $spotifyId)->where('type', $contextType)->exists()) {
            return response()->json(['status' => 'already_exists']);
        }

        // Hole Playlist/Album-Metadaten
        $meta = Http::withToken($token)
            ->get("https://api.spotify.com/v1/{$contextType}s/$spotifyId")
            ->json();

        $playlist = Playlist::create([
            'spotify_id' => $spotifyId,
            'title' => $meta['name'],
            'cover_url' => $meta['images'][0]['url'] ?? null,
            'type' => $contextType,
        ]);

        // Hole Tracks
        $tracksResponse = Http::withToken($token)
            ->get("https://api.spotify.com/v1/{$contextType}s/$spotifyId/tracks")
            ->json();

        foreach ($tracksResponse['items'] as $item) {
            $track = $contextType === 'playlist' ? $item['track'] : $item;

            if (!$track || !isset($track['id'])) continue;

            $playlist->tracks()->create([
                'spotify_id' => $track['id'],
                'title' => $track['name'],
                'duration_ms' => $track['duration_ms'],
            ]);
        }

        return response()->json([
            'status' => 'imported',
            'playlist_id' => $playlist->id,
            'title' => $playlist->title,
        ]);
    }
}

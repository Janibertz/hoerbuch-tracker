<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Session;
use App\Models\Playlist;
use App\Models\Track;
use App\Services\SpotifyTokenService;

class TrackingController extends Controller
{
    public function update()
    {
        $token = SpotifyTokenService::getValidAccessToken();
    
        if (!$token) {
            return back()->with('error', 'Kein gültiger Spotify-Token.');
        }
    
        $tokenData = \App\Models\SpotifyToken::find(1);
        $lastTrackId = $tokenData->last_track_id ?? null;
    
        $response = Http::withToken($token)->get('https://api.spotify.com/v1/me/player/currently-playing');
    
        if (!$response->ok() || !$response->json('is_playing')) {
            return response()->json(['status' => 'not_playing']);
        }
    
        $data = $response->json();
        $trackId = $data['item']['id'];
        $progress = $data['progress_ms'];
        $duration = $data['item']['duration_ms'];
        $context = $data['context']['uri'] ?? null;
        $contextType = $data['context']['type'] ?? null;
    
        if (!$context || !in_array($contextType, ['playlist', 'album'])) {
            return response()->json(['status' => 'not_supported_context']);
        }
    
        $spotifyId = str_replace("spotify:$contextType:", '', $context);
    
        // Playlist importieren, falls noch nicht vorhanden
        $playlist = Playlist::where('spotify_id', $spotifyId)
            ->where('type', $contextType)
            ->first();
    
        if (!$playlist) {
            app(\App\Http\Controllers\ImportController::class)->importCurrent();
    
            $playlist = Playlist::where('spotify_id', $spotifyId)
                ->where('type', $contextType)
                ->first();
    
            if (!$playlist) {
                return response()->json(['status' => 'playlist_import_failed']);
            }
        }
    
        $track = Track::where('playlist_id', $playlist->id)
            ->where('spotify_id', $trackId)
            ->first();
    
        // Prüfe, ob wir den vorherigen Track auf 'played' setzen müssen
        if ($lastTrackId && $lastTrackId !== $trackId) {
            $lastTrack = Track::where('playlist_id', $playlist->id)
                ->where('spotify_id', $lastTrackId)
                ->first();
    
            if ($lastTrack && $lastTrack->status !== 'played') {
                if ($lastTrack->position_ms >= $lastTrack->duration_ms * 0.9) {
                    $lastTrack->update(['status' => 'played']);
                }
            }
        }
    
        if ($track) {
            $status = ($progress >= $duration * 0.93) ? 'played' : 'in_progress';
    
            $track->update([
                'position_ms' => $progress,
                'status' => $status,
            ]);
    
            // Speichere aktuellen Track als letzten
            $tokenData->update(['last_track_id' => $trackId]);
    
            return response()->json([
                'status' => 'updated',
                'track' => $track->title,
                'track_id' => $track->spotify_id,
                'progress' => gmdate("i:s", $progress / 1000),
                'duration' => gmdate("i:s", $duration / 1000),
                'played' => $status === 'played',
                'progress_ms' => $progress,
                'duration_ms' => $duration,
            ]);
        }
    
        return response()->json([
            'status' => 'track_not_found'
        ]);
    }

    public function currentTrack()
{
    $token = SpotifyTokenService::getValidAccessToken();
    $lastTrackId = $tokenData->last_track_id ?? null;

    $response = Http::withToken($token)->get('https://api.spotify.com/v1/me/player/currently-playing');

    if (!$response->ok() || !$response->json('is_playing')) {
        return response()->json(['status' => 'not_playing']);
    }

    $data = $response->json();
    $trackId = $data['item']['id'] ?? null;
    $context = $data['context']['uri'] ?? null;
    $contextType = $data['context']['type'] ?? null;

    if (!$trackId || !$context || !in_array($contextType, ['playlist', 'album'])) {
        return response()->json(['status' => 'unsupported_context']);
    }

    $spotifyId = str_replace("spotify:{$contextType}:", '', $context);
    $playlist = \App\Models\Playlist::where('spotify_id', $spotifyId)->where('type', $contextType)->first();

    $justImported = false;

    if (!$playlist) {
        $result = app(\App\Http\Controllers\ImportController::class)->importCurrent();
    
        // danach neu laden
        $playlist = Playlist::where('spotify_id', $spotifyId)
                            ->where('type', $contextType)
                            ->first();
    
        if (!$playlist) {
            return response()->json(['status' => 'playlist_import_failed']);
        }
    
        $justImported = true;
    }

    $track = \App\Models\Track::where('playlist_id', $playlist->id)
        ->where('spotify_id', $trackId)
        ->first();

    if (!$track) {
        return response()->json(['status' => 'track_not_found']);
    }

    return response()->json([
        'status' => 'playing',
        'track_title' => $track->title,
        'playlist_id' => $playlist->id,
        'track_anchor' => $track->spotify_id,
        'just_imported' => $justImported,
        'playlist_title' => $playlist->title,
    ]);
}

}


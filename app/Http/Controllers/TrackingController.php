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

    if (!$token) return; // keine Aktion, kein DB-Call

    $tokenData = \App\Models\SpotifyToken::find(1);
    $lastTrackId = $tokenData->last_track_id ?? null;

    $response = Http::withToken($token)->get('https://api.spotify.com/v1/me/player/currently-playing');

    // ❌ nur weiter, wenn gerade gespielt wird
    if (!$response->ok() || !$response->json('is_playing')) {
        return; // keine Aktion
    }

    $data = $response->json();
    $trackId = $data['item']['id'];
    $progress = $data['progress_ms'];
    $duration = $data['item']['duration_ms'];
    $context = $data['context']['uri'] ?? null;
    $contextType = $data['context']['type'] ?? null;

    if (!$context || !in_array($contextType, ['playlist', 'album'])) return;

    $spotifyId = str_replace("spotify:$contextType:", '', $context);

    // Playlist importieren falls nicht vorhanden
    $playlist = Playlist::firstOrCreate(
        ['spotify_id' => $spotifyId, 'type' => $contextType],
        ['title' => 'Neue Playlist'] // optional
    );

    $track = Track::firstOrCreate(
        ['playlist_id' => $playlist->id, 'spotify_id' => $trackId],
        ['title' => $data['item']['name'], 'duration_ms' => $duration, 'status' => 'unplayed', 'position_ms' => 0]
    );

    // Vorherigen Track ggf. auf 'played' setzen
    if ($lastTrackId && $lastTrackId !== $trackId) {
        $lastTrack = Track::where('playlist_id', $playlist->id)
                          ->where('spotify_id', $lastTrackId)
                          ->first();
        if ($lastTrack && $lastTrack->status !== 'played' && $lastTrack->position_ms >= $lastTrack->duration_ms * 0.9) {
            $lastTrack->update(['status' => 'played']);
        }
    }

    // Status des aktuellen Tracks aktualisieren
    $status = $progress >= $duration * 0.93 ? 'played' : 'in_progress';
    $track->update(['position_ms' => $progress, 'status' => $status]);

    // aktuellen Track als letzten speichern
    $tokenData->update(['last_track_id' => $trackId]);
}


    public function currentTrack()
    {
        $token = SpotifyTokenService::getValidAccessToken();
    
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
    
        // 🔢 Seite berechnen (20 Items pro Seite)
        $trackIds = \App\Models\Track::where('playlist_id', $playlist->id)
            ->orderBy('id')
            ->pluck('spotify_id');
    
        $position = $trackIds->search($track->spotify_id);
        $page = floor($position / 20) + 1;
    
        return response()->json([
            'status' => 'playing',
            'track_title' => $track->title,
            'playlist_id' => $playlist->id,
            'track_anchor' => $track->spotify_id,
            'just_imported' => $justImported,
            'playlist_title' => $playlist->title,
            'page' => $page,
        ]);
    }
    

}


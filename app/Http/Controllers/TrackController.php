<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Session;
use App\Models\Track;
use Illuminate\Http\Request;
use App\Services\SpotifyTokenService;

class TrackController extends Controller
{
    public function resume($id)
    {
        $token = SpotifyTokenService::getValidAccessToken();

        if (!$token) {
            return back()->with('error', 'Kein gültiger Spotify-Token. Bitte erneut verbinden.');
        }

        $devicesResponse = Http::withToken($token)
        ->get('https://api.spotify.com/v1/me/player/devices');
    
    if ($devicesResponse->failed()) {
        // Debug-Ausgabe ins Log
        \Log::error('❌ Geräte-Check fehlgeschlagen', [
            'body' => $devicesResponse->body(),
            'status' => $devicesResponse->status(),
        ]);
    
        return back()->with('error', 'Fehler beim Geräte-Check. Bitte öffne Spotify und starte die Wiedergabe.');
    }
    

$devices = $devicesResponse->json('devices');

$activeDevice = collect($devices)->firstWhere('is_active', true);

// Wenn kein aktives, nimm das erste verfügbare
if (!$activeDevice && count($devices) > 0) {
    $activeDevice = $devices[0]; // z. B. Web Player oder Handy
}

if (!$activeDevice) {
    return back()->with('error', 'Kein Spotify-Gerät gefunden. Bitte starte Spotify auf einem Gerät.');
}

    
        $track = Track::findOrFail($id);
        $playlist = $track->playlist;
    
        $payload = [
            'context_uri' => 'spotify:' . $playlist->type . ':' . $playlist->spotify_id,
            'offset' => [
                'uri' => 'spotify:track:' . $track->spotify_id,
            ],
            'position_ms' => $track->position_ms ?? 0,
        ];
        
        $response = Http::withToken($token)
            ->put('https://api.spotify.com/v1/me/player/play?device_id=' . $activeDevice['id'], $payload);
        
    
        if ($response->status() === 204) {
            return back()->with('status', 'Weiterhören gestartet.');
        }
    
        return back()->with('error', 'Fehler beim Starten: ' . $response->body());
    }

    public function markAsPlayed($id)
{
    $track = \App\Models\Track::findOrFail($id);

    $track->update([
        'status' => 'played',
        'position_ms' => $track->duration_ms,
    ]);

    return back()->with('status', 'Track manuell als gehört markiert.');
}

}


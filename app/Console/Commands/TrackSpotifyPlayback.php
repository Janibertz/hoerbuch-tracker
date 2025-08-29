<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Http;
use App\Services\SpotifyTokenService;
use App\Models\Playlist;
use App\Models\Track;

class TrackSpotifyPlayback extends Command
{
    protected $signature = 'spotify:track';
    protected $description = 'Tracke aktuell gespielten Spotify-Track und aktualisiere Datenbank.';

    public function handle(): void
    {
        $token = SpotifyTokenService::getValidAccessToken();

        if (!$token) {
            $this->info('❌ Kein gültiger Spotify-Token.');
            return;
        }

        // Prüfen, ob gerade ein Track läuft
        $response = Http::withToken($token)->get('https://api.spotify.com/v1/me/player');

        if ($response->status() === 204 || !($response->json('is_playing') ?? false)) {
            $this->info('⏸ Spotify spielt aktuell nichts ab, Job übersprungen.');
            return;
        }

        $playerData = $response->json();
        $currentTrackId = $playerData['item']['id'] ?? null;

        if (!$currentTrackId) {
            $this->info('⏸ Kein Track gefunden, Job übersprungen.');
            return;
        }

        // Playlist und Track finden
        $playlist = Playlist::whereHas('tracks', function ($q) use ($currentTrackId) {
            $q->where('spotify_id', $currentTrackId);
        })->with('tracks')->first();

        if (!$playlist) {
            $this->info("❌ Keine Playlist für Track $currentTrackId gefunden.");
            return;
        }

        $track = $playlist->tracks->firstWhere('spotify_id', $currentTrackId);

        if (!$track) {
            $this->info("❌ Track $currentTrackId nicht gefunden.");
            return;
        }

        // Fortschritt aktualisieren
        $progressMs = $playerData['progress_ms'] ?? 0;
        $track->update([
            'position_ms' => $progressMs,
            'status' => $progressMs / max($track->duration_ms, 1) >= 0.93 ? 'played' : 'in_progress',
        ]);

        $this->info("✅ Track '{$track->title}' aktualisiert (Fortschritt: {$progressMs}ms).");
    }
}

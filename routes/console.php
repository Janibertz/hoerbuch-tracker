<?php

use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Schedule;
use App\Console\Commands\TrackSpotifyPlayback;

/*
|--------------------------------------------------------------------------
| Console Routes
|--------------------------------------------------------------------------
*/

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote');

// Track-Status prüfen und nur bei laufendem Playback ausführen
Schedule::command('spotify:track')
    ->everyFiveSeconds()
    ->before(function () {
        $token = \App\Services\SpotifyTokenService::getValidAccessToken();

        if (!$token) {
            // Kein gültiger Token → Job abbrechen
            return false;
        }

        $response = Http::withToken($token)
            ->get('https://api.spotify.com/v1/me/player');

        if ($response->status() === 204) {
            // Kein aktives Playback
            return false;
        }

        $player = $response->json();

        if (empty($player['is_playing']) || $player['is_playing'] === false) {
            // Kein Track läuft
            return false;
        }

        // Wenn hier alles ok ist → Job wird normal ausgeführt
    });

// Playlist-Refresh weiterhin stündlich
Schedule::command('playlist:refresh-all')->hourly();

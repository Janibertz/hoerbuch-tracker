<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Http\Controllers\TrackingController;

class TrackSpotifyPlayback extends Command
{
    protected $signature = 'spotify:track';
    protected $description = 'Tracke aktuell gespielten Spotify-Track und aktualisiere Datenbank.';

    public function handle(): void
    {
        // TrackingController aufrufen
        app(TrackingController::class)->update();

        $this->info('🎧 Track aktualisiert');
    }
}

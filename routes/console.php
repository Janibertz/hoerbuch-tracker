<?php

use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use App\Console\Commands\TrackSpotifyPlayback;
use Illuminate\Support\Facades\Schedule;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());

    schedule(function () {
        TrackSpotifyPlayback::dispatch();
    })->everyMinute();

})->purpose('Display an inspiring quote');

Schedule::command('spotify:track')->everyFiveSeconds();

Schedule::command('playlist:refresh-all')->everyFiveSeconds();

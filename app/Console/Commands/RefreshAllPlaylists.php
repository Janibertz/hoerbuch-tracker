<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Playlist;
use App\Http\Controllers\SpotifyPlaylistController;

class RefreshAllPlaylists extends Command
{
    protected $signature = 'playlist:refresh-all';
    protected $description = 'Aktualisiert alle Playlists (neue Tracks werden ergänzt)';

    public function handle()
{
    $count = 0;

    $playlists = Playlist::with(['user.spotifyToken'])->get();

    foreach ($playlists as $playlist) {
        if (!$playlist->user || !$playlist->user->spotifyToken) {
            continue;
        }

        auth()->login($playlist->user); // auth-Kontext setzen
        app(SpotifyPlaylistController::class)->refresh($playlist);
        $count++;
    }

    $this->info("🎧 $count Playlists aktualisiert");
}

}

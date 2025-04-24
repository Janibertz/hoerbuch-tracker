<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Playlist;
use App\Models\SpotifyToken;
use App\Services\SpotifyTokenService;
use App\Http\Controllers\SpotifyPlaylistController;

class RefreshAllPlaylists extends Command
{
    protected $signature = 'playlist:refresh-all';
    protected $description = 'Aktualisiert alle Playlists (neue Tracks werden ergänzt)';

    public function handle()
    {
        $updated = 0;

        $token = SpotifyTokenService::getValidAccessToken();

        if (!$token) {
            $this->error('❌ Kein gültiger Spotify-Token gefunden.');
            return;
        }

        $playlists = Playlist::all();

        foreach ($playlists as $playlist) {
            // Optional: Nur unvollständige Playlists updaten
            // if ($playlist->tracks()->count() >= $playlist->total_tracks) continue;

            try {
                $newTracks = app(SpotifyPlaylistController::class)->refresh($playlist);

                if ($newTracks > 0) {
                    $updated++;
                    $this->info("✅ {$playlist->title}: {$newTracks} neue Tracks");
                } else {
                    $this->line("ℹ️ {$playlist->title}: Keine neuen Tracks");
                }
            } catch (\Throwable $e) {
                $this->error("❌ Fehler bei {$playlist->title}: " . $e->getMessage());
            }
        }

        $this->info("🎧 $updated Playlists wurden aktualisiert.");
    }
}

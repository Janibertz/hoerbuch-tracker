<?php
namespace App\Jobs;

use App\Models\User;
use App\Services\SpotifyTokenService;
use Illuminate\Bus\Queueable;
use Illuminate\Support\Facades\Http;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;

class TrackSpotifyPlayback implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public function handle(): void
    {
        // Alle User mit Token durchgehen
        User::with('spotifyToken')->get()->each(function ($user) {
            $token = $user->spotifyToken;

            if (!$token || $token->expires_at->isPast()) {
                return;
            }

            $accessToken = SpotifyTokenService::getValidAccessTokenFor($user);

            if (!$accessToken) {
                return;
            }

            $response = Http::withToken($accessToken)
                ->get('https://api.spotify.com/v1/me/player/currently-playing');

            if (!$response->ok() || !$response->json('is_playing')) {
                return;
            }

            $data = $response->json();
            $trackId = $data['item']['id'] ?? null;
            $progress = $data['progress_ms'];
            $duration = $data['item']['duration_ms'];
            $context = $data['context']['uri'] ?? null;
            $contextType = $data['context']['type'] ?? null;

            if (!$trackId || !$context || !in_array($contextType, ['playlist', 'album'])) {
                return;
            }

            $spotifyId = str_replace("spotify:{$contextType}:", '', $context);

            $playlist = $user->playlists()
                ->where('spotify_id', $spotifyId)
                ->where('type', $contextType)
                ->first();

            if (!$playlist) return;

            $track = $playlist->tracks()
                ->where('spotify_id', $trackId)
                ->first();

            if (!$track) return;

            $status = ($progress >= $duration * 0.93) ? 'played' : 'in_progress';

            $track->update([
                'position_ms' => $progress,
                'status' => $status,
            ]);
        });
    }
}


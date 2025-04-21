<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use App\Models\SpotifyToken;

class SpotifyTokenService
{
    public static function getValidAccessToken(): ?string
    {
        $tokenData = SpotifyToken::find(1);

        if (!$tokenData) {
            return null;
        }

        // Wenn abgelaufen → Token erneuern
        if ($tokenData->expires_at->isPast()) {
            $response = Http::asForm()->post('https://accounts.spotify.com/api/token', [
                'grant_type' => 'refresh_token',
                'refresh_token' => $tokenData->refresh_token,
                'client_id' => env('SPOTIFY_CLIENT_ID'),
                'client_secret' => env('SPOTIFY_CLIENT_SECRET'),
            ]);

            if ($response->failed()) {
                return null; // Fehler beim Erneuern
            }

            $new = $response->json();

            $tokenData->update([
                'access_token' => $new['access_token'],
                'expires_at' => now()->addSeconds($new['expires_in']),
            ]);
        }

        return $tokenData->access_token;
    }
}

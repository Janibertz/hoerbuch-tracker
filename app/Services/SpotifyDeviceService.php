<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;

class SpotifyDeviceService
{
    public static function getActiveDevice(string $token): ?array
    {
        $devicesResponse = Http::withToken($token)
            ->get('https://api.spotify.com/v1/me/player/devices');

        if ($devicesResponse->failed()) {
            \Log::error('❌ Geräte-Check fehlgeschlagen', [
                'body' => $devicesResponse->body(),
                'status' => $devicesResponse->status(),
            ]);
            return null;
        }

        $devices = $devicesResponse->json('devices') ?? [];

        // Erst aktives Gerät suchen, sonst erstes nehmen
        $activeDevice = collect($devices)->firstWhere('is_active', true);
        if (!$activeDevice && count($devices) > 0) {
            $activeDevice = $devices[0];
        }

        return $activeDevice;
    }
}
<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class SpotifyPlayerController extends Controller
{
    public function play(Request $request)
    {
        $token = \App\Services\SpotifyTokenService::getValidAccessToken();
    
        $contextUri = $request->input('context_uri');
        $trackUri = $request->input('track_uri');
        $positionMs = $request->input('position_ms', 0);
    
        if (!$contextUri || !$trackUri) {
            return response()->json(['error' => 'Missing data'], 422);
        }
    
        $response = Http::withToken($token)->put('https://api.spotify.com/v1/me/player/play', [
            'context_uri' => $contextUri,
            'offset' => ['uri' => $trackUri],
            'position_ms' => $positionMs,
        ]);
    
        if ($response->failed()) {
            return response()->json(['error' => 'Spotify API failed'], 500);
        }
    
        return response()->json(['status' => 'started']);
    }
    
}

<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Session;
use App\Models\SpotifyToken;

class SpotifyAuthController extends Controller
{
    public function redirect()
    {
        $query = http_build_query([
            'client_id' => env('SPOTIFY_CLIENT_ID'),
            'response_type' => 'code',
            'redirect_uri' => env('SPOTIFY_REDIRECT_URI'),
            'scope' => 'user-read-playback-state user-read-currently-playing user-modify-playback-state',
        ]);

        return redirect('https://accounts.spotify.com/authorize?' . $query);
    }

    public function callback(Request $request)
    {
        $response = Http::asForm()->post('https://accounts.spotify.com/api/token', [
            'grant_type' => 'authorization_code',
            'code' => $request->code,
            'redirect_uri' => env('SPOTIFY_REDIRECT_URI'),
            'client_id' => env('SPOTIFY_CLIENT_ID'),
            'client_secret' => env('SPOTIFY_CLIENT_SECRET'),
        ]);
    
        $data = $response->json();
    
        // ✅ Speichere den Token dauerhaft
        SpotifyToken::updateOrCreate(
            ['id' => 1],
            [
                'access_token' => $data['access_token'],
                'refresh_token' => $data['refresh_token'],
                'expires_at' => now()->addSeconds($data['expires_in']),
            ]
        );
    
        return redirect('/'); // oder wohin du möchtest
    }
    


}


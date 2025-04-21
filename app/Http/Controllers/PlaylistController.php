<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Playlist;
use App\Models\Track;
use Illuminate\Support\Facades\Http;
use App\Models\SpotifyToken;
use App\Services\SpotifyTokenService;

class PlaylistController extends Controller
{
    public function index()
    {
        $playlists = Playlist::with(['tracks'])->get();

        foreach ($playlists as $playlist) {
            $playlist->total_tracks = $playlist->tracks->count();
            $playlist->played_tracks = $playlist->tracks->where('status', 'played')->count();
            $playlist->progress_percent = $playlist->total_tracks > 0
                ? round(($playlist->played_tracks / $playlist->total_tracks) * 100, 1)
                : 0;
        }
        
        $lastPlayed = Track::where('status', 'in_progress')
    ->orWhere('status', 'played')
    ->orderBy('updated_at', 'desc')
    ->first();

    return view('playlists.index', compact('playlists', 'lastPlayed'));

    }

    public function show($id)
    {
        $playlist = Playlist::with('tracks')->findOrFail($id);
    
        $currentlyPlayingId = null;
    
        $tokenData = SpotifyToken::find(1);
    
        if ($tokenData && $tokenData->expires_at->isFuture()) {
            $token = SpotifyTokenService::getValidAccessToken();
    
            if (!$token) {
                return back()->with('error', 'Kein gültiger Spotify-Token.');
            }
    
            $response = Http::withToken($token)->get('https://api.spotify.com/v1/me/player/currently-playing');
    
            if ($response->ok() && $response->json('is_playing')) {
                $data = $response->json();
                $contextType = $data['context']['type'] ?? null;
                $spotifyId = str_replace("spotify:{$contextType}:", '', $data['context']['uri'] ?? '');
                $trackSpotifyId = $data['item']['id'] ?? null;
    
                if ($spotifyId === $playlist->spotify_id) {
                    $currentlyPlayingId = $trackSpotifyId;
                }
            }
        }
    
        // 🔥 HIER: Nächster noch nicht vollständig gehörter Track
        $nextTrack = $playlist->tracks
            ->where('status', '!=', 'played')
            ->sortBy('id')
            ->first();
    
        return view('playlists.show', compact('playlist', 'currentlyPlayingId', 'nextTrack'));
    }

    public function resume(Request $request, Playlist $playlist){
        $token = SpotifyTokenService::getValidAccessToken();

        $nextTrack = $playlist->tracks()
            ->where('status', '!=', 'played')
            ->orderBy('id')
            ->first();

        if (!$nextTrack) {
            return back()->with('error', 'Alle Titel wurden bereits gehört.');
        }

        $response = Http::withToken($token)->put('https://api.spotify.com/v1/me/player/play', [
            'context_uri' => "spotify:{$playlist->type}:{$playlist->spotify_id}",
            'offset' => ['uri' => "spotify:track:{$nextTrack->spotify_id}"],
            'position_ms' => $nextTrack->position_ms ?? 0
        ]);

        if ($response->failed()) {
            \Log::error('❌ Spotify-Start fehlgeschlagen', [
                'status' => $response->status(),
                'body' => $response->body(),
            ]);
        
            return back()->with('error', 'Spotify konnte nicht gestartet werden.');
        }
        

        return back()->with('status', '🎧 Wiedergabe gestartet!');
    }
}

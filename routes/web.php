<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\SpotifyAuthController;
use App\Http\Controllers\SpotifyPlaylistController;
use App\Http\Controllers\PlaylistController;
use App\Http\Controllers\TrackController;
use App\Http\Controllers\ImportController;

Route::get('/', [PlaylistController::class, 'index']);
Route::get('/auth/spotify', [SpotifyAuthController::class, 'redirect']);
Route::get('/callback', [SpotifyAuthController::class, 'callback']);
Route::get('/import-current-playlist', [SpotifyPlaylistController::class, 'checkAndImport']);
Route::get('/playlist/{playlist}', [PlaylistController::class, 'show']);
Route::get('/api/track-status', [\App\Http\Controllers\TrackingController::class, 'update']);
Route::post('/track/{id}/resume', [TrackController::class, 'resume'])->name('track.resume');
Route::post('/track/{id}/mark-played', [TrackController::class, 'markAsPlayed'])->name('track.markPlayed');
Route::get('/api/current-track-footer', [\App\Http\Controllers\TrackingController::class, 'currentTrack']);
Route::get('/import-current-playlist', [ImportController::class, 'importCurrent']);
Route::post('/playlist/{playlist}/resume', [PlaylistController::class, 'resume'])->name('playlist.resume');





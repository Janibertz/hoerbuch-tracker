<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Track extends Model
{
    protected $fillable = ['playlist_id', 'spotify_id', 'title', 'duration_ms', 'position_ms', 'status'];

    public function playlist()
    {
        return $this->belongsTo(Playlist::class);
    }
}


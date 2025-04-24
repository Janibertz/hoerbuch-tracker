<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Playlist extends Model
{
    protected $fillable = ['spotify_id', 'title', 'cover_url', 'total_tracks', 'type'];

    public function tracks()
    {
        return $this->hasMany(Track::class);
    }

    public function user()
{
    return $this->belongsTo(User::class);
}
}

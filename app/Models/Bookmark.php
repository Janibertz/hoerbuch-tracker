<?php

use Illuminate\Database\Eloquent\Model;

class Bookmark extends Model
{
    protected $fillable = [
        'track_name',
        'track_id',
        'position_ms',
        'playlist_id',
        'tracked_at',
    ];
}

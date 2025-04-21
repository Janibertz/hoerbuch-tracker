<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('playlists', function (Blueprint $table) {
            $table->id();
            $table->string('spotify_id')->unique();
            $table->string('title');
            $table->string('cover_url')->nullable();
            $table->integer('total_tracks')->default(0);
            $table->timestamps();
            $table->enum('type', ['playlist', 'album'])->default('playlist');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('playlists');
    }
};

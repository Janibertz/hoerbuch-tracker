<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('bookmarks', function (Blueprint $table) {
            $table->id();
            $table->string('track_name');
            $table->string('track_id');
            $table->integer('position_ms'); // Position im Track in Millisekunden
            $table->string('playlist_id')->nullable(); // z. B. für dein Hörbuch
            $table->timestamp('tracked_at');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('bookmarks');
    }
};

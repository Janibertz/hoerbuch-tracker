@extends('layouts.app')

@section('title', 'Meine Hörbücher')

@section('content')

<div class="container mx-auto px-4 py-6">
    <h1 class="text-3xl font-bold mb-6">🎧 Deine Hörbuch-Playlists</h1>

    @if($lastPlayed)
    <div class="bg-yellow-100 border-l-4 border-yellow-500 text-yellow-900 p-4 rounded mb-6">
        <p class="font-semibold">🎧 Zuletzt gehört:</p>
        <p class="text-lg">{{ $lastPlayed->title }}</p>
        <p class="text-sm text-gray-600">
            (am {{ $lastPlayed->updated_at->format('d.m.Y \u\m H:i') }})
        </p>
        <a href="{{ url('/playlist/'.$lastPlayed->playlist_id.'#track-'.$lastPlayed->spotify_id) }}"
           class="inline-block mt-2 text-sm text-blue-600 hover:underline">
            👉 Weiterhören
        </a>
    </div>
@endif


    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
        @foreach($playlists as $playlist)
            <a href="{{ url('/playlist/'.$playlist->id) }}" class="bg-white rounded-lg shadow hover:shadow-lg transition p-4 block">
                <img src="{{ $playlist->cover_url }}" alt="{{ $playlist->title }}" class="w-full h-48 object-cover rounded">
                <h2 class="mt-4 text-lg font-semibold">{{ $playlist->title }}</h2>
                <p class="text-sm text-gray-500">
                    🎧 {{ $playlist->played_tracks }} / {{ $playlist->total_tracks }} Kapitel gehört ({{ $playlist->progress_percent }} %)
                </p>
                <div class="w-full bg-gray-200 h-2 rounded mt-2 overflow-hidden">
                    <div class="bg-green-500 h-full transition-all"
                         style="width: {{ $playlist->progress_percent }}%">
                    </div>
                </div>
            </a>
        @endforeach
    </div>
</div>
@endsection

@extends('layouts.app')

@section('title', 'Deine Playlists')

@section('content')
    <h1 class="text-2xl sm:text-3xl font-bold mb-6">🎧 Deine Hörbuch-Playlists</h1>

    @if($lastPlayed)
        <div class="bg-yellow-50 border-l-4 border-yellow-400 p-4 rounded-lg mb-6 shadow-sm">
            <p class="font-semibold text-yellow-900">🎧 Zuletzt gehört: {{ $lastPlayed->title }}</p>
            <p class="text-sm text-gray-600">(am {{ $lastPlayed->updated_at->format('d.m.Y \u\m H:i') }})</p>
            <a href="{{ url('/playlist/'.$lastPlayed->playlist_id.'?page='.$page.'#track-'.$lastPlayed->spotify_id) }}"
               class="inline-block mt-2 text-sm text-blue-600 hover:underline">
                👉 Weiterhören
            </a>
        </div>
    @endif

    <div class="grid gap-6 grid-cols-1 sm:grid-cols-2 lg:grid-cols-3">
        @foreach($playlists as $playlist)
            <div class="bg-white rounded-lg shadow hover:shadow-md transition overflow-hidden flex flex-col">
                <img src="{{ $playlist->cover_url }}" alt="{{ $playlist->title }}" class="w-full h-48 object-cover">
                <div class="p-4 flex flex-col flex-grow">
                    <h2 class="text-lg font-semibold text-gray-800 mb-1 line-clamp-2">{{ $playlist->title }}</h2>
                    <p class="text-sm text-gray-500">
                        🎧 {{ $playlist->played_tracks }} / {{ $playlist->total_tracks }} Kapitel gehört
                        ({{ $playlist->progress_percent }} %)
                    </p>
                    <div class="w-full bg-gray-200 h-2 rounded mt-2 mb-4">
                        <div class="bg-green-500 h-2 rounded" style="width: {{ $playlist->progress_percent }}%"></div>
                    </div>
                    <a href="/playlist/{{ $playlist->id }}"
                       class="mt-auto inline-flex justify-center items-center bg-blue-600 hover:bg-blue-700 text-white text-sm px-4 py-2 rounded transition">
                        ➡️ Öffnen
                    </a>
                </div>
            </div>
        @endforeach
    </div>
@endsection

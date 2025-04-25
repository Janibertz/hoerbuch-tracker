@extends('layouts.app')

@section('title', 'Deine Playlists')

@section('content')
    <h1 class="text-2xl sm:text-3xl font-bold mb-6 text-gray-900 dark:text-white">🎧 Deine Hörbuch-Playlists</h1>

    @if($lastPlayed)
        <div class="bg-yellow-50 dark:bg-yellow-100/10 border-l-4 border-yellow-400 p-4 rounded-lg mb-6 shadow-sm">
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-2">
                <div>
                    <p class="text-sm font-semibold text-yellow-800 dark:text-yellow-300">🎧 Zuletzt gehört:</p>
                    <p class="text-base font-medium text-gray-800 dark:text-gray-200 line-clamp-2">
                        {{ $lastPlayed->title }}
                    </p>
                    <p class="text-xs text-gray-500 dark:text-gray-400">
                        am {{ $lastPlayed->updated_at->format('d.m.Y \u\m H:i') }}
                    </p>
                </div>
                <div class="sm:text-right">
                    <a href="{{ url('/playlist/'.$lastPlayed->playlist_id.'?page='.$page.'#track-'.$lastPlayed->spotify_id) }}"
                       class="inline-block mt-2 sm:mt-0 bg-yellow-500 hover:bg-yellow-600 text-white text-sm px-4 py-2 rounded transition">
                        👉 Weiterhören
                    </a>
                </div>
            </div>
        </div>
    @endif

    <div class="grid gap-6 grid-cols-1 sm:grid-cols-2 lg:grid-cols-3">
        @foreach($playlists as $playlist)
            <div class="bg-white dark:bg-gray-800 rounded-lg shadow hover:shadow-md transition overflow-hidden flex flex-col">
                <img src="{{ $playlist->cover_url }}" alt="{{ $playlist->title }}" class="w-full h-48 object-cover">
                <div class="p-4 flex flex-col flex-grow">
                    <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100 mb-1 line-clamp-2">{{ $playlist->title }}</h2>
                    <p class="text-sm text-gray-500 dark:text-gray-400">
                        🎧 {{ $playlist->played_tracks }} / {{ $playlist->total_tracks }} Kapitel gehört
                        ({{ $playlist->progress_percent }} %)
                    </p>
                    <div class="w-full bg-gray-200 dark:bg-gray-700 h-2 rounded mt-2 mb-4">
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

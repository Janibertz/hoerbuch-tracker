@extends('layouts.app')

@section('title', $playlist->title)

@section('content')
<div class="max-w-5xl mx-auto px-4 py-6 space-y-6">

    <a href="/" class="text-sm text-blue-600 hover:underline block dark:text-blue-400">← Zurück zur Übersicht</a>

    {{-- Header --}}
    <div class="flex flex-col sm:flex-row items-start sm:items-center gap-4">
        <img src="{{ $playlist->cover_url }}" alt="{{ $playlist->title }}" class="w-28 h-28 rounded shadow object-cover">
        <div>
            <h1 class="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white">{{ $playlist->title }}</h1>
            <p class="text-sm text-gray-500 dark:text-gray-400 mt-1">{{ $playlist->tracks->count() }} Kapitel</p>
            @if($playlist->last_refreshed_at)
                <p class="text-sm text-gray-400 mt-1">
                    🔄 Zuletzt aktualisiert: {{ $playlist->last_refreshed_at->diffForHumans() }}
                </p>
            @endif
        </div>
    </div>

    {{-- Aktionen --}}
    <div class="flex flex-wrap gap-3">
        <form action="{{ route('playlist.refresh', $playlist->id) }}" method="POST">
            @csrf
            <button class="inline-flex items-center px-4 py-2 rounded bg-blue-600 text-white text-sm hover:bg-blue-700 transition">
                🔁 Playlist aktualisieren
            </button>
        </form>

        @if($nextTrack)
            <form action="{{ route('playlist.resume', $playlist->id) }}" method="POST">
                @csrf
                <button class="inline-flex items-center px-4 py-2 rounded bg-green-600 text-white text-sm hover:bg-green-700 transition">
                    ▶️ Weiterhören ab „{{ $nextTrack->title }}“
                </button>
            </form>
        @else
            <div class="text-sm italic text-gray-500 dark:text-gray-400">Alle Titel gehört 🎉</div>
        @endif
    </div>

    {{-- Feedback --}}
    @if(session('error'))
        <div class="bg-red-100 border border-red-400 text-red-700 p-4 rounded dark:bg-red-900 dark:text-red-200">
            {{ session('error') }}
        </div>
    @endif

    @if(session('status'))
        <div class="bg-green-100 border border-green-400 text-green-700 p-4 rounded dark:bg-green-900 dark:text-green-200">
            {{ session('status') }}
        </div>
    @endif

    {{-- Tabelle --}}
    <div class="overflow-x-auto bg-white dark:bg-gray-800 rounded-lg shadow text-sm">
        <table class="min-w-full text-left">
            <thead class="bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300 uppercase text-xs">
                <tr>
                    <th class="px-4 py-3">#</th>
                    <th class="px-4 py-3">Titel</th>
                    <th class="px-4 py-3">Status</th>
                    <th class="px-4 py-3">Position</th>
                    <th class="px-4 py-3"></th>
                    <th class="px-4 py-3"></th>
                </tr>
            </thead>
            <tbody>
                @foreach($tracks as $index => $track)
                    @php
                        $isNew = $track->created_at->gt(now()->subHours(1));
                        $highlight = $track->spotify_id === $currentlyPlayingId;
                    @endphp
                    <tr id="track-{{ $track->spotify_id }}"
                        class="border-t border-gray-200 dark:border-gray-700 {{ $highlight ? 'bg-yellow-50 dark:bg-yellow-900/20 font-semibold' : ($isNew ? 'bg-green-50 dark:bg-green-900/10' : '') }} hover:bg-gray-50 dark:hover:bg-gray-700 transition">
                        <td class="px-4 py-2 font-mono text-gray-600 dark:text-gray-300">{{ $tracks->firstItem() + $index }}</td>
                        <td class="px-4 py-2 text-gray-800 dark:text-gray-100">{{ $track->title }}</td>
                        <td class="px-4 py-2 status-cell">
                            @if($isNew)
                                🆕 <span class="text-green-600 font-semibold dark:text-green-300">Neu</span>
                            @elseif($track->status === 'played')
                                ✅ <span class="text-green-700 dark:text-green-300">Gespielt</span>
                            @elseif($track->status === 'in_progress')
                                ⏯ <span class="text-yellow-600 dark:text-yellow-300">Angefangen</span>
                            @else
                                ◻️ <span class="text-gray-600 dark:text-gray-300">Ungespielt</span>
                            @endif
                        </td>
                        <td class="px-4 py-2 position-cell text-gray-600 dark:text-gray-400">
                            @if($track->position_ms)
                                {{ gmdate("i:s", $track->position_ms / 1000) }} / {{ gmdate("i:s", $track->duration_ms / 1000) }}
                            @else
                                —
                            @endif
                        </td>
                        <td class="px-4 py-2">
                            @if($track->status === 'in_progress')
                                <form action="{{ route('track.resume', $track->id) }}" method="POST">
                                    @csrf
                                    <button class="text-green-600 hover:underline dark:text-green-300 text-sm">▶️ Weiterhören</button>
                                </form>
                            @endif
                        </td>
                        <td class="px-4 py-2">
                            @if($track->status !== 'played')
                                <form action="{{ route('track.markPlayed', $track->id) }}" method="POST">
                                    @csrf
                                    <button class="text-blue-600 hover:underline dark:text-blue-400 text-sm">✅ Markieren</button>
                                </form>
                            @else
                                <span class="text-green-600 dark:text-green-400 text-sm">Gehört</span>
                            @endif
                        </td>
                    </tr>
                @endforeach
            </tbody>
        </table>
    </div>

    {{-- Pagination --}}
    <div class="mt-6">
        {{ $tracks->onEachSide(1)->links('pagination::tailwind') }}
    </div>

    {{-- Löschen --}}
    <form action="{{ route('playlist.destroy', $playlist->id) }}" method="POST"
        onsubmit="return confirm('Bist du sicher, dass du die Playlist löschen möchtest?');" class="mt-6">
        @csrf
        @method('DELETE')
        <button class="inline-flex items-center px-4 py-2 rounded bg-red-600 text-white text-sm hover:bg-red-700 transition shadow">
            🗑 Playlist löschen
        </button>
    </form>
</div>

@push('scripts')
<script>
    function updateTrackStatus() {
        fetch('/api/track-status')
            .then(res => res.json())
            .then(data => {
                if (data.status === 'updated') {
                    const row = document.getElementById(`track-${data.track_id}`);
                    if (!row) return;
                    const statusCell = row.querySelector('.status-cell');
                    const positionCell = row.querySelector('.position-cell');
                    const quote = data.progress_ms / data.duration_ms;

                    statusCell.textContent = quote >= 0.93 ? '✅ Gespielt' : '⏯ Angefangen';
                    positionCell.textContent = `${data.progress} / ${data.duration}`;
                }
            });
    }

    updateTrackStatus();
    setInterval(updateTrackStatus, 5000);
</script>
@endpush
@endsection

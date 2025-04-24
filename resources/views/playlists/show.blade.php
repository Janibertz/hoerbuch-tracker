@extends('layouts.app')

@section('title', $playlist->title)

@section('content')
<div class="container mx-auto px-4 py-6">

    <a href="/" class="text-blue-600 hover:underline mb-4 inline-block">← Zurück</a>

    <div class="flex items-center space-x-4 mb-6">
        <img src="{{ $playlist->cover_url }}" alt="{{ $playlist->title }}" class="w-32 h-32 object-cover rounded">
        <div>
            <h1 class="text-3xl font-bold">{{ $playlist->title }}</h1>
            <p class="text-gray-500">{{ $playlist->tracks->count() }} Kapitel</p>
        </div>
    </div>

    @if($playlist->last_refreshed_at)
    <p class="text-sm text-gray-500 mb-2">
        🔄 Zuletzt aktualisiert: {{ $playlist->last_refreshed_at->diffForHumans() }}
    </p>
@endif




    <form action="{{ route('playlist.refresh', $playlist->id) }}" method="POST" class="inline-block mb-4">
        @csrf
        <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded shadow hover:bg-blue-700">
            🌀 Playlist aktualisieren
        </button>
    </form>

    

    @if($nextTrack)
    <form action="{{ route('playlist.resume', $playlist->id) }}" method="POST">
        @csrf
        <button type="submit"
            class="bg-green-600 text-white px-4 py-2 rounded shadow hover:bg-green-700">
            ▶️ Weiterhören ab "{{ $nextTrack->title }}"
        </button>
    </form>
@else
    <div class="text-gray-500 italic">Alle Titel gehört 🎉</div>
@endif

    @if(session('error'))
    <div class="bg-red-100 text-red-800 p-4 rounded mb-4">
        {{ session('error') }}
    </div>
@endif

@if(session('status'))
    <div class="bg-green-100 text-green-800 p-4 rounded mb-4">
        {{ session('status') }}
    </div>
@endif

    <div class="bg-white rounded-lg shadow overflow-hidden">
        <table class="w-full table-auto text-sm">
            <thead class="bg-gray-100 text-left">
                <tr>
                    <th class="px-4 py-2">#</th>
                    <th class="px-4 py-2">Titel</th>
                    <th class="px-4 py-2">Status</th>
                    <th class="px-4 py-2">Position</th>
                    <th class="px-4 py-2"></th>
                    <th class="px-4 py-2"></th>
                </tr>
            </thead>
            <tbody>
                @foreach($playlist->tracks as $index => $track)
                    @php
                        $isNew = $track->created_at->gt(now()->subHours(1));
                    @endphp
                    <tr id="track-{{ $track->spotify_id }}"class="border-t {{ $isNew ? 'bg-green-50' : '' }} {{ $track->spotify_id === $currentlyPlayingId ? 'bg-yellow-100 font-semibold' : '' }}">
                        <td class="px-4 py-2">{{ $index + 1 }}</td>
                        <td class="px-4 py-2">{{ $track->title }}</td>
                        <td class="px-4 py-2 status-cell">
                            @if($isNew)
                                🆕 <span class="text-green-600 font-semibold">Neu</span>
                            @elseif($track->status === 'played')
                                ✅ Gespielt
                            @elseif($track->status === 'in_progress')
                                ⏯ Angefangen
                            @else
                                ◻️ Ungespielt
                            @endif
                        </td>
                        <td class="px-4 py-2 position-cell">
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
                                    <button type="submit"
                                        class="bg-green-500 text-white text-xs px-2 py-1 rounded hover:bg-green-600 transition">
                                        ▶️ Weiterhören
                                    </button>
                                </form>
                            @endif
                        </td>
                        <td class="px-4 py-2">
                            @if($track->status !== 'played')
                                <form action="{{ route('track.markPlayed', $track->id) }}" method="POST">
                                    @csrf
                                    <button type="submit"
                                        class="text-sm text-blue-600 hover:underline">
                                        ✅ Markieren
                                    </button>
                                </form>
                            @else
                                <span class="text-green-600 text-sm">Gehört</span>
                            @endif
                        </td>
                    </tr>
                @endforeach
            </tbody>
        </table>
    </div>

    <form action="{{ route('playlist.destroy', $playlist->id) }}" class="inline-block mt-4" method="POST" onsubmit="return confirm('Bist du sicher, dass du die Playlist löschen möchtest?');">
        @csrf
        @method('DELETE')
        <button type="submit"
            class="bg-red-600 text-white px-4 py-2 rounded shadow hover:bg-red-700">
            🗑 Playlist löschen
        </button>
    </form>
</div>



<script>
    console.log("🎬 Tracking-Skript aktiv");

    function updateTrackStatus() {
        console.log("📡 Starte API-Call");
        fetch('/api/track-status')
            .then(res => res.json())
            .then(data => {
                console.log("✅ API-Antwort:", data);

                if (data.status === 'updated') {
const trackId = data.track_id;
const played = data.played;
const progress = data.progress;
const duration = data.duration;
const progressMs = data.progress_ms;
const durationMs = data.duration_ms;

const row = document.getElementById(`track-${trackId}`);
if (row) {
    const statusCell = row.querySelector('.status-cell');
    const positionCell = row.querySelector('.position-cell');

    // Rechne prozentual
    const quote = progressMs / durationMs;

    if (quote >= 0.93) {
        statusCell.textContent = '✅ Gespielt';
    } else {
        statusCell.textContent = '⏯ Angefangen';
    }

    positionCell.textContent = `${progress} / ${duration}`;
}
}
            });
    }

    updateTrackStatus();
    setInterval(updateTrackStatus, 5000);

    
</script>

@endsection



    

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>@yield('title', 'Spotify Tracker')</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    {{-- Tailwind --}}
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 text-gray-900">

    <div class="min-h-screen pb-16">
        
        @yield('content')
    </div>

    {{-- Footer --}}
    <footer class="fixed bottom-0 w-full bg-white shadow-md p-3 text-sm text-gray-700 z-50">
        <div id="import-notification"
        class="fixed bottom-20 right-4 bg-white border border-green-400 text-green-800 shadow-lg px-4 py-3 rounded-lg hidden z-50">
        </div>

        <div class="fixed bottom-0 left-0 right-0 bg-white shadow-lg border-t p-3 z-50 flex justify-between items-center text-sm">
            <div id="footer-now-playing" class="text-gray-800">
                🎧 Lade aktuell gespielten Titel…
            </div>
        </div>
        
        
    
    </footer>

    <script>
        
        setInterval(() => {
        fetch('/api/track-status')
        .then(response => response.json())
        .then(data => {
            console.log('🎧 Tracking update', data);
        });
}, 5000); // alle 15 Sekunden
        function updateFooterTrack() {
            fetch('/api/current-track-footer')
                .then(res => res.json())
                .then(data => {
                    const el = document.getElementById('footer-now-playing');

                    if (data.status === 'playing') {
    const el = document.getElementById('footer-now-playing');
    el.innerHTML = `🎧 Jetzt läuft: <strong>${data.track_title}</strong> 
        <a href="/playlist/${data.playlist_id}#track-${data.track_anchor}" class="text-blue-600 underline ml-2">
            → zum Track
        </a>`;

    if (data.just_imported) {
        showImportNotification(data.playlist_title, data.playlist_id);
    }
}
 else {
                        el.innerHTML = '';
                    }
                });
        }
        function showImportNotification(title, playlistId) {
    const el = document.getElementById('import-notification');
    el.innerHTML = `
        🎧 Neue Playlist importiert: <strong>${title}</strong><br>
        <a href="/playlist/${playlistId}" class="text-blue-600 underline">🡆 Zur Playlist</a>
    `;
    el.classList.remove('hidden');

    setTimeout(() => {
        el.classList.add('hidden');
    }, 5000);
}

        setInterval(updateFooterTrack, 5000);
        updateFooterTrack();



    </script>

</body>
</html>

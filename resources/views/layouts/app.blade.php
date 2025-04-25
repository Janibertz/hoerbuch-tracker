<!DOCTYPE html>
<html lang="de" class="">
    <head>
        <meta charset="UTF-8">
        <meta name="csrf-token" content="{{ csrf_token() }}">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>@yield('title', 'Hörbuch Tracker')</title>
        <script src="https://cdn.tailwindcss.com"></script>
        {{-- ✅ Tailwind Darkmode aktivieren --}}
        <script>
            tailwind.config = {
                darkMode: 'class'
            };
        </script>
     
    
        {{-- Optional: Flowbite UI --}}
        <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.js"></script>
    </head>
    
<body class="bg-gray-100 text-gray-900 min-h-screen flex flex-col">

{{-- Kein Menü nötig – nur Logo --}}
<nav class="bg-white shadow-md sticky top-0 z-50 dark:bg-gray-900 dark:text-white">
    <div class="max-w-screen-lg mx-auto px-4 py-3 flex justify-between items-center">
        <a href="/" class="text-lg font-bold">📚 Hörbuch-Tracker</a>

        {{-- Darkmode Toggle --}}
        <button onclick="toggleDarkMode()"
        class="text-sm px-3 py-1 bg-gray-200 dark:bg-gray-800 dark:text-white rounded hover:bg-gray-300 dark:hover:bg-gray-700 transition">
    🌓 Modus wechseln
</button>

    </div>
</nav>

    {{-- ✅ Hauptbereich --}}
    <main class="flex-grow max-w-screen-lg mx-auto px-4 py-6 w-full">
        @yield('content')
    </main>

    {{-- ✅ Footer --}}
    <footer class="bg-white border-t text-sm text-gray-600">
        <div class="max-w-screen-lg mx-auto px-4 py-3 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-2">
            <span>&copy; {{ date('Y') }} Hörbuch Tracker</span>
            <span id="footer-now-playing" class="text-sm">
                🎧 Aktuell keine Wiedergabe
            </span>
        </div>
    </footer>

    {{-- ✅ Notification-Box mobil & sticky --}}
    <div id="import-notification"
         class="fixed bottom-20 right-4 max-w-[90vw] sm:max-w-sm bg-green-100 border border-green-400 text-green-800 p-4 rounded-lg shadow z-50 hidden">
    </div>

    {{-- Scripts --}}
    @stack('scripts')

    <script>
    // Beim Laden Darkmode prüfen
    if (localStorage.getItem('theme') === 'dark' ||
        (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        document.documentElement.classList.add('dark');
    } else {
        document.documentElement.classList.remove('dark');
    }

    // Umschalter
    function toggleDarkMode() {
        const html = document.documentElement;
        if (html.classList.contains('dark')) {
            html.classList.remove('dark');
            localStorage.setItem('theme', 'light');
        } else {
            html.classList.add('dark');
            localStorage.setItem('theme', 'dark');
        }
    }
        function updateFooterTrack() {
            fetch('/api/current-track-footer')
                .then(res => res.json())
                .then(data => {
                    const el = document.getElementById('footer-now-playing');
                    if (data.status === 'playing') {
                        el.innerHTML = `🎧 Jetzt läuft: <strong>${data.track_title}</strong>
                            <a href="/playlist/${data.playlist_id}?page=${data.page}#track-${data.track_anchor}" class="text-blue-600 underline ml-2">
                                → zum Track
                            </a>`;
                        if (data.just_imported) {
                            showImportNotification(data.playlist_title, data.playlist_id);
                        }
                    } else {
                        el.innerHTML = '🎧 Aktuell keine Wiedergabe';
                    }
                });
        }

        function showImportNotification(title, playlistId) {
            const el = document.getElementById('import-notification');
            el.innerHTML = `🎧 Neue Playlist importiert: <strong>${title}</strong><br>
                <a href="/playlist/${playlistId}" class="text-blue-600 underline">🡆 Zur Playlist</a>`;
            el.classList.remove('hidden');
            setTimeout(() => el.classList.add('hidden'), 5000);
        }

        updateFooterTrack();
        setInterval(updateFooterTrack, 5000);
    </script>
</body>
</html>

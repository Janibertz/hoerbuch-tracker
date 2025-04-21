-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 21, 2025 at 01:02 PM
-- Server version: 8.4.3
-- PHP Version: 8.3.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hoerbuch_tracker`
--
CREATE DATABASE IF NOT EXISTS `hoerbuch_tracker` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `hoerbuch_tracker`;

-- --------------------------------------------------------

--
-- Table structure for table `bookmarks`
--

DROP TABLE IF EXISTS `bookmarks`;
CREATE TABLE `bookmarks` (
  `id` bigint UNSIGNED NOT NULL,
  `track_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `track_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position_ms` int NOT NULL,
  `playlist_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tracked_at` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_04_20_083404_create_bookmarks_table', 2),
(5, '2025_04_20_083640_create_playlists_table', 3),
(6, '2025_04_20_083701_create_tracks_table', 3),
(7, '2025_04_20_090950_add_type_to_playlists_table', 4),
(8, '2025_04_20_144219_create_spotify_tokens_table', 5),
(9, '2025_04_20_162744_add_last_track_to_spotify_tokens', 6);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `playlists`
--

DROP TABLE IF EXISTS `playlists`;
CREATE TABLE `playlists` (
  `id` bigint UNSIGNED NOT NULL,
  `spotify_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cover_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_tracks` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `type` enum('playlist','album') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'playlist'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `playlists`
--

INSERT INTO `playlists` (`id`, `spotify_id`, `title`, `cover_url`, `total_tracks`, `created_at`, `updated_at`, `type`) VALUES
(1, '6Zy4yDpVXE0FwlmJlTWf0Q', 'Die Tribute von Panem 1-4', 'https://i.scdn.co/image/ab67616d00001e02a6dfa85b015658508da60003', 835, '2025-04-20 06:40:09', '2025-04-20 06:40:09', 'playlist'),
(2, '14LoQiYL6JcauKtTQ715LM', 'Die Tribute von Panem 1. Tödliche Spiele', 'https://i.scdn.co/image/ab67616d0000b273a6dfa85b015658508da60003', 50, '2025-04-20 07:10:16', '2025-04-20 07:10:16', 'album'),
(3, '5e6XxV3vhHhdfqcjXScH8o', 'Die drei ??? - Die drei Fragezeichen - Alle Hörspiele', 'https://image-cdn-ak.spotifycdn.com/image/ab67706c0000d72c5fef89f4ab96e03d0905aef2', 9374, '2025-04-20 14:11:19', '2025-04-20 14:11:19', 'playlist'),
(4, '3VxdE9j9mip6Lmi5o0lDxo', 'Folge 236: Schatten aus der Unterwelt (Das Hörspiel zur Live-Tour)', 'https://i.scdn.co/image/ab67616d0000b273c8f0f95dc726a51bd3d1efdd', 0, '2025-04-20 14:18:30', '2025-04-20 14:18:30', 'album'),
(5, '1Jo9IBsdi9pT0JpOysxqvQ', 'TKKG - Alle Hörspiele', 'https://image-cdn-ak.spotifycdn.com/image/ab67706c0000d72c7d84f6b989c90c6848590a70', 0, '2025-04-20 14:22:37', '2025-04-20 14:22:37', 'playlist'),
(6, '4Svj4QOskKxVSAL8VirAiG', 'Captain America: The First Avenger (Hörspiel zum Marvel Film)', 'https://i.scdn.co/image/ab67616d0000b273e7e09d0f98d049da3e1eb7e8', 0, '2025-04-20 16:37:20', '2025-04-20 16:37:20', 'album');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('uIBxOFioDDAbzC5JBayNAPEgZFCfIUsBE0ed4GML', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNGVLMkd6ZzhLa0o5VGwwOHkzVjhtaXZyM1cxdVJ1QldsNGk2ZTl4NyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hcGkvdHJhY2stc3RhdHVzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1745240526);

-- --------------------------------------------------------

--
-- Table structure for table `spotify_tokens`
--

DROP TABLE IF EXISTS `spotify_tokens`;
CREATE TABLE `spotify_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `access_token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `refresh_token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `last_track_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `spotify_tokens`
--

INSERT INTO `spotify_tokens` (`id`, `access_token`, `refresh_token`, `expires_at`, `created_at`, `updated_at`, `last_track_id`) VALUES
(1, 'BQAN8fhfUi0Z9INWNjS-VjNvr_yBT5OL0vwP5AHxKN5ZQsDo2KfRrq8zA2f0yMiMC0Rg5AaCfdhvD2p0KLO-7yPg2QO_aPLFXj2SpAvDXUFOyCq0HqSDJSltdiN83cjB1hHb6f3tGgI6yMmCcREihNlfnD6fHQZ-K6YeFbPz8yh1SnDyn1DeDcDyOhNtJc9qtShBcwvwquEEGBmgKhXQxqM3joDh7L4', 'AQCIO7J0oXxiwixFF29ZbShKiYwbsQ0uxLnqO_n3l-9-DC8voUMeywxqiN_Va0XcRRvUW3NIgbeUJlUjtcHYGkSArzGqzihFk25Itvax-7UO1Xo3N60SxiouIJCGH1crazU', '2025-04-21 13:11:06', '2025-04-20 12:47:42', '2025-04-21 12:11:06', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tracks`
--

DROP TABLE IF EXISTS `tracks`;
CREATE TABLE `tracks` (
  `id` bigint UNSIGNED NOT NULL,
  `playlist_id` bigint UNSIGNED NOT NULL,
  `spotify_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration_ms` int NOT NULL,
  `position_ms` int DEFAULT NULL,
  `status` enum('unplayed','in_progress','played') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unplayed',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tracks`
--

INSERT INTO `tracks` (`id`, `playlist_id`, `spotify_id`, `title`, `duration_ms`, `position_ms`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, '2KaguBdfLfnwq6BFEDKzDy', 'Kapitel 1.1 - Die Tribute von Panem 1. Tödliche Spiele', 192800, 191121, 'played', '2025-04-20 06:40:09', '2025-04-20 07:22:14'),
(2, 1, '7k8fk67KjSYg2Xc4luzNpt', 'Kapitel 1.2 - Die Tribute von Panem 1. Tödliche Spiele', 189300, 189300, 'played', '2025-04-20 06:40:09', '2025-04-20 12:54:38'),
(3, 1, '66OPbolpEIeE5CGYKSdtVv', 'Kapitel 1.3 & Kapitel 2.1 - Die Tribute von Panem 1. Tödliche Spiele', 189623, 189623, 'played', '2025-04-20 06:40:09', '2025-04-20 12:54:39'),
(4, 1, '0cFJNPv7iLYp1w3LG6KoUs', 'Kapitel 2.2 - Die Tribute von Panem 1. Tödliche Spiele', 197100, 197100, 'played', '2025-04-20 06:40:09', '2025-04-20 12:41:18'),
(5, 1, '6mpNleVEQXaqLhkrHUyDvo', 'Kapitel 2.3 & Kapitel 3.1 - Die Tribute von Panem 1. Tödliche Spiele', 192276, 190160, 'played', '2025-04-20 06:40:09', '2025-04-20 12:44:28'),
(6, 1, '1o4bOcls7oKUkYoofSzp58', 'Kapitel 3.2 - Die Tribute von Panem 1. Tödliche Spiele', 246600, 244069, 'played', '2025-04-20 06:40:09', '2025-04-20 12:50:19'),
(7, 1, '4qZVv0Pxbbq3jPEhUJ2LNn', 'Kapitel 3.3 & Kapitel 4.1 - Die Tribute von Panem 1. Tödliche Spiele', 215064, 215064, 'played', '2025-04-20 06:40:09', '2025-04-20 12:53:55'),
(8, 1, '1g7JCY4WJKLgTXlBB7yI3H', 'Kapitel 4.2 - Die Tribute von Panem 1. Tödliche Spiele', 192800, 189317, 'played', '2025-04-20 06:40:09', '2025-04-20 12:57:05'),
(9, 1, '3maYoGolgW6yuhOH88CNXU', 'Kapitel 4.3 - Die Tribute von Panem 1. Tödliche Spiele', 208600, 204855, 'played', '2025-04-20 06:40:09', '2025-04-20 13:00:33'),
(10, 1, '1W7S2sE4qesUzyDZsbMEH8', 'Kapitel 4.4 & Kapitel 5.1 - Die Tribute von Panem 1. Tödliche Spiele', 240073, 238036, 'played', '2025-04-20 06:40:09', '2025-04-20 13:04:35'),
(11, 1, '0sfdbqx3O0WT1fVWKcE81S', 'Kapitel 5.2 - Die Tribute von Panem 1. Tödliche Spiele', 190800, 188671, 'played', '2025-04-20 06:40:09', '2025-04-20 14:03:06'),
(12, 1, '3YnetxERcxe79Wm46mSdi4', 'Kapitel 5.3 - Die Tribute von Panem 1. Tödliche Spiele', 192200, 192200, 'played', '2025-04-20 06:40:09', '2025-04-20 14:25:24'),
(13, 1, '2SJYocpQoZYLVgh4pMfn99', 'Kapitel 5.4 & Kapitel 6.1 - Die Tribute von Panem 1. Tödliche Spiele', 201697, 201697, 'played', '2025-04-20 06:40:09', '2025-04-20 14:31:40'),
(14, 1, '0lW4I3VaFMijMgDdn1WkTg', 'Kapitel 6.2 - Die Tribute von Panem 1. Tödliche Spiele', 218800, 216729, 'played', '2025-04-20 06:40:09', '2025-04-20 14:33:36'),
(15, 1, '32qVSxJB6OESYYlmadd0eO', 'Kapitel 6.3 & Kapitel 7.1 - Die Tribute von Panem 1. Tödliche Spiele', 242436, 242436, 'played', '2025-04-20 06:40:09', '2025-04-20 16:36:09'),
(16, 1, '33JzXSpbCBxaKsyKEJoUR7', 'Kapitel 7.2 - Die Tribute von Panem 1. Tödliche Spiele', 209400, 204544, 'played', '2025-04-20 06:40:09', '2025-04-21 10:19:17'),
(17, 1, '0rqLkcIM1Jio4baL7yvRsc', 'Kapitel 7.3 - Die Tribute von Panem 1. Tödliche Spiele', 188200, 186410, 'played', '2025-04-20 06:40:09', '2025-04-21 10:53:27'),
(18, 1, '5ckMRA551l1l58wR95CXJt', 'Kapitel 7.4 - Die Tribute von Panem 1. Tödliche Spiele', 187400, 184334, 'played', '2025-04-20 06:40:09', '2025-04-21 10:56:32'),
(19, 1, '5XhJqhL0FScQ8lfvvpfaJB', 'Kapitel 7.5 & Kapitel 8.1 - Die Tribute von Panem 1. Tödliche Spiele', 210404, 205597, 'played', '2025-04-20 06:40:09', '2025-04-21 12:11:11'),
(20, 1, '48BWbBn2COWJqzU9pwlZwc', 'Kapitel 8.2 - Die Tribute von Panem 1. Tödliche Spiele', 213300, 211147, 'played', '2025-04-20 06:40:09', '2025-04-21 12:14:45'),
(21, 1, '2kK6w3BGjplns5pzTFK2dh', 'Kapitel 8.3 - Die Tribute von Panem 1. Tödliche Spiele', 187200, 184366, 'played', '2025-04-20 06:40:09', '2025-04-21 12:17:52'),
(22, 1, '3PvyDUtYwzc74tgdLRrPmT', 'Kapitel 8.4 & Kapitel 9.1 - Die Tribute von Panem 1. Tödliche Spiele', 196841, 196009, 'played', '2025-04-20 06:40:09', '2025-04-21 12:21:11'),
(23, 1, '79hEgK6ZuqMhc437IlyDFC', 'Kapitel 9.2 - Die Tribute von Panem 1. Tödliche Spiele', 190800, 186736, 'played', '2025-04-20 06:40:09', '2025-04-21 12:32:11'),
(24, 1, '6Ikx7WKa6TDmeg2EstHrkJ', 'Kapitel 9.3 - Die Tribute von Panem 1. Tödliche Spiele', 190000, 187100, 'played', '2025-04-20 06:40:09', '2025-04-21 12:35:21'),
(25, 1, '0Iv2CXtGmB5WsX18JuDFNw', 'Kapitel 9.4 & Kapitel 10.1 - Die Tribute von Panem 1. Tödliche Spiele', 204723, 199775, 'played', '2025-04-20 06:40:09', '2025-04-21 12:52:53'),
(26, 1, '63q1xqoxVnH6BMnMjl0lYQ', 'Kapitel 10.2 - Die Tribute von Panem 1. Tödliche Spiele', 196100, 196100, 'played', '2025-04-20 06:40:09', '2025-04-21 13:01:13'),
(27, 1, '2ms3DDnRv1hFPVoS4VfVI5', 'Kapitel 10.3 - Die Tribute von Panem 1. Tödliche Spiele', 205900, 205900, 'played', '2025-04-20 06:40:09', '2025-04-21 13:01:15'),
(28, 1, '3TFSAgPge42aKsAdLLskih', 'Kapitel 10.4 & Kapitel 11.1 - Die Tribute von Panem 1. Tödliche Spiele', 188708, 143087, 'in_progress', '2025-04-20 06:40:09', '2025-04-21 13:02:01'),
(29, 1, '5uIwV422NPfdxYZAsJQOdu', 'Kapitel 11.2 - Die Tribute von Panem 1. Tödliche Spiele', 208400, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(30, 1, '2Z7aN8oQotCMz5h6LiJmJa', 'Kapitel 11.3 - Die Tribute von Panem 1. Tödliche Spiele', 186300, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(31, 1, '709p7TFszdXSngVkVxrTvw', 'Kapitel 11.4 & Kapitel 12.1 - Die Tribute von Panem 1. Tödliche Spiele', 200959, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(32, 1, '65VbsORGMtY00VIuqBxv9Q', 'Kapitel 12.2 - Die Tribute von Panem 1. Tödliche Spiele', 194000, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(33, 1, '1fwppYIWD66RCzfbcc7mqI', 'Kapitel 12.3 - Die Tribute von Panem 1. Tödliche Spiele', 197700, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(34, 1, '3CKxx4NvHELlATbVRYHNYH', 'Kapitel 12.4 & Kapitel 13.1 - Die Tribute von Panem 1. Tödliche Spiele', 195508, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(35, 1, '1O0zZEmqHdCfDt87zwkQDd', 'Kapitel 13.2 - Die Tribute von Panem 1. Tödliche Spiele', 195600, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(36, 1, '4v7tKrHxZ3YlNTt91MHPRp', 'Kapitel 13.3 - Die Tribute von Panem 1. Tödliche Spiele', 190400, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(37, 1, '3PJKaaJWPPABDVUXIwvcIc', 'Kapitel 13.4 & Kapitel 14.1 - Die Tribute von Panem 1. Tödliche Spiele', 209476, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(38, 1, '2NXr6YrEe8mMicxzX6fCmx', 'Kapitel 14.2 - Die Tribute von Panem 1. Tödliche Spiele', 208700, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(39, 1, '5HgPT8U6zhq42sy9p3DpGx', 'Kapitel 14.3 - Die Tribute von Panem 1. Tödliche Spiele', 192000, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(40, 1, '037RTktRygggpYfjW7WlC9', 'Kapitel 14.4 & Kapitel 15.1 - Die Tribute von Panem 1. Tödliche Spiele', 197897, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(41, 1, '2gSU1Y5uw4gkjW1wfiyLAL', 'Kapitel 15.2 - Die Tribute von Panem 1. Tödliche Spiele', 216000, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(42, 1, '1EhtDR5HCZoJdlvuV4J0ma', 'Kapitel 15.3 - Die Tribute von Panem 1. Tödliche Spiele', 197400, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(43, 1, '34LMAm1KrNQx3qXzsD5zqN', 'Kapitel 15.4 & Kapitel 16.1 - Die Tribute von Panem 1. Tödliche Spiele', 195075, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(44, 1, '7KL64ovBNNJv296HPshqWd', 'Kapitel 16.2 - Die Tribute von Panem 1. Tödliche Spiele', 201900, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(45, 1, '6t6eVPynx0ulBeNSL0j0E1', 'Kapitel 16.3 & Kapitel 17.1 - Die Tribute von Panem 1. Tödliche Spiele', 190578, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(46, 1, '4eky7xH29CkGh4rZ0QcELq', 'Kapitel 17.2 - Die Tribute von Panem 1. Tödliche Spiele', 197100, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(47, 1, '43VrCewYSSY9CCpHn559R9', 'Kapitel 17.3 - Die Tribute von Panem 1. Tödliche Spiele', 260400, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(48, 1, '1VjDAiPz723th8bf50Mf1H', 'Kapitel 17.4 & Kapitel 18.1 - Die Tribute von Panem 1. Tödliche Spiele', 223398, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(49, 1, '0zaz1giwFr8O5NToiixnkq', 'Kapitel 18.2 - Die Tribute von Panem 1. Tödliche Spiele', 191700, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(50, 1, '1i8BBMyPCr6VUGa9NktSr2', 'Kapitel 18.3 & Kapitel 19.1 - Die Tribute von Panem 1. Tödliche Spiele', 205546, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(51, 1, '4YjMDK6WSCd8SaBFSqPM0K', 'Kapitel 19.2 - Die Tribute von Panem 1. Tödliche Spiele', 196100, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(52, 1, '7e2r1C9gyBpkGtTivc5FU4', 'Kapitel 19.3 - Die Tribute von Panem 1. Tödliche Spiele', 200000, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(53, 1, '0J3o4U1sLqOG9XrEyFEIBi', 'Kapitel 19.4 & Kapitel 20.1 - Die Tribute von Panem 1. Tödliche Spiele', 211990, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(54, 1, '2SGTYNRrVhsHgDLEhrDkgp', 'Kapitel 20.2 - Die Tribute von Panem 1. Tödliche Spiele', 191700, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(55, 1, '3KzpL6PFvrNkHS68huMhZy', 'Kapitel 20.3 & Kapitel 21.1 - Die Tribute von Panem 1. Tödliche Spiele', 189364, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(56, 1, '0EtmxLjywl2NdiqMdkgUXh', 'Kapitel 21.2 - Die Tribute von Panem 1. Tödliche Spiele', 186200, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(57, 1, '52fwb5ohqxlx3SeI91yxMh', 'Kapitel 21.3 - Die Tribute von Panem 1. Tödliche Spiele', 206600, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(58, 1, '4itwdliqfcSsdl3VSa5iUU', 'Kapitel 21.4 & Kapitel 22.1 - Die Tribute von Panem 1. Tödliche Spiele', 203107, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(59, 1, '3MDDd1LgBmUWAVbSXxhWUD', 'Kapitel 22.2 - Die Tribute von Panem 1. Tödliche Spiele', 200400, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(60, 1, '0jUn5Kz8nB59d0W6tLtGbL', 'Kapitel 22.3 - Die Tribute von Panem 1. Tödliche Spiele', 192500, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(61, 1, '00aEuV4UVr3RAfBvdTUIPY', 'Kapitel 22.4 & Kapitel 23.1 - Die Tribute von Panem 1. Tödliche Spiele', 295872, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(62, 1, '0Czx7d589mtnKTqe2bmv3P', 'Kapitel 23.2 & Kapitel 24.1 - Die Tribute von Panem 1. Tödliche Spiele', 189916, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(63, 1, '3IePKyH5dxtAaewfPSt3No', 'Kapitel 24.2 - Die Tribute von Panem 1. Tödliche Spiele', 206500, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(64, 1, '3FXkNniqkjoU9MfPKiTjdf', 'Kapitel 24.3 - Die Tribute von Panem 1. Tödliche Spiele', 186300, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(65, 1, '1t7C1tRq4d8CKSWRBkRZEQ', 'Kapitel 24.4 & Kapitel 25.1 - Die Tribute von Panem 1. Tödliche Spiele', 204008, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(66, 1, '4yoaFXbNbgskWtMXTP6mBI', 'Kapitel 25.2 - Die Tribute von Panem 1. Tödliche Spiele', 194100, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(67, 1, '7euQmYTWEq22OzlWFwWa0T', 'Kapitel 25.3 & Kapitel 26.1 - Die Tribute von Panem 1. Tödliche Spiele', 212125, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(68, 1, '2eCWJJUGBBiSMfnr3v3wbS', 'Kapitel 26.2 - Die Tribute von Panem 1. Tödliche Spiele', 189500, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(69, 1, '5HjAbS948BV8hMrqNqcV1S', 'Kapitel 26.3 & Kapitel 27.1 - Die Tribute von Panem 1. Tödliche Spiele', 198476, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(70, 1, '5XYUsrX21vX2iTCM3zDpbD', 'Kapitel 27.2 - Die Tribute von Panem 1. Tödliche Spiele', 210400, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(71, 1, '6arUtrJcDY2O9ZlrBea4Ia', 'Kapitel 27.3 & Kapitel 28.1 - Die Tribute von Panem 1. Tödliche Spiele', 196860, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(72, 1, '47gOTyKR7EktSjXLjkeOoR', 'Kapitel 28.2 - Die Tribute von Panem 1. Tödliche Spiele', 196000, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(73, 1, '0CllLDZQoUpaWtBmQCw60m', 'Kapitel 28.3 - Die Tribute von Panem 1. Tödliche Spiele', 195300, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(74, 1, '7an6sBScIWgXb6MGIrmyNu', 'Kapitel 28.4 & Kapitel 29.1 - Die Tribute von Panem 1. Tödliche Spiele', 195869, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(75, 1, '3fPcMugklye7FIsmlR6gir', 'Kapitel 29.2 - Die Tribute von Panem 1. Tödliche Spiele', 196100, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(76, 1, '777nKr7GEELQxppo4d6LCR', 'Kapitel 29.3 - Die Tribute von Panem 1. Tödliche Spiele', 190200, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(77, 1, '06y0W3c33LkoBDpBO1eUpg', 'Kapitel 29.4 & Kapitel 30.1 - Die Tribute von Panem 1. Tödliche Spiele', 192356, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(78, 1, '3y1sfHKkBPyWzhcV9BBkGb', 'Kapitel 30.2 - Die Tribute von Panem 1. Tödliche Spiele', 195900, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(79, 1, '4KDS3GRxrrgQyI0Uef6SW6', 'Kapitel 30.3 & Kapitel 31.1 - Die Tribute von Panem 1. Tödliche Spiele', 209956, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(80, 1, '6Y42nIo0KoewNI0EuqMjxa', 'Kapitel 31.2 - Die Tribute von Panem 1. Tödliche Spiele', 198500, NULL, 'unplayed', '2025-04-20 06:40:09', '2025-04-20 06:40:09'),
(81, 1, '3CR7HoXcGv09HSR4rjpBdh', 'Kapitel 31.3 - Die Tribute von Panem 1. Tödliche Spiele', 199600, NULL, 'unplayed', '2025-04-20 06:40:10', '2025-04-20 06:40:10'),
(82, 1, '0HjKa3nQNPnVKwlbMNl7UT', 'Kapitel 31.4 & Kapitel 32.1 - Die Tribute von Panem 1. Tödliche Spiele', 188289, NULL, 'unplayed', '2025-04-20 06:40:10', '2025-04-20 06:40:10'),
(83, 1, '0zqRqxLxRbrHUVWdJX0z65', 'Kapitel 32.2 - Die Tribute von Panem 1. Tödliche Spiele', 201100, NULL, 'unplayed', '2025-04-20 06:40:10', '2025-04-20 06:40:10'),
(84, 1, '2RWLUlsQE3DmwbnqjrsaZM', 'Kapitel 32.3 & Kapitel 33.1 - Die Tribute von Panem 1. Tödliche Spiele', 190414, NULL, 'unplayed', '2025-04-20 06:40:10', '2025-04-20 06:40:10'),
(85, 1, '0dLTplcKxlvwRmz9Y8fOwo', 'Kapitel 33.2 - Die Tribute von Panem 1. Tödliche Spiele', 187400, NULL, 'unplayed', '2025-04-20 06:40:10', '2025-04-20 06:40:10'),
(86, 1, '5M4YSylZVdsa0IY4NDxfnf', 'Kapitel 33.3 & Kapitel 34.1 - Die Tribute von Panem 1. Tödliche Spiele', 208014, NULL, 'unplayed', '2025-04-20 06:40:10', '2025-04-20 06:40:10'),
(87, 1, '1ek26T0rpOwcnaG2J9Ngke', 'Kapitel 34.2 - Die Tribute von Panem 1. Tödliche Spiele', 197100, NULL, 'unplayed', '2025-04-20 06:40:10', '2025-04-20 06:40:10'),
(88, 1, '2adGUf8kqBajObWzRE6bFX', 'Kapitel 34.3 & Kapitel 35.1 - Die Tribute von Panem 1. Tödliche Spiele', 227805, NULL, 'unplayed', '2025-04-20 06:40:10', '2025-04-20 06:40:10'),
(89, 1, '3WvD7x5niSyj2ltn4HaycR', 'Kapitel 35.2 - Die Tribute von Panem 1. Tödliche Spiele', 201000, NULL, 'unplayed', '2025-04-20 06:40:10', '2025-04-20 06:40:10'),
(90, 1, '22sM4Ux2FL9rXcvJX9edCZ', 'Kapitel 35.3 & Kapitel 36.1 - Die Tribute von Panem 1. Tödliche Spiele', 185513, NULL, 'unplayed', '2025-04-20 06:40:10', '2025-04-20 06:40:10'),
(91, 1, '6GymN1gkyhgipqVd8FJGJN', 'Kapitel 36.2 - Die Tribute von Panem 1. Tödliche Spiele', 195900, NULL, 'unplayed', '2025-04-20 06:40:10', '2025-04-20 06:40:10'),
(92, 1, '4hRY8JGdiecsReNjzxeO3F', 'Kapitel 36.3 - Die Tribute von Panem 1. Tödliche Spiele', 187600, NULL, 'unplayed', '2025-04-20 06:40:10', '2025-04-20 06:40:10'),
(93, 1, '3oOIBEx0CLICIYScakRrQz', 'Kapitel 36.4 & Kapitel 37.1 - Die Tribute von Panem 1. Tödliche Spiele', 188145, NULL, 'unplayed', '2025-04-20 06:40:10', '2025-04-20 06:40:10'),
(94, 1, '5F7gCPu0bEdKUKIcZ3SbiD', 'Kapitel 37.2 - Die Tribute von Panem 1. Tödliche Spiele', 204900, NULL, 'unplayed', '2025-04-20 06:40:10', '2025-04-20 06:40:10'),
(95, 1, '15ByFIBllcyf2M7TDpp42Q', 'Kapitel 37.3 & Kapitel 38.1 - Die Tribute von Panem 1. Tödliche Spiele', 185614, NULL, 'unplayed', '2025-04-20 06:40:10', '2025-04-20 06:40:10'),
(96, 1, '0J96KxUS04iz1ykPzbTkq5', 'Kapitel 38.2 - Die Tribute von Panem 1. Tödliche Spiele', 187300, NULL, 'unplayed', '2025-04-20 06:40:10', '2025-04-20 06:40:10'),
(97, 1, '2bHhzzRKT6PhJMeqv6YBWF', 'Kapitel 38.3 & Kapitel 39.1 - Die Tribute von Panem 1. Tödliche Spiele', 197868, NULL, 'unplayed', '2025-04-20 06:40:10', '2025-04-20 06:40:10'),
(98, 1, '4Y3vq2VBBkjmcP6dvh9FeG', 'Kapitel 39.2 - Die Tribute von Panem 1. Tödliche Spiele', 205100, NULL, 'unplayed', '2025-04-20 06:40:10', '2025-04-20 06:40:10'),
(99, 1, '3S7dBYQU2RtKQbLMVvvTxs', 'Kapitel 39.3 & Kapitel 40.1 - Die Tribute von Panem 1. Tödliche Spiele', 185354, NULL, 'unplayed', '2025-04-20 06:40:10', '2025-04-20 06:40:10'),
(100, 1, '7GLVBkBWMNKwcEwzTRdJAX', 'Kapitel 40.2 - Die Tribute von Panem 1. Tödliche Spiele', 219500, NULL, 'unplayed', '2025-04-20 06:40:10', '2025-04-20 06:40:10'),
(101, 2, '2KaguBdfLfnwq6BFEDKzDy', 'Kapitel 1.1 - Die Tribute von Panem 1. Tödliche Spiele', 192800, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(102, 2, '7k8fk67KjSYg2Xc4luzNpt', 'Kapitel 1.2 - Die Tribute von Panem 1. Tödliche Spiele', 189300, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(103, 2, '66OPbolpEIeE5CGYKSdtVv', 'Kapitel 1.3 & Kapitel 2.1 - Die Tribute von Panem 1. Tödliche Spiele', 189623, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(104, 2, '0cFJNPv7iLYp1w3LG6KoUs', 'Kapitel 2.2 - Die Tribute von Panem 1. Tödliche Spiele', 197100, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(105, 2, '6mpNleVEQXaqLhkrHUyDvo', 'Kapitel 2.3 & Kapitel 3.1 - Die Tribute von Panem 1. Tödliche Spiele', 192276, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(106, 2, '1o4bOcls7oKUkYoofSzp58', 'Kapitel 3.2 - Die Tribute von Panem 1. Tödliche Spiele', 246600, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(107, 2, '4qZVv0Pxbbq3jPEhUJ2LNn', 'Kapitel 3.3 & Kapitel 4.1 - Die Tribute von Panem 1. Tödliche Spiele', 215064, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(108, 2, '1g7JCY4WJKLgTXlBB7yI3H', 'Kapitel 4.2 - Die Tribute von Panem 1. Tödliche Spiele', 192800, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(109, 2, '3maYoGolgW6yuhOH88CNXU', 'Kapitel 4.3 - Die Tribute von Panem 1. Tödliche Spiele', 208600, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(110, 2, '1W7S2sE4qesUzyDZsbMEH8', 'Kapitel 4.4 & Kapitel 5.1 - Die Tribute von Panem 1. Tödliche Spiele', 240073, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(111, 2, '0sfdbqx3O0WT1fVWKcE81S', 'Kapitel 5.2 - Die Tribute von Panem 1. Tödliche Spiele', 190800, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(112, 2, '3YnetxERcxe79Wm46mSdi4', 'Kapitel 5.3 - Die Tribute von Panem 1. Tödliche Spiele', 192200, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(113, 2, '2SJYocpQoZYLVgh4pMfn99', 'Kapitel 5.4 & Kapitel 6.1 - Die Tribute von Panem 1. Tödliche Spiele', 201697, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(114, 2, '0lW4I3VaFMijMgDdn1WkTg', 'Kapitel 6.2 - Die Tribute von Panem 1. Tödliche Spiele', 218800, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(115, 2, '32qVSxJB6OESYYlmadd0eO', 'Kapitel 6.3 & Kapitel 7.1 - Die Tribute von Panem 1. Tödliche Spiele', 242436, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(116, 2, '33JzXSpbCBxaKsyKEJoUR7', 'Kapitel 7.2 - Die Tribute von Panem 1. Tödliche Spiele', 209400, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(117, 2, '0rqLkcIM1Jio4baL7yvRsc', 'Kapitel 7.3 - Die Tribute von Panem 1. Tödliche Spiele', 188200, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(118, 2, '5ckMRA551l1l58wR95CXJt', 'Kapitel 7.4 - Die Tribute von Panem 1. Tödliche Spiele', 187400, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(119, 2, '5XhJqhL0FScQ8lfvvpfaJB', 'Kapitel 7.5 & Kapitel 8.1 - Die Tribute von Panem 1. Tödliche Spiele', 210404, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(120, 2, '48BWbBn2COWJqzU9pwlZwc', 'Kapitel 8.2 - Die Tribute von Panem 1. Tödliche Spiele', 213300, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(121, 2, '2kK6w3BGjplns5pzTFK2dh', 'Kapitel 8.3 - Die Tribute von Panem 1. Tödliche Spiele', 187200, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(122, 2, '3PvyDUtYwzc74tgdLRrPmT', 'Kapitel 8.4 & Kapitel 9.1 - Die Tribute von Panem 1. Tödliche Spiele', 196841, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(123, 2, '79hEgK6ZuqMhc437IlyDFC', 'Kapitel 9.2 - Die Tribute von Panem 1. Tödliche Spiele', 190800, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(124, 2, '6Ikx7WKa6TDmeg2EstHrkJ', 'Kapitel 9.3 - Die Tribute von Panem 1. Tödliche Spiele', 190000, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(125, 2, '0Iv2CXtGmB5WsX18JuDFNw', 'Kapitel 9.4 & Kapitel 10.1 - Die Tribute von Panem 1. Tödliche Spiele', 204723, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(126, 2, '63q1xqoxVnH6BMnMjl0lYQ', 'Kapitel 10.2 - Die Tribute von Panem 1. Tödliche Spiele', 196100, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(127, 2, '2ms3DDnRv1hFPVoS4VfVI5', 'Kapitel 10.3 - Die Tribute von Panem 1. Tödliche Spiele', 205900, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(128, 2, '3TFSAgPge42aKsAdLLskih', 'Kapitel 10.4 & Kapitel 11.1 - Die Tribute von Panem 1. Tödliche Spiele', 188708, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(129, 2, '5uIwV422NPfdxYZAsJQOdu', 'Kapitel 11.2 - Die Tribute von Panem 1. Tödliche Spiele', 208400, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(130, 2, '2Z7aN8oQotCMz5h6LiJmJa', 'Kapitel 11.3 - Die Tribute von Panem 1. Tödliche Spiele', 186300, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(131, 2, '709p7TFszdXSngVkVxrTvw', 'Kapitel 11.4 & Kapitel 12.1 - Die Tribute von Panem 1. Tödliche Spiele', 200959, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(132, 2, '65VbsORGMtY00VIuqBxv9Q', 'Kapitel 12.2 - Die Tribute von Panem 1. Tödliche Spiele', 194000, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(133, 2, '1fwppYIWD66RCzfbcc7mqI', 'Kapitel 12.3 - Die Tribute von Panem 1. Tödliche Spiele', 197700, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(134, 2, '3CKxx4NvHELlATbVRYHNYH', 'Kapitel 12.4 & Kapitel 13.1 - Die Tribute von Panem 1. Tödliche Spiele', 195508, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(135, 2, '1O0zZEmqHdCfDt87zwkQDd', 'Kapitel 13.2 - Die Tribute von Panem 1. Tödliche Spiele', 195600, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(136, 2, '4v7tKrHxZ3YlNTt91MHPRp', 'Kapitel 13.3 - Die Tribute von Panem 1. Tödliche Spiele', 190400, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(137, 2, '3PJKaaJWPPABDVUXIwvcIc', 'Kapitel 13.4 & Kapitel 14.1 - Die Tribute von Panem 1. Tödliche Spiele', 209476, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(138, 2, '2NXr6YrEe8mMicxzX6fCmx', 'Kapitel 14.2 - Die Tribute von Panem 1. Tödliche Spiele', 208700, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(139, 2, '5HgPT8U6zhq42sy9p3DpGx', 'Kapitel 14.3 - Die Tribute von Panem 1. Tödliche Spiele', 192000, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(140, 2, '037RTktRygggpYfjW7WlC9', 'Kapitel 14.4 & Kapitel 15.1 - Die Tribute von Panem 1. Tödliche Spiele', 197897, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(141, 2, '2gSU1Y5uw4gkjW1wfiyLAL', 'Kapitel 15.2 - Die Tribute von Panem 1. Tödliche Spiele', 216000, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(142, 2, '1EhtDR5HCZoJdlvuV4J0ma', 'Kapitel 15.3 - Die Tribute von Panem 1. Tödliche Spiele', 197400, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(143, 2, '34LMAm1KrNQx3qXzsD5zqN', 'Kapitel 15.4 & Kapitel 16.1 - Die Tribute von Panem 1. Tödliche Spiele', 195075, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(144, 2, '7KL64ovBNNJv296HPshqWd', 'Kapitel 16.2 - Die Tribute von Panem 1. Tödliche Spiele', 201900, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(145, 2, '6t6eVPynx0ulBeNSL0j0E1', 'Kapitel 16.3 & Kapitel 17.1 - Die Tribute von Panem 1. Tödliche Spiele', 190578, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(146, 2, '4eky7xH29CkGh4rZ0QcELq', 'Kapitel 17.2 - Die Tribute von Panem 1. Tödliche Spiele', 197100, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(147, 2, '43VrCewYSSY9CCpHn559R9', 'Kapitel 17.3 - Die Tribute von Panem 1. Tödliche Spiele', 260400, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(148, 2, '1VjDAiPz723th8bf50Mf1H', 'Kapitel 17.4 & Kapitel 18.1 - Die Tribute von Panem 1. Tödliche Spiele', 223398, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(149, 2, '0zaz1giwFr8O5NToiixnkq', 'Kapitel 18.2 - Die Tribute von Panem 1. Tödliche Spiele', 191700, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(150, 2, '1i8BBMyPCr6VUGa9NktSr2', 'Kapitel 18.3 & Kapitel 19.1 - Die Tribute von Panem 1. Tödliche Spiele', 205546, NULL, 'unplayed', '2025-04-20 07:10:16', '2025-04-20 07:10:16'),
(151, 3, '7HVdUaGEPc5tH2BjriNvGa', 'Alle Fälle Intro', 32002, 32002, 'played', '2025-04-20 14:11:19', '2025-04-20 14:12:12'),
(152, 3, '3vjS1aFacngHi7jxy9pVwS', '232 - Die Stadt aus Gold - Titelmusik', 23573, 23573, 'played', '2025-04-20 14:11:19', '2025-04-20 14:12:10'),
(153, 3, '2sURZXStbFwkxNBuwcd7D4', '232 - Die Stadt aus Gold - Teil 01', 188413, 188413, 'played', '2025-04-20 14:11:19', '2025-04-20 14:12:09'),
(154, 3, '25JbEvCTFDxAVNZDtaQWY2', '232 - Die Stadt aus Gold - Teil 02', 184160, 181762, 'played', '2025-04-20 14:11:19', '2025-04-20 14:13:32'),
(155, 3, '3QgCJn0bHyf6iAy4KDRrzp', '232 - Die Stadt aus Gold - Teil 03', 190733, 188745, 'played', '2025-04-20 14:11:19', '2025-04-20 14:16:42'),
(156, 3, '4FrJi8O6YsWzFW2LPUE0vK', '232 - Die Stadt aus Gold - Teil 04', 183173, 118149, 'in_progress', '2025-04-20 14:11:19', '2025-04-20 14:22:10'),
(157, 3, '3pOE1Hctmthm3Ea1h6zjL6', '232 - Die Stadt aus Gold - Teil 05', 182346, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(158, 3, '1teeifTfKtS33P1BuKkgxd', '232 - Die Stadt aus Gold - Teil 06', 183413, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(159, 3, '34aU2neVYcKiGPzfCIFSRH', '232 - Die Stadt aus Gold - Teil 07', 186600, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(160, 3, '43XDpPEv8rEm0UQLmuQPFS', '232 - Die Stadt aus Gold - Teil 08', 182413, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(161, 3, '3Kt4IkoI7WQiNisf675YmT', '232 - Die Stadt aus Gold - Teil 09', 180440, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(162, 3, '1EcJ5oUfNTv767FYfr93bh', '232 - Die Stadt aus Gold - Teil 10', 182493, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(163, 3, '0AnEf1wxkz85tww5xRkXjw', '232 - Die Stadt aus Gold - Teil 11', 190266, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(164, 3, '5Tojb5LBZdDKmIMqxfTlZf', '232 - Die Stadt aus Gold - Teil 12', 184520, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(165, 3, '0PfeC42a1IZ3sMgJaH6GJT', '232 - Die Stadt aus Gold - Teil 13', 181586, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(166, 3, '5bKXxIzmVH2GgFmouZmlhL', '232 - Die Stadt aus Gold - Teil 14', 187173, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(167, 3, '585mjySJ1O9DX8W5BU7oIW', '232 - Die Stadt aus Gold - Teil 15', 191333, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(168, 3, '3Sq0hQjW0DZmaxLAcORaLB', '232 - Die Stadt aus Gold - Teil 16', 186053, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(169, 3, '2sMLu0PvIPnnP3aV6neWvS', '232 - Die Stadt aus Gold - Teil 17', 186586, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(170, 3, '4qJhKO3fyzyCCI7i7r9VJR', '232 - Die Stadt aus Gold - Teil 18', 184693, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(171, 3, '1NsSAW5xZFkKYcqZK2BC8n', '232 - Die Stadt aus Gold - Teil 19', 181653, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(172, 3, '6Wu4N3Bft3zJxXAHyyTTRS', '232 - Die Stadt aus Gold - Teil 20', 182853, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(173, 3, '42PQ0WSgPIUYO22UvMOsw7', '232 - Die Stadt aus Gold - Teil 21', 182080, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(174, 3, '6xwPlQlhHNcu0AdLBXa7W9', '232 - Die Stadt aus Gold - Teil 22', 185013, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(175, 3, '3wtsMWjWMTyYx6jPxeA9Hc', '232 - Die Stadt aus Gold - Teil 23', 188000, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(176, 3, '2s3oGDtILxeEqDo17ZbFWj', '232 - Die Stadt aus Gold - Teil 24', 249453, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(177, 3, '2emsR92anJY1lFvRuO5J8w', '231 - und der Dreiäugige Schakal - Titelmusik', 21600, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(178, 3, '1A4AS83B2vcaNPqLYGJMii', '231 - und der Dreiäugige Schakal - Teil 01', 183800, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(179, 3, '5zMmsB8bck8Pn42X0jAf4v', '231 - und der Dreiäugige Schakal - Teil 02', 184493, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(180, 3, '0JB8C6oXxVxVnMoSYH7zDa', '231 - und der Dreiäugige Schakal - Teil 03', 171760, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(181, 3, '0VZAUgcKBbqUl4XZYkxo7U', '231 - und der Dreiäugige Schakal - Teil 04', 185120, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(182, 3, '1276acYmJxJOpfbMZRSxFl', '231 - und der Dreiäugige Schakal - Teil 05', 183640, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(183, 3, '1ZpvlwKPkIAQ2bMyToGGMY', '231 - und der Dreiäugige Schakal - Teil 06', 186120, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(184, 3, '2hQkPr18KzJ8ok0rXfgejC', '231 - und der Dreiäugige Schakal - Teil 07', 181506, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(185, 3, '4WEcFjWFXMehtdicW3DDsx', '231 - und der Dreiäugige Schakal - Teil 08', 185440, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(186, 3, '3BW83YQs33mYRuTAP7VH5v', '231 - und der Dreiäugige Schakal - Teil 09', 180066, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(187, 3, '57BUchxMSOjCLlluXdc0ch', '231 - und der Dreiäugige Schakal - Teil 10', 185600, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(188, 3, '6EcbxYzmO8eRCrHhy6Mqr7', '231 - und der Dreiäugige Schakal - Teil 11', 181893, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(189, 3, '3E3e3Gsz9gb1Ub3wh4kvLS', '231 - und der Dreiäugige Schakal - Teil 12', 183346, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(190, 3, '5KkGTV8YhccW8DK6EMYG29', '231 - und der Dreiäugige Schakal - Teil 13', 182240, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(191, 3, '3uDOOAMZBkg6MF4bnF2IwQ', '231 - und der Dreiäugige Schakal - Teil 14', 182466, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(192, 3, '3Qr4C5lUISjY9Z8SrXtlp9', '231 - und der Dreiäugige Schakal - Teil 15', 186066, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(193, 3, '7ENJnBqHWdQe725p3rCJrv', '231 - und der Dreiäugige Schakal - Teil 16', 181933, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(194, 3, '2mTl1L9KuXGEnXZIHY10fS', '231 - und der Dreiäugige Schakal - Teil 17', 186293, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(195, 3, '6TNA5HzSd15rduaMezS6TD', '231 - und der Dreiäugige Schakal - Teil 18', 195653, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(196, 3, '65V0dCbnevqryVf1H3ESpc', '231 - und der Dreiäugige Schakal - Teil 19', 183226, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(197, 3, '0V8ULtPO4o5ysZ0j5Ndf5K', '231 - und der Dreiäugige Schakal - Teil 20', 186746, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(198, 3, '1X95n1tcwHzOXtfuMjutj9', '231 - und der Dreiäugige Schakal - Teil 21', 182773, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(199, 3, '3i53z2FjsYqZEmo7HZzVpf', '231 - und der Dreiäugige Schakal - Teil 22', 182093, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(200, 3, '4nIx8g8TS0kugU26FqTsSw', '231 - und der Dreiäugige Schakal - Teil 23', 180426, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(201, 3, '5hzGpfYxzt0yfzwdOaXpV7', '231 - und der Dreiäugige Schakal - Teil 24', 305280, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(202, 3, '7vvSmqEgkamzyynXEvMeEw', '230 - Der Tag der Toten - Titelmusik', 21453, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(203, 3, '5c5VbA2E04A0usne7kRREv', '230 - Der Tag der Toten - Teil 01', 181146, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(204, 3, '7iqTK7RR73f0KEQ3paB1O5', '230 - Der Tag der Toten - Teil 02', 184800, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(205, 3, '7J3CVE4aYRGapisfm8d0dd', '230 - Der Tag der Toten - Teil 03', 180853, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(206, 3, '0WDbWJOEJOu5NPw730ELve', '230 - Der Tag der Toten - Teil 04', 182840, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(207, 3, '7H9cjWaJtlNEQi736rCgzs', '230 - Der Tag der Toten - Teil 05', 181680, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(208, 3, '1aDNe1cFwj7ki6dVCZ318K', '230 - Der Tag der Toten - Teil 06', 182813, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(209, 3, '6EmeURKXXQ1dRP0IXDRJyA', '230 - Der Tag der Toten - Teil 07', 184706, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(210, 3, '2uxW2KVfop1g57vwuAo2cq', '230 - Der Tag der Toten - Teil 08', 181733, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(211, 3, '0px0WKM8Cx7kBF2QfSrrHL', '230 - Der Tag der Toten - Teil 09', 182746, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(212, 3, '1ObajsKzKTXlXDowC2tmpB', '230 - Der Tag der Toten - Teil 10', 185106, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(213, 3, '3Zf6vgzxatbKracD1OMaR2', '230 - Der Tag der Toten - Teil 11', 182786, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(214, 3, '0i9PKiHj2to1zYpxUaqhY1', '230 - Der Tag der Toten - Teil 12', 180666, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(215, 3, '6ag82gw9r65MIVFuE4trVi', '230 - Der Tag der Toten - Teil 13', 182746, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(216, 3, '1tAHyRyTVfxx9hZhVwvAmW', '230 - Der Tag der Toten - Teil 14', 183600, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(217, 3, '0aMjotfrBQNsh1gLChhtaq', '230 - Der Tag der Toten - Teil 15', 181346, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(218, 3, '5xJI2TucuKkmYoakEh4FGr', '230 - Der Tag der Toten - Teil 16', 182026, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(219, 3, '6mfwqytddlp1F2jKLPTnml', '230 - Der Tag der Toten - Teil 17', 184066, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(220, 3, '18D9dYviipSuEPYQeT3Hae', '230 - Der Tag der Toten - Teil 18', 182866, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(221, 3, '0yD2JQpKrlNqJiiz2lmkNb', '230 - Der Tag der Toten - Teil 19', 181733, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(222, 3, '7hs0UYmf8wkqQAFUd7NG1i', '230 - Der Tag der Toten - Teil 20', 185880, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(223, 3, '6HZ3eW3TxW3n9QZyqZzmHN', '230 - Der Tag der Toten - Teil 21', 181813, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(224, 3, '7e2Vnd5FC3JQGuMFCFX8jg', '230 - Der Tag der Toten - Teil 22', 350320, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(225, 3, '4qeK9MuBPEQLnHw48CLGXr', '229 - Drehbuch der Täuschung - Titelmusik', 21800, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(226, 3, '5X2bp4ZoAyh6Ukp7WxKnaD', '229 - Drehbuch der Täuschung - Teil 01', 186853, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(227, 3, '5AhRSoPuCvY7komDtsdbfH', '229 - Drehbuch der Täuschung - Teil 02', 186000, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(228, 3, '7jEMjzWRFdQJNT355WvLme', '229 - Drehbuch der Täuschung - Teil 03', 181173, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(229, 3, '53HsUrkjjjoMZoKNVI2cCq', '229 - Drehbuch der Täuschung - Teil 04', 186386, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(230, 3, '3djSAI5fttXlU5liJFszas', '229 - Drehbuch der Täuschung - Teil 05', 183346, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(231, 3, '3JLDVKDaxtimtfmdsVsvLB', '229 - Drehbuch der Täuschung - Teil 06', 185480, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(232, 3, '2wpTMLF183VW391YWutb5E', '229 - Drehbuch der Täuschung - Teil 07', 181133, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(233, 3, '5TjQgdKNS12pJAYLCV7thk', '229 - Drehbuch der Täuschung - Teil 08', 182253, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(234, 3, '72bCefojO27JT1LfXGLOpC', '229 - Drehbuch der Täuschung - Teil 09', 189160, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(235, 3, '4IomTqfoGkCueINDyT2mWv', '229 - Drehbuch der Täuschung - Teil 10', 189800, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(236, 3, '5AkcpzevQmFvl6Bunln7Fu', '229 - Drehbuch der Täuschung - Teil 11', 184133, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(237, 3, '5ovPVP73wKTv7Ri9gzxpXW', '229 - Drehbuch der Täuschung - Teil 12', 182213, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(238, 3, '2uMljjdTvfvBczYl58vynP', '229 - Drehbuch der Täuschung - Teil 13', 182560, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(239, 3, '1sshds47vSWE8WIH6YZUf0', '229 - Drehbuch der Täuschung - Teil 14', 183786, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(240, 3, '3pxyCWHlHpZ8uuf6PrEtie', '229 - Drehbuch der Täuschung - Teil 15', 184253, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(241, 3, '6YgpM0nl9IC2t48QNXUMSK', '229 - Drehbuch der Täuschung - Teil 16', 187000, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(242, 3, '0OPMEDX7WUvSAT55uaQUaX', '229 - Drehbuch der Täuschung - Teil 17', 180586, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(243, 3, '5gHlkyfmGPnP9EEfgSx1Ma', '229 - Drehbuch der Täuschung - Teil 18', 184800, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(244, 3, '2CVL1WlGSuQZxaSAXKoE9d', '229 - Drehbuch der Täuschung - Teil 19', 184213, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(245, 3, '4TC7Yu7MBN3SXzxnl3WJmq', '229 - Drehbuch der Täuschung - Teil 20', 181146, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(246, 3, '2hTeaRYBcZ17G58o6LRHsB', '229 - Drehbuch der Täuschung - Teil 21', 182106, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(247, 3, '0yVf5gdOxLrZYckuTadcoY', '229 - Drehbuch der Täuschung - Teil 22', 181920, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(248, 3, '5muxbKLCPY7MieO95CovZh', '229 - Drehbuch der Täuschung - Teil 23', 181853, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(249, 3, '5WEt0gMODZoPNJ9rYTnYTZ', '229 - Drehbuch der Täuschung - Teil 24', 181053, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(250, 3, '2er3S7SsnFJ8ul37FAIvgd', '229 - Drehbuch der Täuschung - Teil 25', 323373, NULL, 'unplayed', '2025-04-20 14:11:19', '2025-04-20 14:11:19'),
(251, 4, '176Eeof788CzzuMHIzxZl7', '236 - Schatten aus der Unterwelt - Inhaltsangabe', 59413, 59413, 'played', '2025-04-20 14:18:30', '2025-04-20 14:21:51'),
(252, 4, '4HHizLNHzLre4LK1VJknkJ', 'TKKG Titelsong', 35240, 35240, 'played', '2025-04-20 14:18:30', '2025-04-20 14:21:54'),
(253, 4, '3Es0MkLNTh5jxOfXfvpUvj', '236 - Schatten aus der Unterwelt - Teil 01', 183693, 6908, 'in_progress', '2025-04-20 14:18:30', '2025-04-21 12:47:49'),
(254, 4, '2SWMf0tLFsAQc1xS3paHqQ', '236 - Schatten aus der Unterwelt - Teil 02', 183946, NULL, 'unplayed', '2025-04-20 14:18:30', '2025-04-20 14:18:30'),
(255, 4, '3nnhxcoSAy8ozCrhr2ehFq', '236 - Schatten aus der Unterwelt - Teil 03', 183586, NULL, 'unplayed', '2025-04-20 14:18:30', '2025-04-20 14:18:30'),
(256, 4, '1gCi7zA6j3HyOgujf1MOrp', '236 - Schatten aus der Unterwelt - Teil 04', 182866, NULL, 'unplayed', '2025-04-20 14:18:30', '2025-04-20 14:18:30'),
(257, 4, '6oetupbrMkMgm0SGqtGeUA', '236 - Schatten aus der Unterwelt - Teil 05', 182573, NULL, 'unplayed', '2025-04-20 14:18:30', '2025-04-20 14:18:30'),
(258, 4, '7ssKKjX3RegzFOeQofMp0t', '236 - Schatten aus der Unterwelt - Teil 06', 185800, NULL, 'unplayed', '2025-04-20 14:18:30', '2025-04-20 14:18:30'),
(259, 4, '4aB33uuB2SXdk2CjHBVjDj', '236 - Schatten aus der Unterwelt - Teil 07', 181226, NULL, 'unplayed', '2025-04-20 14:18:30', '2025-04-20 14:18:30'),
(260, 4, '1twqGG46yUZzLvl26GzTmB', '236 - Schatten aus der Unterwelt - Teil 08', 182933, NULL, 'unplayed', '2025-04-20 14:18:30', '2025-04-20 14:18:30'),
(261, 4, '5XSYYX5RBXcX60mZgVKu6e', '236 - Schatten aus der Unterwelt - Teil 09', 188733, NULL, 'unplayed', '2025-04-20 14:18:30', '2025-04-20 14:18:30'),
(262, 4, '7pMlZdnnozdBUpaBrIEJiW', '236 - Schatten aus der Unterwelt - Teil 10', 186600, NULL, 'unplayed', '2025-04-20 14:18:30', '2025-04-20 14:18:30'),
(263, 4, '3fo60LDbolEvQfYOuJ1a5H', '236 - Schatten aus der Unterwelt - Teil 11', 181533, NULL, 'unplayed', '2025-04-20 14:18:30', '2025-04-20 14:18:30'),
(264, 4, '12KO9Cw8ExMZ392lRC0C1i', '236 - Schatten aus der Unterwelt - Teil 12', 183640, NULL, 'unplayed', '2025-04-20 14:18:30', '2025-04-20 14:18:30'),
(265, 4, '03ISIRZD8JBPS6BVWFro7Q', '236 - Schatten aus der Unterwelt - Teil 13', 180186, NULL, 'unplayed', '2025-04-20 14:18:30', '2025-04-20 14:18:30'),
(266, 4, '0DY0ewY6iqIovXwP8u9Itg', '236 - Schatten aus der Unterwelt - Teil 14', 180640, NULL, 'unplayed', '2025-04-20 14:18:30', '2025-04-20 14:18:30'),
(267, 4, '34FTsxzkRCTJJquJZdvZ96', '236 - Schatten aus der Unterwelt - Teil 15', 181773, NULL, 'unplayed', '2025-04-20 14:18:30', '2025-04-20 14:18:30'),
(268, 4, '3RPg34ujjYJpOjtNCdG6Y5', '236 - Schatten aus der Unterwelt - Teil 16', 185840, NULL, 'unplayed', '2025-04-20 14:18:30', '2025-04-20 14:18:30'),
(269, 4, '2jmsYvR2jk3ZcY6EpUGjNf', '236 - Schatten aus der Unterwelt - Teil 17', 182506, NULL, 'unplayed', '2025-04-20 14:18:30', '2025-04-20 14:18:30'),
(270, 4, '2Hupe9T9OFoLX921nRocjb', '236 - Schatten aus der Unterwelt - Teil 18', 182853, NULL, 'unplayed', '2025-04-20 14:18:30', '2025-04-20 14:18:30'),
(271, 5, '4HHizLNHzLre4LK1VJknkJ', 'TKKG Titelsong', 35240, 35240, 'played', '2025-04-20 14:22:37', '2025-04-20 14:23:18'),
(272, 5, '3Es0MkLNTh5jxOfXfvpUvj', '236 - Schatten aus der Unterwelt - Teil 01', 183693, 29549, 'in_progress', '2025-04-20 14:22:37', '2025-04-20 16:36:48'),
(273, 5, '2SWMf0tLFsAQc1xS3paHqQ', '236 - Schatten aus der Unterwelt - Teil 02', 183946, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(274, 5, '3nnhxcoSAy8ozCrhr2ehFq', '236 - Schatten aus der Unterwelt - Teil 03', 183586, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(275, 5, '1gCi7zA6j3HyOgujf1MOrp', '236 - Schatten aus der Unterwelt - Teil 04', 182866, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(276, 5, '6oetupbrMkMgm0SGqtGeUA', '236 - Schatten aus der Unterwelt - Teil 05', 182573, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(277, 5, '7ssKKjX3RegzFOeQofMp0t', '236 - Schatten aus der Unterwelt - Teil 06', 185800, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(278, 5, '4aB33uuB2SXdk2CjHBVjDj', '236 - Schatten aus der Unterwelt - Teil 07', 181226, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(279, 5, '1twqGG46yUZzLvl26GzTmB', '236 - Schatten aus der Unterwelt - Teil 08', 182933, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(280, 5, '5XSYYX5RBXcX60mZgVKu6e', '236 - Schatten aus der Unterwelt - Teil 09', 188733, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(281, 5, '7pMlZdnnozdBUpaBrIEJiW', '236 - Schatten aus der Unterwelt - Teil 10', 186600, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(282, 5, '3fo60LDbolEvQfYOuJ1a5H', '236 - Schatten aus der Unterwelt - Teil 11', 181533, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(283, 5, '12KO9Cw8ExMZ392lRC0C1i', '236 - Schatten aus der Unterwelt - Teil 12', 183640, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(284, 5, '03ISIRZD8JBPS6BVWFro7Q', '236 - Schatten aus der Unterwelt - Teil 13', 180186, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(285, 5, '0DY0ewY6iqIovXwP8u9Itg', '236 - Schatten aus der Unterwelt - Teil 14', 180640, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(286, 5, '34FTsxzkRCTJJquJZdvZ96', '236 - Schatten aus der Unterwelt - Teil 15', 181773, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(287, 5, '3RPg34ujjYJpOjtNCdG6Y5', '236 - Schatten aus der Unterwelt - Teil 16', 185840, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(288, 5, '2jmsYvR2jk3ZcY6EpUGjNf', '236 - Schatten aus der Unterwelt - Teil 17', 182506, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(289, 5, '2Hupe9T9OFoLX921nRocjb', '236 - Schatten aus der Unterwelt - Teil 18', 182853, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(290, 5, '15gUD4X0xwcGBTFcruMPQi', '236 - Schatten aus der Unterwelt - Teil 19', 182000, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(291, 5, '5AGFLUPm5dW0TaEyem6VcL', '236 - Schatten aus der Unterwelt - Teil 20', 182573, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(292, 5, '07PFtDHLK4vxmcJrKKdx0t', '236 - Schatten aus der Unterwelt - Teil 21', 183613, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(293, 5, '2FszTtnM89KknvAaM0SrGT', '236 - Schatten aus der Unterwelt - Teil 22', 182226, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(294, 5, '65BBDpLaGBhK3nCGwWlyO3', '236 - Schatten aus der Unterwelt - Teil 23', 183413, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(295, 5, '20HqgJkYBLkbqKI0EsdYov', '236 - Schatten aus der Unterwelt - Teil 24', 180920, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(296, 5, '6fqiIRtu9mOioa16XZIrME', '236 - Schatten aus der Unterwelt - Teil 25', 180946, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(297, 5, '7eeyC9gGq1u9zfQJ2mkDy4', '236 - Schatten aus der Unterwelt - Teil 26', 181120, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(298, 5, '2RR3E5BF0bkM5JE0sGTcDx', '236 - Schatten aus der Unterwelt - Teil 27', 181146, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(299, 5, '4wvTLu7sO3j2bGBBXVLhAR', '236 - Schatten aus der Unterwelt - Teil 28', 184760, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(300, 5, '1QQgbQH7zh49di34lJxNjJ', '236 - Schatten aus der Unterwelt - Teil 29', 186826, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(301, 5, '4ct0bp8OvTXpGrQiBuXuDN', 'TKKG Schlußsong', 66626, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(302, 5, '7r1Mjp81CD5UiLpiTpOn6e', 'TKKG Titelsong', 35133, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(303, 5, '3llX36KVZiIwLfMtCCtgEh', '235 - Ein Gruselfest für ein Vermögen - Teil 01', 182253, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(304, 5, '6wqp3o5ibHlxLfXgT07gKG', '235 - Ein Gruselfest für ein Vermögen - Teil 02', 181200, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(305, 5, '33fyliqBUQ5Znv13PgmuS9', '235 - Ein Gruselfest für ein Vermögen - Teil 03', 180866, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(306, 5, '3AkXsKgck2S5zWSdvcG73Q', '235 - Ein Gruselfest für ein Vermögen - Teil 04', 182253, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(307, 5, '7JcQBHI9Jbp4KEZdti4fRE', '235 - Ein Gruselfest für ein Vermögen - Teil 05', 183986, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(308, 5, '48l0mhynf5YW8ZMokOKXpC', '235 - Ein Gruselfest für ein Vermögen - Teil 06', 180000, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(309, 5, '2XhTuqp4Oc3byKTwXvOdN2', '235 - Ein Gruselfest für ein Vermögen - Teil 07', 180920, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(310, 5, '2wG43S5ANxg0PSHxgpTpIZ', '235 - Ein Gruselfest für ein Vermögen - Teil 08', 186360, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(311, 5, '4admWhUdftBGobd27SX5f4', '235 - Ein Gruselfest für ein Vermögen - Teil 09', 186826, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(312, 5, '3CftVME546x4iHySn5YIDr', '235 - Ein Gruselfest für ein Vermögen - Teil 10', 183320, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(313, 5, '5g25ygK9GbzsNEw7lsaR2T', '235 - Ein Gruselfest für ein Vermögen - Teil 11', 181933, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(314, 5, '1szZZBoS1mZ5fbK4rSbXnF', '235 - Ein Gruselfest für ein Vermögen - Teil 12', 181573, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37');
INSERT INTO `tracks` (`id`, `playlist_id`, `spotify_id`, `title`, `duration_ms`, `position_ms`, `status`, `created_at`, `updated_at`) VALUES
(315, 5, '2NupbDcjSCq74UHCpmWW5t', '235 - Ein Gruselfest für ein Vermögen - Teil 13', 187240, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(316, 5, '66qAoyHQBgwuS2yFt79P87', '235 - Ein Gruselfest für ein Vermögen - Teil 14', 183720, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(317, 5, '1bScokcFpUSdY7wyd8YLGn', '235 - Ein Gruselfest für ein Vermögen - Teil 15', 180653, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(318, 5, '0Uu5QMjgDL4pSHtoaHifiB', '235 - Ein Gruselfest für ein Vermögen - Teil 16', 182680, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(319, 5, '67x0ZJF9RFG519tfQmQvVW', '235 - Ein Gruselfest für ein Vermögen - Teil 17', 182480, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(320, 5, '1BJr1D4xKvujwqbZv6Iq1z', '235 - Ein Gruselfest für ein Vermögen - Teil 18', 181693, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(321, 5, '2AQO19XVZx9HFZdWV51FzK', '235 - Ein Gruselfest für ein Vermögen - Teil 19', 183386, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(322, 5, '3gX3bfH6cWR5akTBIyW6V9', '235 - Ein Gruselfest für ein Vermögen - Teil 20', 315026, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(323, 5, '42fDK7MsCTkLuzam57ANkT', 'TKKG Schlußsong', 38400, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(324, 5, '6n07uJNcD8GGxDEOy7Brb0', 'TKKG Titelsong', 35640, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(325, 5, '2M43eEJUwn56bf20qKShNg', '234 - Im Auftrag des Bösen - Teil 01', 180973, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(326, 5, '6PbVsx0szmm8MKmI5VRbci', '234 - Im Auftrag des Bösen - Teil 02', 180226, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(327, 5, '0OaHe5XSasMMXLXj7zN6hV', '234 - Im Auftrag des Bösen - Teil 03', 181240, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(328, 5, '65wshuLMlEuU96VRLr8Toa', '234 - Im Auftrag des Bösen - Teil 04', 183093, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(329, 5, '4RUYKLfNGPtYUEDx65bLvW', '234 - Im Auftrag des Bösen - Teil 05', 183666, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(330, 5, '15jTtdG90eh5HByc4oFTrm', '234 - Im Auftrag des Bösen - Teil 06', 183066, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(331, 5, '5pWevnYxQXHnJA6Ux7S57O', '234 - Im Auftrag des Bösen - Teil 07', 188426, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(332, 5, '4BFkBhylruj69xj8nbjkcZ', '234 - Im Auftrag des Bösen - Teil 08', 192600, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(333, 5, '5ZOOun5n0K2xdDQiPX0dtl', '234 - Im Auftrag des Bösen - Teil 09', 184426, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(334, 5, '0018icGKoN199B04gV1yaE', '234 - Im Auftrag des Bösen - Teil 10', 180106, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(335, 5, '6jV0uVqQlyn0GzhcX8f4PD', '234 - Im Auftrag des Bösen - Teil 11', 183560, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(336, 5, '2HGReQODzjYe9clqSvQtZS', '234 - Im Auftrag des Bösen - Teil 12', 185706, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(337, 5, '3aDvrjcjH4BNbRYuk4o1qI', '234 - Im Auftrag des Bösen - Teil 13', 184413, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(338, 5, '00VejGnwgkG9MswmNzVbph', '234 - Im Auftrag des Bösen - Teil 14', 184440, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(339, 5, '1bNWJgBwSxJCgW3NAMLGGw', '234 - Im Auftrag des Bösen - Teil 15', 189546, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(340, 5, '6JdNsuLxCRy1APkknuq9Ec', '234 - Im Auftrag des Bösen - Teil 16', 183440, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(341, 5, '5GZz9m3aPEpyM35wTORVUn', '234 - Im Auftrag des Bösen - Teil 17', 292080, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(342, 5, '2kt2xxDCLfitoQbfFznJIP', 'TKKG Schlußsong', 35106, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(343, 5, '3J0A7xdrMpnFTw8FXLeZWx', 'TKKG Titelsong', 36533, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(344, 5, '13rM8NWaWU0Ox6c3zRr7xj', '233 - Räuberwald - Teil 01', 181626, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(345, 5, '2OTiWIUJKto6AqdhzAQ2vm', '233 - Räuberwald - Teil 02', 183680, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(346, 5, '4ae16qsQJvZBcWNt3nWfft', '233 - Räuberwald - Teil 03', 181746, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(347, 5, '7653H9Zam064I1L74vKP7y', '233 - Räuberwald - Teil 04', 180293, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(348, 5, '48ZUjVyT5zcHcSLOPF8wOX', '233 - Räuberwald - Teil 05', 180746, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(349, 5, '5xwwlpFg0VLNudZ78u8q7Z', '233 - Räuberwald - Teil 06', 181760, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(350, 5, '3rg6n4R0GotSa3ntbuJbFh', '233 - Räuberwald - Teil 07', 182306, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(351, 5, '2hNDGNd7o4tbTmKli65f4q', '233 - Räuberwald - Teil 08', 180373, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(352, 5, '3dQ1PKTfXGHlFEZKULEXem', '233 - Räuberwald - Teil 09', 180986, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(353, 5, '3oesexkziCT5tzDEszdAlX', '233 - Räuberwald - Teil 10', 181133, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(354, 5, '7yJuHqFDMrnbO7eqWlLERA', '233 - Räuberwald - Teil 11', 182826, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(355, 5, '6wk6jsFgORluinyA7LDzxn', '233 - Räuberwald - Teil 12', 180386, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(356, 5, '6aw3q9nfvBfZEZqsOaQjTo', '233 - Räuberwald - Teil 13', 181493, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(357, 5, '0B7fqZMlNWAnD1x0bLYeaD', '233 - Räuberwald - Teil 14', 181080, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(358, 5, '7cCI86y1tWh5b8p7up9VqQ', '233 - Räuberwald - Teil 15', 180306, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(359, 5, '7yM9qMsv4PaOZSRogCh4YQ', '233 - Räuberwald - Teil 16', 182720, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(360, 5, '4iWj5x1bk0iMpGXN8QqWNC', '233 - Räuberwald - Teil 17', 180333, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(361, 5, '6CBtz86cMVduRmmJ4aDV2N', '233 - Räuberwald - Teil 18', 180960, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(362, 5, '5nDpOuqCcDgY1SOpyXKIdY', '233 - Räuberwald - Teil 19', 184546, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(363, 5, '3QSoMa8YeaVn9yqv0W48nj', '233 - Räuberwald - Teil 20', 194186, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(364, 5, '6RF21NeoPvZmrcwNCu9Mpx', '233 - Räuberwald - Teil 21', 273293, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(365, 5, '75OOjyC1Tc5LWk0uAmMQwd', 'TKKG Schlußsong', 33253, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(366, 5, '1jiWGbUkEuekRkavq1GsOV', 'TKKG Titelsong', 35440, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(367, 5, '3uueCWMR6rQf9vxlTpT5UN', '232 - Drohnenaugen in der Nacht - Teil 01', 180146, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(368, 5, '7DhO5QWJgG9nsDwsOXI3I6', '232 - Drohnenaugen in der Nacht - Teil 02', 180333, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(369, 5, '4v6JVebeKAvQS1NVpWjC4N', '232 - Drohnenaugen in der Nacht - Teil 03', 180186, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(370, 5, '4LUHVbKI5NwrNngkkdkJEI', '232 - Drohnenaugen in der Nacht - Teil 04', 180493, NULL, 'unplayed', '2025-04-20 14:22:37', '2025-04-20 14:22:37'),
(371, 6, '18tK8zDvi4N1OUMwRagNRb', 'Kapitel 01: Captain America: The First Avenger', 188706, 185185, 'played', '2025-04-20 16:37:20', '2025-04-21 11:02:25'),
(372, 6, '3VjbF6E5whFIOwagI0fqN4', 'Kapitel 02: Captain America: The First Avenger', 181693, 17413, 'in_progress', '2025-04-20 16:37:20', '2025-04-21 12:47:29'),
(373, 6, '3Hmk8yp4s8vlfVpBrwcDKI', 'Kapitel 03: Captain America: The First Avenger', 187459, NULL, 'unplayed', '2025-04-20 16:37:20', '2025-04-20 16:37:20'),
(374, 6, '0DR3oNo0RBrVYeU0ihQHFy', 'Kapitel 04: Captain America: The First Avenger', 180713, NULL, 'unplayed', '2025-04-20 16:37:20', '2025-04-20 16:37:20'),
(375, 6, '7v6BQOh7mIvCpj3P34HcIl', 'Kapitel 05: Captain America: The First Avenger', 190224, NULL, 'unplayed', '2025-04-20 16:37:20', '2025-04-20 16:37:20'),
(376, 6, '3NsqO31DUPnLtLgTYqxJRN', 'Kapitel 06: Captain America: The First Avenger', 188121, NULL, 'unplayed', '2025-04-20 16:37:20', '2025-04-20 16:37:20'),
(377, 6, '1HRZ9ZG232EKHfFo9HFPgz', 'Kapitel 07: Captain America: The First Avenger', 190320, NULL, 'unplayed', '2025-04-20 16:37:20', '2025-04-20 16:37:20'),
(378, 6, '3LU7VPG6LWE4QYv2E10VAY', 'Kapitel 08: Captain America: The First Avenger', 181391, NULL, 'unplayed', '2025-04-20 16:37:20', '2025-04-20 16:37:20'),
(379, 6, '1n3S3JUFOTtWUoPEXWqDKB', 'Kapitel 09: Captain America: The First Avenger', 185597, NULL, 'unplayed', '2025-04-20 16:37:20', '2025-04-20 16:37:20'),
(380, 6, '06gdeKWW2MfhwzYFA2mbuH', 'Kapitel 10: Captain America: The First Avenger', 181463, NULL, 'unplayed', '2025-04-20 16:37:20', '2025-04-20 16:37:20'),
(381, 6, '0uyURljsUq0lpheGbmCzFg', 'Kapitel 11: Captain America: The First Avenger', 186316, NULL, 'unplayed', '2025-04-20 16:37:20', '2025-04-20 16:37:20'),
(382, 6, '7hPVAEolloKiSdRKqdMx0x', 'Kapitel 12: Captain America: The First Avenger', 190124, NULL, 'unplayed', '2025-04-20 16:37:20', '2025-04-20 16:37:20'),
(383, 6, '5pG1T1zNgWOXOHgyEaMQNa', 'Kapitel 13: Captain America: The First Avenger', 182239, NULL, 'unplayed', '2025-04-20 16:37:20', '2025-04-20 16:37:20'),
(384, 6, '5MGivEQUYtbLZz59hFGbRI', 'Kapitel 14: Captain America: The First Avenger', 192640, NULL, 'unplayed', '2025-04-20 16:37:20', '2025-04-20 16:37:20'),
(385, 6, '2NcyXRWooilQ8NpfVHPFEy', 'Kapitel 15: Captain America: The First Avenger', 186733, NULL, 'unplayed', '2025-04-20 16:37:20', '2025-04-20 16:37:20'),
(386, 6, '7tykEbTBMDdhUM8tzUvRuy', 'Kapitel 16: Captain America: The First Avenger', 182749, NULL, 'unplayed', '2025-04-20 16:37:20', '2025-04-20 16:37:20'),
(387, 6, '5z9SGwloFg6fvLKzPZ0JfO', 'Kapitel 17: Captain America: The First Avenger', 182423, NULL, 'unplayed', '2025-04-20 16:37:20', '2025-04-20 16:37:20'),
(388, 6, '1pTjY9HTgBQPUXrgvrzC0D', 'Kapitel 18: Captain America: The First Avenger', 190986, NULL, 'unplayed', '2025-04-20 16:37:20', '2025-04-20 16:37:20'),
(389, 6, '4KcUTCfsDoRZeGSqM665ZL', 'Kapitel 19: Captain America: The First Avenger', 187693, NULL, 'unplayed', '2025-04-20 16:37:20', '2025-04-20 16:37:20'),
(390, 6, '2ivF6B7x0bFrojVFQ1Jgrv', 'Kapitel 20: Captain America: The First Avenger', 181320, NULL, 'unplayed', '2025-04-20 16:37:20', '2025-04-20 16:37:20');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `playlists`
--
ALTER TABLE `playlists`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `playlists_spotify_id_unique` (`spotify_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `spotify_tokens`
--
ALTER TABLE `spotify_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tracks`
--
ALTER TABLE `tracks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tracks_playlist_id_foreign` (`playlist_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookmarks`
--
ALTER TABLE `bookmarks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `playlists`
--
ALTER TABLE `playlists`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `spotify_tokens`
--
ALTER TABLE `spotify_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tracks`
--
ALTER TABLE `tracks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=391;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tracks`
--
ALTER TABLE `tracks`
  ADD CONSTRAINT `tracks_playlist_id_foreign` FOREIGN KEY (`playlist_id`) REFERENCES `playlists` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

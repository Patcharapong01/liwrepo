-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 31, 2024 at 05:48 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db67_memsys`
--

-- --------------------------------------------------------

--
-- Table structure for table `activities`
--

CREATE TABLE `activities` (
  `id` int(11) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `activities`
--

INSERT INTO `activities` (`id`, `title`, `start_date`, `end_date`, `category_id`, `created_at`) VALUES
(1, 'อบรมพัฒนาทักษะการพูด', '2020-08-20 09:00:00', '2020-08-21 17:00:00', 401, '2024-09-01 18:03:44'),
(2, 'อบรมการพัฒนา Mobile App', '2020-09-03 14:00:00', '2020-09-03 17:00:00', 401, '2024-09-01 18:03:44'),
(3, 'ประชุมประจำสัปดาห์ของกอง', '2020-07-16 09:00:00', '2020-07-16 11:00:00', 402, '2024-09-01 18:03:44');

-- --------------------------------------------------------

--
-- Table structure for table `clubs`
--

CREATE TABLE `clubs` (
  `id` int(11) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clubs`
--

INSERT INTO `clubs` (`id`, `title`, `description`, `category_id`, `created_at`) VALUES
(1, 'ชมรมว่ายน้ำ', 'มาว่ายน้ำกัน เพื่อสุขภาพและความแข็งแรง', 301, '2024-09-01 18:03:59'),
(2, 'ชมรมดนตรีไทย', 'อนุรักษ์ความเป็นไทย อนุรักษ์ศิลปวัฒนธรรมอันดีงาม', 302, '2024-09-01 18:03:59'),
(3, 'ชมรม Guitar Acoustic', 'เพื่อความสุนทรีย์ของชีวิต', 302, '2024-09-01 18:03:59');

-- --------------------------------------------------------

--
-- Table structure for table `memberships`
--

CREATE TABLE `memberships` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `memberships`
--

INSERT INTO `memberships` (`id`, `name`, `price`, `description`) VALUES
(1, 'สมาชิกทั่วไป', 500.00, 'สมาชิกทั่วไปสำหรับการเข้าใช้ฟิตเนต'),
(2, 'สมาชิกพิเศษ', 1000.00, 'สมาชิกพิเศษสำหรับการเข้าฟิตเนตและคลาสพิเศษ'),
(3, 'สมาชิก VIP', 2000.00, 'สมาชิก VIP สำหรับการเข้าใช้ฟิตเนตทุกพื้นที่พร้อมบริการพิเศษ');

-- --------------------------------------------------------

--
-- Table structure for table `persons`
--

CREATE TABLE `persons` (
  `id` int(11) UNSIGNED NOT NULL,
  `fname` varchar(255) NOT NULL,
  `lname` varchar(255) NOT NULL,
  `dob` date DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `gender_id` int(11) DEFAULT NULL,
  `club_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `persons`
--

INSERT INTO `persons` (`id`, `fname`, `lname`, `dob`, `avatar`, `created_at`, `gender_id`, `club_id`) VALUES
(1, 'rapat', 'potongcome', NULL, NULL, '2024-09-02 15:19:03', NULL, NULL),
(8, 'Nattawut', 'Srisai', NULL, NULL, '2024-10-31 15:29:32', NULL, NULL),
(9, 'Kanokwan', 'Chaiyakan', '0000-00-00', '672340c60a536_1730363590.png', '2024-10-31 15:30:13', NULL, NULL),
(11, 'rapat', 'potongcome', NULL, NULL, '2024-10-31 15:37:29', NULL, NULL),
(13, 'rapat', 'potongcome', NULL, NULL, '2024-10-31 15:39:57', NULL, NULL),
(14, 'Patcharapong', 'Titivanich', NULL, NULL, '2024-10-31 23:04:01', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `refs`
--

CREATE TABLE `refs` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `ref_group_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `refs`
--

INSERT INTO `refs` (`id`, `title`, `ref_group_id`, `created_at`) VALUES
(101, 'นาย', 1, '2024-09-01 18:04:34'),
(102, 'นาง', 1, '2024-09-01 18:04:34'),
(103, 'นางสาว', 1, '2024-09-01 18:04:35'),
(104, 'อื่น ๆ', 1, '2024-09-01 18:04:35'),
(201, 'บรรพชิต', 2, '2024-09-01 18:04:35'),
(202, 'ชาย', 2, '2024-09-01 18:04:35'),
(203, 'หญิง', 2, '2024-09-01 18:04:35'),
(301, 'กีฬา', 3, '2024-09-01 18:04:35'),
(302, 'ดนตรี', 3, '2024-09-01 18:04:35'),
(303, 'DIY', 3, '2024-09-01 18:04:35'),
(401, 'Training', 4, '2024-09-01 18:04:35'),
(402, 'Meeting', 4, '2024-09-01 18:04:35');

-- --------------------------------------------------------

--
-- Table structure for table `ref_groups`
--

CREATE TABLE `ref_groups` (
  `id` int(11) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ref_groups`
--

INSERT INTO `ref_groups` (`id`, `title`, `created_at`) VALUES
(1, 'คำนำหน้า', '2024-09-01 18:04:55'),
(2, 'เพศ', '2024-09-01 18:04:55'),
(3, 'ประเภทชมรม', '2024-09-01 18:04:55'),
(4, 'ประเภทกิจกรรม', '2024-09-01 18:04:55');

-- --------------------------------------------------------

--
-- Table structure for table `registers`
--

CREATE TABLE `registers` (
  `id` int(10) UNSIGNED NOT NULL,
  `activity_id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `registers`
--

INSERT INTO `registers` (`id`, `activity_id`, `person_id`, `created_at`) VALUES
(1, 1, 1, '2024-09-01 18:05:11'),
(2, 1, 2, '2024-09-01 18:05:11'),
(7, 2, 1, '2024-09-01 18:05:12'),
(8, 2, 2, '2024-09-01 18:05:12'),
(13, 3, 2, '2024-09-01 18:05:12'),
(21, 1, 14, '2024-10-31 23:04:36'),
(22, 1, 14, '2024-10-31 23:06:20'),
(23, 1, 14, '2024-10-31 23:06:24'),
(24, 1, 14, '2024-10-31 23:06:46');

-- --------------------------------------------------------

--
-- Table structure for table `tb_users`
--

CREATE TABLE `tb_users` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` int(1) NOT NULL DEFAULT 0,
  `person_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_users`
--

INSERT INTO `tb_users` (`id`, `email`, `password`, `role`, `person_id`) VALUES
(2, 'user@gmail.com', '$2y$10$QzWea5dZJ1lJJoCh7Vrd8uWTse94c36uksPj9nd9jUCzkE1uUG88i', 0, 2),
(8, 'user1@gmail.com', '$2y$10$4byZfdgf4YjAjaZTIVgTJ..TakdwLet/0x7buIFal6IqjIeGfuXL.', 0, 8),
(9, 'user2@gmail.com', '$2y$10$Z.BzP.LrTu/D6s2nyXBjUuSs0QWKvdK9RqTjl1vdot0W6ED2gRVVa', 0, 9),
(11, 'admin1@gmail.com', '$2y$10$K5Vy1X1TxCLbBzQvbRjXbeQF34XTfXeaRvtTbXEqVTkBYEL1AtBUC', 1, 11),
(13, 'user3@gmail.com', '$2y$10$Jx4rcgBDhOzQDHpfZjTGEuZ0HBQ77NtPKxWEtDbWtKMQXWRxkyioa', 0, 13),
(14, 'gamemingkung3@gmail.com', '$2y$10$cN6xNGvrpmwDmVnxMuje1.I5XqESgcD6R/5hUGE3gUCJdczU3p5U.', 0, 14);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `user_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `user_name`) VALUES
(1, 'เอ็ม');

-- --------------------------------------------------------

--
-- Table structure for table `user_memberships`
--

CREATE TABLE `user_memberships` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `membership_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_memberships`
--

INSERT INTO `user_memberships` (`id`, `user_id`, `membership_id`) VALUES
(1, 1, 1),
(2, 1, 1),
(3, 1, 1),
(4, 1, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activities`
--
ALTER TABLE `activities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clubs`
--
ALTER TABLE `clubs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `memberships`
--
ALTER TABLE `memberships`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `persons`
--
ALTER TABLE `persons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `refs`
--
ALTER TABLE `refs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ref_groups`
--
ALTER TABLE `ref_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `registers`
--
ALTER TABLE `registers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_users`
--
ALTER TABLE `tb_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_memberships`
--
ALTER TABLE `user_memberships`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `membership_id` (`membership_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activities`
--
ALTER TABLE `activities`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `clubs`
--
ALTER TABLE `clubs`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `memberships`
--
ALTER TABLE `memberships`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `persons`
--
ALTER TABLE `persons`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `ref_groups`
--
ALTER TABLE `ref_groups`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `registers`
--
ALTER TABLE `registers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `tb_users`
--
ALTER TABLE `tb_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_memberships`
--
ALTER TABLE `user_memberships`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `user_memberships`
--
ALTER TABLE `user_memberships`
  ADD CONSTRAINT `user_memberships_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_memberships_ibfk_2` FOREIGN KEY (`membership_id`) REFERENCES `memberships` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

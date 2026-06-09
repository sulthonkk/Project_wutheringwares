-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 08, 2026 at 02:53 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wuthering_wares`
--

-- --------------------------------------------------------

--
-- Table structure for table `equipment`
--

CREATE TABLE `equipment` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `stock` int(11) DEFAULT 0,
  `image` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `equipment`
--

INSERT INTO `equipment` (`id`, `name`, `type`, `description`, `stock`, `image`, `price`, `created_at`) VALUES
(1, 'Verdant Summit', 'Broadblade', 'Swordsworn:\nIncreases DMG Bonus by 12%. Every time Intro Skill or Resonance Liberation is cast, increases Heavy Attack DMG Bonus by 24%, stacking up to 2 time(s). This effect lasts for 14s.', 6, 'https://static.wikia.nocookie.net/wutheringwaves/images/e/e9/Weapon_Verdant_Summit.png/revision/latest?cb=20240515175352', 150000.00, '2026-06-07 08:20:30'),
(2, 'Blazing Brilliance', 'Sword', 'Crimson Phoenix\nATK increased by 12%. The wielder gains 1 stack of Searing Feather upon dealing damage, which can be triggered once every 0.5s, and gains 5 stacks of the same effect upon casting Resonance Skill. Each stack of Searing Feather gives 4% additional Resonance Skill DMG Bonus for up to 14 stacks. After reaching the max stacks, all stacks will be removed in 12s.', 4, 'https://wutheringlab.com/wp-content/uploads/Blazing-Brilliance.webp', 140000.00, '2026-06-07 15:19:23'),
(3, 'Cosmic Ripples', 'Rectifier', 'Increases Crit DMG by 36%. When the wielder uses Basic Attack, increases Basic Attack DMG Bonus by 20% for 15s, stacking up to 2 times.', 9, 'https://wuwatracker.com/_next/image?url=%2Fapi%2Fweapon-icons%2Ffile%2Fcosmic-ripples.webp&w=640&q=30', 155000.00, '2026-06-08 07:31:17'),
(4, 'Stringmaster', 'Rectifier', 'Increases Crit Rate by 18%. When the wielder uses Resonance Skill or Resonance Liberation, increases ATK by 20% for 15s.', 15, 'https://wuwatracker.com/_next/image?url=%2Fapi%2Fweapon-icons%2Ffile%2Fstringmaster.webp&w=640&q=30', 125000.00, '2026-06-08 07:31:17'),
(5, 'Variation', 'Rectifier', 'Increases ATK by 12%. When the wielder uses Resonance Liberation, increases ATK by 24% for 20s.', 20, 'https://wuwatracker.com/_next/image?url=%2Fapi%2Fweapon-icons%2Ffile%2Fvariation.webp&w=640&q=30', 95000.00, '2026-06-08 07:31:17'),
(6, 'Abyss Surges', 'Gauntlets', 'Increases Crit Rate by 18%. Each time the wielder uses a Resonance Skill, increases Crit DMG by 20% for 15s, stacking up to 2 times.', 10, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeBfdMb0XRkKoxurdV5O65McrbN79MYHfZNA&s', 148000.00, '2026-06-08 07:31:17'),
(7, 'Hollow Mirage', 'Gauntlets', 'Increases ATK by 12%. When the wielder uses Intro Skill, increases ATK by 20% and Heavy Attack DMG Bonus by 20% for 15s.', 15, 'https://wuwatracker.com/_next/image?url=%2Fapi%2Fweapon-icons%2Ffile%2Fhollow-mirage.webp&w=640&q=30', 118000.00, '2026-06-08 07:31:17'),
(8, 'Stonard', 'Gauntlets', 'Increases ATK by 12%. When the wielder takes damage, recovers 10% HP and increases DEF by 20% for 10s. This effect can only trigger once every 20s.', 20, 'https://wuwatracker.com/_next/image?url=%2Fapi%2Fweapon-icons%2Ffile%2Fstonard.webp&w=640&q=30', 92000.00, '2026-06-08 07:31:17'),
(9, 'Crownless', 'Echo', 'When equipped, the Resonator can transform into the Crownless, unleashing its Havoc DMG. Increases Havoc DMG Bonus by 12% and Resonance Skill DMG Bonus by 12% for 15s after skill use.', 10, 'https://static.wikia.nocookie.net/wutheringwaves/images/7/70/Crownless_Icon.png/revision/latest/scale-to-width/360?cb=20240708073945', 200000.00, '2026-06-08 07:32:05'),
(10, 'Dreamless', 'Echo', 'When equipped, the Resonator can summon the Dreamless, dealing Havoc DMG to nearby enemies. Increases Havoc DMG Bonus by 15% for 20s after use.', 10, 'https://static.wikia.nocookie.net/wutheringwaves/images/9/91/Dreamless_Icon.png/revision/latest/thumbnail/width/360/height/360?cb=20240529043925', 220000.00, '2026-06-08 07:32:05'),
(11, 'Bell-Borne Geochelone', 'Echo', 'When equipped, creates a shield that absorbs DMG equal to 120% of the Resonator ATK. Increases all Resonators inside the shield Resonance Skill DMG Bonus by 10%.', 10, 'https://static.wikia.nocookie.net/wutheringwaves/images/4/45/Bell-Borne_Geochelone_Icon.png/revision/latest?cb=20240708134239', 210000.00, '2026-06-08 07:32:05'),
(12, 'Inferno Rider', 'Echo', 'When equipped, the Resonator can transform into the Inferno Rider, dealing Fusion DMG to enemies along the path. Increases Fusion DMG Bonus by 12% for 15s after use.', 10, 'https://static.wikia.nocookie.net/wutheringwaves/images/7/77/Echo_Inferno_Rider.png/revision/latest?cb=20240526210335', 195000.00, '2026-06-08 07:32:05'),
(13, 'Thundering Mephis', 'Echo', 'When equipped, the Resonator can transform into Thundering Mephis, striking enemies with powerful Electro attacks. Increases Electro DMG Bonus by 12% and Heavy Attack DMG Bonus by 12% for 15s.', 10, 'https://static.wikia.nocookie.net/wutheringwaves/images/0/0e/Thundering_Mephis_Icon.png/revision/latest?cb=20240708074318', 215000.00, '2026-06-08 07:32:05');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `equipment_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `item_type` enum('equipment','terminal_supply') DEFAULT 'equipment',
  `terminal_supply_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `user_id`, `equipment_id`, `quantity`, `total_price`, `created_at`, `item_type`, `terminal_supply_id`) VALUES
(1, 1, 1, 2, 300000.00, '2026-06-07 08:22:36', 'equipment', NULL),
(2, 2, 1, 1, 150000.00, '2026-06-07 15:14:18', 'equipment', NULL),
(3, 3, 2, 1, 140000.00, '2026-06-08 06:42:39', 'equipment', NULL),
(4, 3, 1, 1, 150000.00, '2026-06-08 07:53:02', 'equipment', NULL),
(5, 3, 3, 1, 155000.00, '2026-06-08 07:54:32', 'equipment', NULL),
(6, 3, NULL, 1, 20000.00, '2026-06-08 07:59:33', 'terminal_supply', 5),
(7, 3, NULL, 1, 75000.00, '2026-06-08 08:41:05', 'terminal_supply', 14);

-- --------------------------------------------------------

--
-- Table structure for table `terminal_supplies`
--

CREATE TABLE `terminal_supplies` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `category` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `stock` int(11) DEFAULT 0,
  `image` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `terminal_supplies`
--

INSERT INTO `terminal_supplies` (`id`, `name`, `category`, `description`, `stock`, `image`, `price`, `created_at`) VALUES
(1, 'Waveworn Residue 226', 'Resonance Material', 'A substance left behind after a Tacet Discord has been purified. Emits a faint resonance frequency of 226Hz. Used to amplify Resonance Chains.', 50, 'https://wuwatracker.com/_next/image?url=%2Fapi%2Fitem-icons%2Ffile%2Fwaveworn-residue-226.webp&w=640&q=30', 15000.00, '2026-06-08 07:15:37'),
(2, 'Waveworn Residue 235', 'Resonance Material', 'A substance left behind after a Tacet Discord has been purified. Emits a faint resonance frequency of 235Hz. Used to amplify Resonance Chains.', 50, 'https://wuwatracker.com/_next/image?url=%2Fapi%2Fitem-icons%2Ffile%2Fwaveworn-residue-235.webp&w=640&q=30', 25000.00, '2026-06-08 07:15:37'),
(3, 'Waveworn Residue 239', 'Resonance Material', 'A substance left behind after a Tacet Discord has been purified. Emits a faint resonance frequency of 239Hz. Used to amplify Resonance Chains.', 30, 'https://wuwatracker.com/_next/image?url=%2Fapi%2Fitem-icons%2Ffile%2Fwaveworn-residue-239.webp&w=640&q=30', 40000.00, '2026-06-08 07:15:37'),
(5, 'Inert Metallic Drip', 'Resonator Material', 'Metallic fluid extracted from a Tacet Discord. Though inert on its own, it activates when it comes into contact with a Resonator, providing energy for Resonance Skill enhancement.', 39, 'https://wuwatracker.com/_next/image?url=%2Fapi%2Fitem-icons%2Ffile%2Finert-metallic-drip.webp&w=640&q=30', 20000.00, '2026-06-08 07:15:37'),
(6, 'Reactive Metallic Drip', 'Resonator Material', 'A more potent form of Metallic Drip. Reacts strongly with Resonator energy, significantly boosting Resonance Skill levels.', 30, 'https://wuwatracker.com/_next/image?url=%2Fapi%2Fitem-icons%2Ffile%2Freactive-metallic-drip.webp&w=640&q=30', 35000.00, '2026-06-08 07:15:37'),
(7, 'Polarized Metallic Drip', 'Resonator Material', 'The most refined form of Metallic Drip. Carries a powerful polarized charge that maximizes Resonance Skill enhancement potential.', 15, 'https://wuwatracker.com/_next/image?url=%2Fapi%2Fitem-icons%2Ffile%2Fpolarized-metallic-drip.webp&w=640&q=30', 55000.00, '2026-06-08 07:15:37'),
(8, 'Shell Credits', 'Currency', 'The primary currency of the Huanglong region, issued by the Jinzhou Chamber of Commerce. Accepted across most terminals and trading posts in the Continent of Solaris-3.', 999, 'https://wuwatracker.com/_next/image?url=%2Fapi%2Fitem-icons%2Ffile%2Fshell-credit.webp&w=640&q=30', 1000.00, '2026-06-08 07:15:37'),
(9, 'Crude Ring', 'Forgery Material', 'A basic ring obtained from Tacet Discords. Contains traces of condensed energy that can be used in weapon forging and enhancement.', 60, 'https://wuwatracker.com/_next/image?url=%2Fapi%2Fitem-icons%2Ffile%2Fcrude-ring.webp&w=640&q=30', 10000.00, '2026-06-08 07:15:37'),
(10, 'Basic Ring', 'Forgery Material', 'A standard quality ring with more stable energy concentration. Commonly used as material for mid-tier weapon enhancement at the Terminal.', 45, 'https://wuwatracker.com/_next/image?url=%2Fapi%2Fitem-icons%2Ffile%2Fbasic-ring.webp&w=640&q=30', 18000.00, '2026-06-08 07:15:37'),
(11, 'Improved Ring', 'Forgery Material', 'A high-quality ring with dense, stable energy. Sought after by weapon smiths across Jinzhou for crafting advanced armaments.', 25, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwL4NeT8A-kgucxKthAcKv8McQE_qHgOxy1w&s', 30000.00, '2026-06-08 07:15:37'),
(13, 'Advanced Tuner', 'Echo Material', 'An upgraded tuning device with enhanced calibration capabilities. Allows for more precise Echo enhancement and higher stat ceilings.', 20, 'https://static.wikia.nocookie.net/wutheringwaves/images/b/bc/Item_Advanced_Tuner.png/revision/latest?cb=20240603111344', 45000.00, '2026-06-08 07:15:37'),
(14, 'Premium Tuner', 'Echo Material', 'The pinnacle of tuning technology developed by Jinzhou researchers. Guarantees optimal Echo enhancement results with minimal energy loss.', 9, 'https://static.wikia.nocookie.net/wutheringwaves/images/e/e1/Item_Premium_Tuner.png/revision/latest?cb=20240529094703', 75000.00, '2026-06-08 07:15:37');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` enum('admin','customer') DEFAULT 'customer',
  `google_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `google_id`, `created_at`) VALUES
(1, 'Admin', 'adminwuthering@gmail.com', 'admin123_@', 'admin', NULL, '2026-06-07 07:41:46'),
(2, 'sodiqin', 'sodqin@gmail.com', 'anjas123', 'customer', NULL, '2026-06-07 15:13:47'),
(3, 'Dummy', 'dummybbb12@gmail.com', NULL, 'customer', '105826161544721458817', '2026-06-08 06:41:42');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `equipment_id` (`equipment_id`),
  ADD KEY `terminal_supply_id` (`terminal_supply_id`);

--
-- Indexes for table `terminal_supplies`
--
ALTER TABLE `terminal_supplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `equipment`
--
ALTER TABLE `equipment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `terminal_supplies`
--
ALTER TABLE `terminal_supplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `purchases_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `purchases_ibfk_2` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`),
  ADD CONSTRAINT `purchases_ibfk_3` FOREIGN KEY (`terminal_supply_id`) REFERENCES `terminal_supplies` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

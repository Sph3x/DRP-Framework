-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 31, 2019 at 07:11 PM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.3.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `drp`
--

-- --------------------------------------------------------

--
-- Table structure for table `characters`
--

CREATE TABLE `characters` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `age` int(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `cash` bigint(20) NOT NULL DEFAULT '0',
  `bank` bigint(20) NOT NULL DEFAULT '0',
  `dirtyCash` bigint(20) NOT NULL DEFAULT '0',
  `paycheck` bigint(20) NOT NULL DEFAULT '0',
  `licenses` text NOT NULL,
  `phonenumber` mediumint(11) NOT NULL,
  `isDead` int(11) NOT NULL DEFAULT '0',
  `lastLocation` varchar(255) DEFAULT '{433.42, -628.88, 28.72}',
  `playerid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `character_clothing`
--

CREATE TABLE `character_clothing` (
  `id` int(11) NOT NULL,
  `model` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `clothing_drawables` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `clothing_textures` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `clothing_palette` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `props_drawables` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `props_textures` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `overlays_drawables` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `overlays_opacity` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `overlays_colours` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `char_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `character_inventory`
--

CREATE TABLE `character_inventory` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `itemid` int(11) DEFAULT NULL,
  `charid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `character_tattoos`
--

CREATE TABLE `character_tattoos` (
  `id` int(11) NOT NULL,
  `tattoos` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `char_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_items`
--

CREATE TABLE `inventory_items` (
  `id` int(11) NOT NULL,
  `itemname` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `canUse` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `inventory_items`
--

INSERT INTO `inventory_items` (`id`, `itemname`, `canUse`) VALUES
(1, 'water', 1),
(2, 'lockpick', 1),
(3, 'dildo', 0),
(4, 'weed', 1),
(5, 'marijuana', 1),
(6, 'rawcocaine', 1),
(7, 'cocaine', 1),
(9, 'cocainebrick', 0),
(10, 'barkersofkensingtonmegasport', 0),
(11, 'rolex', 0),
(12, 'silverwatch', 0),
(14, 'goldchain', 0),
(15, 'goldearrings', 0),
(16, 'goldplatedwatch', 0),
(17, 'watch', 0),
(18, 'earrings', 0),
(19, 'vwbadge', 0),
(20, 'chain', 0),
(22, 'burger', 1),
(23, 'junk', 0),
(24, 'ifruit', 0);

-- --------------------------------------------------------

--
-- Table structure for table `police`
--

CREATE TABLE `police` (
  `id` int(11) NOT NULL,
  `rank` int(11) DEFAULT NULL,
  `division` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `department` varchar(50) COLLATE utf8_bin DEFAULT 'police',
  `char_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `identifier` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `rank` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ban_data` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `whitelisted` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `id` int(11) NOT NULL,
  `model` varchar(50) DEFAULT NULL,
  `plate` varchar(8) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `primarycolor` varchar(50) DEFAULT NULL,
  `secondarycolor` varchar(50) DEFAULT NULL,
  `pearlescentColor` varchar(50) DEFAULT NULL,
  `plateindex` varchar(50) DEFAULT NULL,
  `wheelColor` varchar(50) DEFAULT NULL,
  `neoncolor1` varchar(50) DEFAULT NULL,
  `neoncolor3` varchar(50) DEFAULT NULL,
  `neoncolor2` varchar(50) DEFAULT NULL,
  `wheeltype` varchar(50) DEFAULT NULL,
  `windowtint` varchar(50) DEFAULT NULL,
  `mods0` varchar(50) DEFAULT '-1',
  `mods1` varchar(50) DEFAULT '-1',
  `mods2` varchar(50) DEFAULT '-1',
  `mods3` varchar(50) DEFAULT '-1',
  `mods4` varchar(50) DEFAULT '-1',
  `mods5` varchar(50) DEFAULT '-1',
  `mods6` varchar(50) DEFAULT '-1',
  `mods7` varchar(50) DEFAULT '-1',
  `mods8` varchar(50) DEFAULT '-1',
  `mods9` varchar(50) DEFAULT '-1',
  `mods10` varchar(50) DEFAULT '-1',
  `mods11` varchar(50) DEFAULT '-1',
  `mods12` varchar(50) DEFAULT '-1',
  `mods13` varchar(50) DEFAULT '-1',
  `mods14` varchar(50) DEFAULT '-1',
  `mods15` varchar(50) DEFAULT '-1',
  `mods16` varchar(50) DEFAULT '-1',
  `turbo` varchar(50) NOT NULL DEFAULT 'off',
  `tiresmoke` varchar(50) NOT NULL DEFAULT 'off',
  `xenon` varchar(50) NOT NULL DEFAULT 'off',
  `mods23` varchar(50) DEFAULT NULL,
  `mods24` varchar(50) DEFAULT NULL,
  `neon0` varchar(50) NOT NULL DEFAULT 'off',
  `neon1` varchar(50) NOT NULL DEFAULT 'off',
  `neon2` varchar(50) NOT NULL DEFAULT 'off',
  `neon3` varchar(50) NOT NULL DEFAULT 'off',
  `bulletproof` varchar(50) NOT NULL DEFAULT 'off',
  `smokecolor1` varchar(50) DEFAULT NULL,
  `smokecolor2` varchar(50) DEFAULT NULL,
  `smokecolor3` varchar(50) DEFAULT NULL,
  `variation` varchar(50) NOT NULL DEFAULT 'off',
  `damage` int(11) NOT NULL DEFAULT '1000',
  `enginedamage` int(11) NOT NULL DEFAULT '1000',
  `charactername` varchar(50) NOT NULL,
  `char_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin2;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_id` (`playerid`) USING BTREE;

--
-- Indexes for table `character_clothing`
--
ALTER TABLE `character_clothing`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_character_clothing_characters` (`char_id`);

--
-- Indexes for table `character_inventory`
--
ALTER TABLE `character_inventory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `itemid_fk1` (`itemid`),
  ADD KEY `FK_character_inventory_characters` (`charid`);

--
-- Indexes for table `character_tattoos`
--
ALTER TABLE `character_tattoos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_character_tattoos_characters` (`char_id`);

--
-- Indexes for table `inventory_items`
--
ALTER TABLE `inventory_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `police`
--
ALTER TABLE `police`
  ADD PRIMARY KEY (`id`),
  ADD KEY `police_fk1` (`char_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vehicles_ibfk_01` (`char_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `characters`
--
ALTER TABLE `characters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `character_clothing`
--
ALTER TABLE `character_clothing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `character_inventory`
--
ALTER TABLE `character_inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `character_tattoos`
--
ALTER TABLE `character_tattoos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `inventory_items`
--
ALTER TABLE `inventory_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `police`
--
ALTER TABLE `police`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `characters`
--
ALTER TABLE `characters`
  ADD CONSTRAINT `characters_ibfk_1` FOREIGN KEY (`playerid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `character_clothing`
--
ALTER TABLE `character_clothing`
  ADD CONSTRAINT `FK_character_clothing_characters` FOREIGN KEY (`char_id`) REFERENCES `characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `character_inventory`
--
ALTER TABLE `character_inventory`
  ADD CONSTRAINT `FK_character_inventory_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `itemid_fk1` FOREIGN KEY (`itemid`) REFERENCES `inventory_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `character_tattoos`
--
ALTER TABLE `character_tattoos`
  ADD CONSTRAINT `FK_character_tattoos_characters` FOREIGN KEY (`char_id`) REFERENCES `characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `police`
--
ALTER TABLE `police`
  ADD CONSTRAINT `police_fk1` FOREIGN KEY (`char_id`) REFERENCES `characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD CONSTRAINT `vehicles_ibfk_01` FOREIGN KEY (`char_id`) REFERENCES `characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

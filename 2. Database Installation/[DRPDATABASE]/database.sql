-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.37-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win32
-- HeidiSQL Version:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for drp
CREATE DATABASE IF NOT EXISTS `drp` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;
USE `drp`;

-- Dumping structure for table drp.characters
CREATE TABLE IF NOT EXISTS `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `age` int(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `cash` bigint(20) NOT NULL,
  `bank` bigint(20) NOT NULL,
  `dirtyCash` bigint(20) NOT NULL,
  `paycheck` bigint(11) NOT NULL,
  `licenses` text NOT NULL,
  `phonenumber` mediumint(11) NOT NULL,
  `isDead` int(11) NOT NULL DEFAULT '0',
  `lastLocation` varchar(255) DEFAULT '{433.42, -628.88, 28.72}',
  `playerid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `player_id` (`playerid`) USING BTREE,
  CONSTRAINT `characters_ibfk_1` FOREIGN KEY (`playerid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Dumping data for table drp.characters: ~2 rows (approximately)
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;

-- Dumping structure for table drp.character_clothing
CREATE TABLE IF NOT EXISTS `character_clothing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `clothing_drawables` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `clothing_textures` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `clothing_palette` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `props_drawables` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `props_textures` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `overlays_drawables` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `overlays_opacity` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `overlays_colours` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `char_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_character_clothing_characters` (`char_id`),
  CONSTRAINT `FK_character_clothing_characters` FOREIGN KEY (`char_id`) REFERENCES `characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table drp.character_clothing: ~0 rows (approximately)
/*!40000 ALTER TABLE `character_clothing` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_clothing` ENABLE KEYS */;

-- Dumping structure for table drp.character_inventory
CREATE TABLE IF NOT EXISTS `character_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `itemid` int(11) DEFAULT NULL,
  `charid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `itemid_fk1` (`itemid`),
  KEY `FK_character_inventory_characters` (`charid`),
  CONSTRAINT `FK_character_inventory_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `itemid_fk1` FOREIGN KEY (`itemid`) REFERENCES `inventory_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table drp.character_inventory: ~0 rows (approximately)
/*!40000 ALTER TABLE `character_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_inventory` ENABLE KEYS */;

-- Dumping structure for table drp.character_tattoos
CREATE TABLE IF NOT EXISTS `character_tattoos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tattoos` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `char_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_character_tattoos_characters` (`char_id`),
  CONSTRAINT `FK_character_tattoos_characters` FOREIGN KEY (`char_id`) REFERENCES `characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table drp.character_tattoos: ~0 rows (approximately)
/*!40000 ALTER TABLE `character_tattoos` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_tattoos` ENABLE KEYS */;

-- Dumping structure for table drp.inventory_items
CREATE TABLE IF NOT EXISTS `inventory_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `itemname` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `canUse` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table drp.inventory_items: ~21 rows (approximately)
/*!40000 ALTER TABLE `inventory_items` DISABLE KEYS */;
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
/*!40000 ALTER TABLE `inventory_items` ENABLE KEYS */;

-- Dumping structure for table drp.police
CREATE TABLE IF NOT EXISTS `police` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rank` int(11) DEFAULT NULL,
  `division` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `department` varchar(50) COLLATE utf8_bin DEFAULT 'police',
  `char_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `police_fk1` (`char_id`),
  CONSTRAINT `police_fk1` FOREIGN KEY (`char_id`) REFERENCES `characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table drp.police: ~0 rows (approximately)
/*!40000 ALTER TABLE `police` DISABLE KEYS */;
/*!40000 ALTER TABLE `police` ENABLE KEYS */;

-- Dumping structure for table drp.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `identifier` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `rank` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ban_data` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `whitelisted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table drp.users: ~1 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table drp.vehicles
CREATE TABLE IF NOT EXISTS `vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modelLabel` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `vehicleMods` longtext,
  `damage` int(11) NOT NULL DEFAULT '1000',
  `enginedamage` int(11) NOT NULL DEFAULT '1000',
  `charactername` varchar(50) NOT NULL,
  `char_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `vehicles_ibfk_01` (`char_id`),
  CONSTRAINT `vehicles_ibfk_01` FOREIGN KEY (`char_id`) REFERENCES `characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin2;

-- Dumping data for table drp.vehicles: ~0 rows (approximately)
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;

-- Dumping structure for table drp.vehicle_auction
CREATE TABLE IF NOT EXISTS `vehicle_auction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sellername` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `vehicleMods` longtext COLLATE utf8_bin,
  `price` int(11) DEFAULT '0',
  `char_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_vehicle_auction_characters` (`char_id`),
  CONSTRAINT `FK_vehicle_auction_characters` FOREIGN KEY (`char_id`) REFERENCES `characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table drp.vehicle_auction: ~8 rows (approximately)
/*!40000 ALTER TABLE `vehicle_auction` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_auction` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

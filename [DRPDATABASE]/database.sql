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
  `model` varchar(255) NOT NULL,
  `tattoos` text NOT NULL,
  `cash` bigint(20) NOT NULL,
  `bank` bigint(20) NOT NULL,
  `dirtyCash` bigint(20) NOT NULL,
  `paycheck` bigint(11) NOT NULL,
  `licenses` text NOT NULL,
  `phonenumber` mediumint(11) NOT NULL,
  `isDead` int(11) NOT NULL DEFAULT '0',
  `playerid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `player_id` (`playerid`) USING BTREE,
  CONSTRAINT `characters_ibfk_1` FOREIGN KEY (`playerid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Dumping data for table drp.characters: ~2 rows (approximately)
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;

-- Dumping structure for table drp.character_clothing
CREATE TABLE IF NOT EXISTS `character_clothing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `skin` varchar(255) NOT NULL DEFAULT 'mp_m_freemode_01',
  `face` varchar(255) NOT NULL DEFAULT '0',
  `face_texture` varchar(255) NOT NULL DEFAULT '0',
  `hair` varchar(255) NOT NULL DEFAULT '11',
  `hair_texture` varchar(255) NOT NULL DEFAULT '4',
  `shirt` varchar(255) NOT NULL DEFAULT '0',
  `shirt_texture` varchar(255) NOT NULL DEFAULT '0',
  `pants` varchar(255) NOT NULL DEFAULT '8',
  `pants_texture` varchar(255) NOT NULL DEFAULT '0',
  `shoes` varchar(255) NOT NULL DEFAULT '1',
  `shoes_texture` varchar(255) NOT NULL DEFAULT '0',
  `vest` varchar(255) NOT NULL DEFAULT '0',
  `vest_texture` varchar(255) NOT NULL DEFAULT '0',
  `bag` varchar(255) NOT NULL DEFAULT '40',
  `bag_texture` varchar(255) NOT NULL DEFAULT '0',
  `hat` varchar(255) NOT NULL DEFAULT '1',
  `hat_texture` varchar(255) NOT NULL DEFAULT '1',
  `mask` varchar(255) NOT NULL DEFAULT '0',
  `mask_texture` varchar(255) NOT NULL DEFAULT '0',
  `glasses` varchar(255) NOT NULL DEFAULT '6',
  `glasses_texture` varchar(255) NOT NULL DEFAULT '0',
  `gloves` varchar(255) NOT NULL DEFAULT '2',
  `gloves_texture` varchar(255) NOT NULL DEFAULT '0',
  `jacket` varchar(255) NOT NULL DEFAULT '7',
  `jacket_texture` varchar(255) NOT NULL DEFAULT '2',
  `ears` varchar(255) NOT NULL DEFAULT '1',
  `ears_texture` varchar(255) NOT NULL DEFAULT '0',
  `char_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `clothing_FK1` (`char_id`),
  CONSTRAINT `clothing_FK1` FOREIGN KEY (`char_id`) REFERENCES `characters` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table drp.character_inventory: ~1 rows (approximately)
/*!40000 ALTER TABLE `character_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_inventory` ENABLE KEYS */;

-- Dumping structure for table drp.inventory_items
CREATE TABLE IF NOT EXISTS `inventory_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `itemname` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table drp.inventory_items: ~3 rows (approximately)
/*!40000 ALTER TABLE `inventory_items` DISABLE KEYS */;
INSERT INTO `inventory_items` (`id`, `itemname`) VALUES
	(1, 'water'),
	(2, 'lockpick'),
	(3, 'dildo'),
	(4, 'weed'),
	(5, 'marijuana');
/*!40000 ALTER TABLE `inventory_items` ENABLE KEYS */;

-- Dumping structure for table drp.police
CREATE TABLE IF NOT EXISTS `police` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rank` int(11) DEFAULT NULL,
  `division` varchar(50) COLLATE utf8_bin DEFAULT 'police',
  `char_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `police_fk1` (`char_id`),
  CONSTRAINT `police_fk1` FOREIGN KEY (`char_id`) REFERENCES `characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table drp.police: ~1 rows (approximately)
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table drp.users: ~0 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

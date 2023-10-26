

-- MariaDB dump 10.19  Distrib 10.7.3-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: naruto_v2
-- ------------------------------------------------------
-- Server version	10.7.3-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aldea`
--

DROP TABLE IF EXISTS `aldea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aldea` (
  `id_aldea` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_aldea` varchar(50) NOT NULL,
  `ubicacion` tinytext DEFAULT NULL,
  PRIMARY KEY (`id_aldea`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aldea`
--

LOCK TABLES `aldea` WRITE;
/*!40000 ALTER TABLE `aldea` DISABLE KEYS */;
INSERT INTO `aldea` VALUES
(1,'Konoha',NULL),
(2,'Sunagakure',NULL),
(3,'Kirigakure',NULL),
(4,'Iwagakure',NULL),
(5,'Kumogakure',NULL),
(6,'Otogakure',NULL),
(7,'Amegakure',NULL),
(8,'Takigakure',NULL),
(9,'Yugakure',NULL),
(10,'Kusagakure',NULL);
/*!40000 ALTER TABLE `aldea` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aldea_personaje`
--

DROP TABLE IF EXISTS `aldea_personaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aldea_personaje` (
  `id_aldea_personaje` int(11) NOT NULL AUTO_INCREMENT,
  `id_aldea` int(11) NOT NULL,
  `id_personaje` int(11) NOT NULL,
  `fecha_residencia` datetime NOT NULL,
  PRIMARY KEY (`id_aldea_personaje`),
  KEY `aldea_personaje_aldea_ID_Aldea_fk` (`id_aldea`),
  KEY `aldea_personaje_personaje_ID_Personaje_fk` (`id_personaje`),
  CONSTRAINT `aldea_personaje_aldea_ID_Aldea_fk` FOREIGN KEY (`id_aldea`) REFERENCES `aldea` (`id_aldea`),
  CONSTRAINT `aldea_personaje_personaje_ID_Personaje_fk` FOREIGN KEY (`id_personaje`) REFERENCES `personaje` (`id_personaje`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aldea_personaje`
--

LOCK TABLES `aldea_personaje` WRITE;
/*!40000 ALTER TABLE `aldea_personaje` DISABLE KEYS */;
/*!40000 ALTER TABLE `aldea_personaje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `arma`
--

DROP TABLE IF EXISTS `arma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arma` (
  `id_arma` int(11) NOT NULL AUTO_INCREMENT,
  `id_personaje` int(11) DEFAULT NULL,
  `nombre_arma` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_arma`),
  KEY `armas_personaje_ID_Personaje_fk` (`id_personaje`),
  CONSTRAINT `armas_personaje_ID_Personaje_fk` FOREIGN KEY (`id_personaje`) REFERENCES `personaje` (`id_personaje`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arma`
--

LOCK TABLES `arma` WRITE;
/*!40000 ALTER TABLE `arma` DISABLE KEYS */;
INSERT INTO `arma` VALUES
(1,1,'Kunai'),
(2,2,'Kusanagi'),
(3,3,'Shuriken'),
(4,4,'Chidori Blade'),
(5,5,'Sand Gourd'),
(6,6,'Kunai'),
(7,7,'Byakugan'),
(8,8,'Serpiente blanca'),
(9,9,'Pergamino de invocación'),
(10,10,'Brazalete de fuerza');
/*!40000 ALTER TABLE `arma` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `color_cabello`
--

DROP TABLE IF EXISTS `color_cabello`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `color_cabello` (
  `id_color_cabello` int(11) NOT NULL AUTO_INCREMENT,
  `id_personaje` int(11) DEFAULT NULL,
  `color_cabello` varchar(50) DEFAULT NULL,
  `fecha_color_cabello` date DEFAULT NULL,
  PRIMARY KEY (`id_color_cabello`),
  KEY `color_cabello_personaje_ID_Personaje_fk` (`id_personaje`),
  CONSTRAINT `color_cabello_personaje_ID_Personaje_fk` FOREIGN KEY (`id_personaje`) REFERENCES `personaje` (`id_personaje`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `color_cabello`
--

LOCK TABLES `color_cabello` WRITE;
/*!40000 ALTER TABLE `color_cabello` DISABLE KEYS */;
INSERT INTO `color_cabello` VALUES
(1,1,'Rubio',NULL),
(2,2,'Negro',NULL),
(3,3,'Rosado',NULL),
(4,4,'Blanco',NULL),
(5,5,'Rojo',NULL),
(6,6,'Negro',NULL),
(7,7,'Azul',NULL),
(8,8,'Verde',NULL),
(9,9,'Marrón',NULL),
(10,10,'Morado',NULL);
/*!40000 ALTER TABLE `color_cabello` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `habilidad_especial`
--

DROP TABLE IF EXISTS `habilidad_especial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `habilidad_especial` (
  `id_habilidad_especial` int(11) NOT NULL AUTO_INCREMENT,
  `id_personaje` int(11) DEFAULT NULL,
  `nombre_habilidad_especial` varchar(50) NOT NULL,
  PRIMARY KEY (`id_habilidad_especial`),
  KEY `habilidad_especial_personaje_ID_Personaje_fk` (`id_personaje`),
  CONSTRAINT `habilidad_especial_personaje_ID_Personaje_fk` FOREIGN KEY (`id_personaje`) REFERENCES `personaje` (`id_personaje`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habilidad_especial`
--

LOCK TABLES `habilidad_especial` WRITE;
/*!40000 ALTER TABLE `habilidad_especial` DISABLE KEYS */;
INSERT INTO `habilidad_especial` VALUES
(1,1,'Rasengan'),
(2,2,'Sharingan'),
(3,3,'Puño Fuerte'),
(4,4,'Raikiri'),
(5,5,'Control de Arena'),
(6,6,'Mangekyou Sharingan'),
(7,7,'Byakugan'),
(8,8,'Jutsus de serpiente'),
(9,9,'Técnicas de invocación'),
(10,10,'Poderes de sanación');
/*!40000 ALTER TABLE `habilidad_especial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jutsu`
--

DROP TABLE IF EXISTS `jutsu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jutsu` (
  `id_jutsu` int(11) NOT NULL AUTO_INCREMENT,
  `id_personaje` int(11) DEFAULT NULL,
  `nombre_jutsu` varchar(50) NOT NULL,
  PRIMARY KEY (`id_jutsu`),
  KEY `jutsu_personaje_ID_Personaje_fk` (`id_personaje`),
  CONSTRAINT `jutsu_personaje_ID_Personaje_fk` FOREIGN KEY (`id_personaje`) REFERENCES `personaje` (`id_personaje`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jutsu`
--

LOCK TABLES `jutsu` WRITE;
/*!40000 ALTER TABLE `jutsu` DISABLE KEYS */;
INSERT INTO `jutsu` VALUES
(1,1,'Shadow Clone Jutsu'),
(2,2,'Fireball Jutsu'),
(3,3,'Healing Jutsu'),
(4,4,'Lightning Blade'),
(5,5,'Sand Coffin'),
(6,6,'Tsukuyomi'),
(7,7,'Eight Trigrams Palm Rotation'),
(8,8,'Summoning Jutsu: Giant Snakes'),
(9,9,'Summoning Jutsu: Toad'),
(10,10,'Summoning Jutsu: Slug');
/*!40000 ALTER TABLE `jutsu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kekkei_genkai`
--

DROP TABLE IF EXISTS `kekkei_genkai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kekkei_genkai` (
  `id_kekkei_genkai` int(11) NOT NULL AUTO_INCREMENT,
  `id_personaje` int(11) DEFAULT NULL,
  `nombre_kekkei_genkai` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_kekkei_genkai`),
  KEY `kekkei_genkai_personaje_ID_Personaje_fk` (`id_personaje`),
  CONSTRAINT `kekkei_genkai_personaje_ID_Personaje_fk` FOREIGN KEY (`id_personaje`) REFERENCES `personaje` (`id_personaje`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kekkei_genkai`
--

LOCK TABLES `kekkei_genkai` WRITE;
/*!40000 ALTER TABLE `kekkei_genkai` DISABLE KEYS */;
INSERT INTO `kekkei_genkai` VALUES
(1,2,'Amaterasu'),
(2,4,'Earth Style: Earth Dragon Bullet'),
(3,5,'Sand Manipulation'),
(4,6,'Tsukuyomi'),
(5,7,'Gentle Fist'),
(6,8,'Snake Techniques'),
(7,9,'Toad Techniques'),
(8,10,'Slug Techniques');
/*!40000 ALTER TABLE `kekkei_genkai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personaje`
--

DROP TABLE IF EXISTS `personaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personaje` (
  `id_personaje` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_personaje` varchar(50) DEFAULT NULL,
  `estatura` int(11) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `id_aldea_nacimiento` int(11) DEFAULT NULL,
  `id_aldea_residencia` int(11) DEFAULT NULL,
  `rango_ninja` tinytext DEFAULT NULL,
  `estado` tinytext DEFAULT NULL,
  PRIMARY KEY (`id_personaje`),
  KEY `personaje_aldeas_ID_Aldea_fk` (`id_aldea_residencia`),
  KEY `personaje_aldeas_ID_Aldea_fk2` (`id_aldea_nacimiento`),
  CONSTRAINT `personaje_aldeas_ID_Aldea_fk` FOREIGN KEY (`id_aldea_residencia`) REFERENCES `aldea` (`id_aldea`),
  CONSTRAINT `personaje_aldeas_ID_Aldea_fk2` FOREIGN KEY (`id_aldea_nacimiento`) REFERENCES `aldea` (`id_aldea`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb3 COMMENT='Entidad que representa a un personaje.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personaje`
--

LOCK TABLES `personaje` WRITE;
/*!40000 ALTER TABLE `personaje` DISABLE KEYS */;
INSERT INTO `personaje` VALUES
(1,'Naruto',170,'1997-10-10',1,1,'Kage','Vivo'),
(2,'Sasuke',180,'1997-07-23',1,1,'Kage','Vivo'),
(3,'Sakura',165,'1997-03-28',1,1,'Anbu','Vivo'),
(4,'Kakashi',178,'1970-09-15',1,1,'Kage','Vivo'),
(5,'Gaara',175,'1995-01-19',2,2,'Kage','Vivo'),
(6,'Itachi',178,'1984-06-09',1,1,'Kage','Fallecido'),
(7,'Hinata',163,'1998-12-27',1,1,'Jonin','Vivo'),
(8,'Orochimaru',185,'1971-12-27',6,6,'Sannin','Vivo'),
(9,'Jiraiya',185,'1972-11-12',1,1,'Sannin','Fallecido'),
(10,'Tsunade',163,'1971-07-01',1,1,'Sannin','Fallecido'),
(11,'Ino',165,'1997-09-01',1,1,'Jonin','Vivo'),
(12,'Shikamaru',175,'1997-11-03',1,1,'Jonin','Vivo'),
(13,'Choji',170,'1997-05-09',1,1,'Jonin','Vivo'),
(14,'Rock Lee',172,'1997-07-27',1,1,'Jonin','Vivo'),
(15,'Neji',178,'1997-04-15',1,1,'Anbu','Vivo'),
(16,'Tenten',165,'1997-02-22',1,1,'Jonin','Vivo'),
(17,'Kiba',175,'1997-08-14',1,1,'Jonin','Vivo'),
(18,'Shino',178,'1997-06-19',1,1,'Jonin','Vivo'),
(19,'Haku',168,'1997-03-11',3,3,'Chunin','Vivo'),
(20,'Zabuza',185,'1997-12-07',3,3,'Chunin','Vivo'),
(21,'Orochimaru',178,'1975-09-15',6,6,'Kage','Vivo'),
(22,'Jiraiya',183,'1965-11-29',1,1,'Kage','Vivo'),
(23,'Tsunade',163,'1968-08-02',1,1,'Kage','Vivo'),
(24,'Kabuto',175,'1980-06-25',6,6,'Anbu','Vivo'),
(25,'Pain',185,'1986-03-10',7,7,'Kage','Vivo'),
(26,'Konan',168,'1987-05-15',7,7,'Anbu','Vivo'),
(27,'Sai',173,'1989-01-20',1,1,'Jonin','Vivo'),
(28,'Yamato',180,'1982-07-18',1,1,'Anbu','Vivo'),
(29,'Karin',160,'1984-04-07',6,6,'Jonin','Vivo'),
(30,'Suigetsu',175,'1990-02-11',6,6,'Jonin','Vivo'),
(31,'Jiroubou',195,'1996-04-03',4,4,'Jonin','Vivo'),
(32,'Kidoumaru',180,'1995-07-21',4,4,'Anbu','Vivo'),
(33,'Sakon',170,'1997-02-10',4,4,'Anbu','Vivo'),
(34,'Tayuya',165,'1997-11-28',4,4,'Anbu','Vivo'),
(35,'Kankurou',177,'1996-09-08',2,2,'Anbu','Vivo'),
(36,'Temari',168,'1994-08-23',2,2,'Anbu','Vivo'),
(37,'Kurenai',170,'1978-11-16',1,1,'Kage','Vivo'),
(38,'Shizune',163,'1981-03-05',1,1,'Anbu','Vivo'),
(39,'Yahiko',170,'1984-06-27',7,7,'Jonin','Fallecido'),
(40,'Konohamaru',130,'2003-02-14',1,1,'Jonin','Vivo'),
(41,'Iruka',175,'1982-05-26',1,1,'Anbu','Vivo'),
(42,'Danzou',172,'1940-12-07',1,1,'Kage','Fallecido'),
(43,'Shisui',179,'1986-09-12',1,1,'Anbu','Fallecido'),
(44,'Deidara',180,'1989-05-05',3,3,'Anbu','Vivo'),
(45,'Sasori',165,'1979-11-08',3,3,'Anbu','Vivo'),
(46,'Hidan',185,'1980-03-02',5,5,'Anbu','Vivo'),
(47,'Kakuzu',190,'1977-07-15',5,5,'Anbu','Vivo'),
(48,'Mei',168,'1983-01-25',3,3,'Kage','Vivo'),
(49,'Ao',178,'1982-10-17',3,3,'Anbu','Vivo'),
(50,'Kurotsuchi',175,'1990-09-09',3,3,'Anbu','Vivo');
/*!40000 ALTER TABLE `personaje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relacion`
--

DROP TABLE IF EXISTS `relacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relacion` (
  `id_relacion` int(11) NOT NULL AUTO_INCREMENT,
  `id_personaje_a` int(11) DEFAULT NULL,
  `id_personaje_b` int(11) DEFAULT NULL,
  `descripcion_relacion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_relacion`),
  KEY `relacion_personaje_ID_Personaje_fk` (`id_personaje_a`),
  KEY `relacion_personaje_ID_Personaje_fk2` (`id_personaje_b`),
  CONSTRAINT `relacion_personaje_ID_Personaje_fk` FOREIGN KEY (`id_personaje_a`) REFERENCES `personaje` (`id_personaje`),
  CONSTRAINT `relacion_personaje_ID_Personaje_fk2` FOREIGN KEY (`id_personaje_b`) REFERENCES `personaje` (`id_personaje`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relacion`
--

LOCK TABLES `relacion` WRITE;
/*!40000 ALTER TABLE `relacion` DISABLE KEYS */;
INSERT INTO `relacion` VALUES
(1,1,2,'Amigos'),
(2,1,3,'Compañeros de equipo'),
(3,2,3,'Rivales'),
(4,3,4,'Maestro y estudiante'),
(5,4,5,'Aliados'),
(6,4,6,'Hermanos'),
(7,7,1,'Conocidos'),
(8,8,9,'Antiguos compañeros de equipo'),
(9,9,10,'Maestro y estudiante'),
(10,5,10,'Enemigos'),
(11,5,6,'Antiguos compañeros de equipo'),
(12,6,10,'Rivales'),
(13,11,12,'Amigos de la infancia'),
(14,11,13,'Compañeros de equipo'),
(15,12,13,'Amigos'),
(16,14,13,'Compañeros de equipo'),
(17,14,15,'Rivales'),
(18,14,16,'Maestro y estudiante'),
(19,17,18,'Compañeros de equipo'),
(20,17,19,'Amigos'),
(21,18,19,'Aliados'),
(22,20,21,'Maestro y estudiante'),
(23,20,22,'Enemigos'),
(24,21,22,'Antiguos compañeros de equipo'),
(25,23,24,'Maestro y estudiante'),
(26,23,25,'Compañeros de equipo'),
(27,25,26,'Amigos'),
(28,25,27,'Aliados'),
(29,28,29,'Antiguos compañeros de equipo'),
(30,28,30,'Rivales'),
(31,28,31,'Compañeros de equipo'),
(32,32,33,'Maestro y estudiante'),
(33,32,34,'Amigos'),
(34,33,34,'Aliados'),
(35,35,36,'Rivales'),
(36,35,37,'Enemigos'),
(37,35,38,'Compañeros de equipo'),
(38,39,40,'Amigos'),
(39,39,41,'Compañeros de equipo'),
(40,42,43,'Maestro y estudiante'),
(41,42,44,'Aliados'),
(42,45,46,'Enemigos'),
(43,45,47,'Rivales'),
(44,45,48,'Compañeros de equipo'),
(45,45,49,'Aliados'),
(46,1,7,'Compañeros de equipo'),
(47,2,7,'Rivales'),
(48,1,8,'Amigos'),
(49,2,8,'Rivales'),
(50,3,8,'Compañeros de equipo'),
(51,4,9,'Maestro y estudiante'),
(52,5,9,'Aliados'),
(53,1,10,'Compañeros de equipo'),
(54,3,10,'Amigos'),
(55,4,11,'Rivales'),
(56,5,11,'Compañeros de equipo'),
(57,6,11,'Maestro y estudiante'),
(58,12,13,'Amigos'),
(59,12,14,'Rivales'),
(60,12,15,'Compañeros de equipo'),
(61,16,17,'Rivales'),
(62,16,18,'Amigos'),
(63,17,18,'Aliados'),
(64,19,20,'Compañeros de equipo'),
(65,21,22,'Maestro y estudiante'),
(66,21,23,'Rivales');
/*!40000 ALTER TABLE `relacion` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-26 13:24:39

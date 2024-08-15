
#DROP DATABASE IF EXISTS naruto2;
-- Create the database
#CREATE DATABASE naruto;
-- Use the newly created database
#USE naruto;

-- MariaDB dump 10.19  Distrib 10.7.3-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: naruto2_v1
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aldea`
--

LOCK TABLES `aldea` WRITE;
/*!40000 ALTER TABLE `aldea` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arma`
--

LOCK TABLES `arma` WRITE;
/*!40000 ALTER TABLE `arma` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `color_cabello`
--

LOCK TABLES `color_cabello` WRITE;
/*!40000 ALTER TABLE `color_cabello` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habilidad_especial`
--

LOCK TABLES `habilidad_especial` WRITE;
/*!40000 ALTER TABLE `habilidad_especial` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jutsu`
--

LOCK TABLES `jutsu` WRITE;
/*!40000 ALTER TABLE `jutsu` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kekkei_genkai`
--

LOCK TABLES `kekkei_genkai` WRITE;
/*!40000 ALTER TABLE `kekkei_genkai` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Entidad que representa a un personaje.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personaje`
--

LOCK TABLES `personaje` WRITE;
/*!40000 ALTER TABLE `personaje` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relacion`
--

LOCK TABLES `relacion` WRITE;
/*!40000 ALTER TABLE `relacion` DISABLE KEYS */;
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

-- Dump completed on 2023-08-10  0:50:23

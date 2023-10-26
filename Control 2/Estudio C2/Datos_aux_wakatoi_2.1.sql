-- MariaDB dump 10.19  Distrib 10.7.3-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: wotakoi_v2_1
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
-- Table structure for table `album`
--

DROP TABLE IF EXISTS `album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `album` (
  `id_album` int(11) NOT NULL AUTO_INCREMENT,
  `id_artista` int(11) NOT NULL,
  `nombre_album` tinytext NOT NULL,
  PRIMARY KEY (`id_album`),
  KEY `album___fk` (`id_artista`),
  CONSTRAINT `album___fk` FOREIGN KEY (`id_artista`) REFERENCES `artistas` (`id_artista`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album`
--

LOCK TABLES `album` WRITE;
/*!40000 ALTER TABLE `album` DISABLE KEYS */;
/*!40000 ALTER TABLE `album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amigos`
--

DROP TABLE IF EXISTS `amigos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amigos` (
  `id_amigo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` tinytext NOT NULL,
  `birthday` date NOT NULL,
  `estatura` int(11) NOT NULL,
  PRIMARY KEY (`id_amigo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amigos`
--

LOCK TABLES `amigos` WRITE;
/*!40000 ALTER TABLE `amigos` DISABLE KEYS */;
INSERT INTO `amigos` VALUES
(1,'Narumi','2023-04-04',158),
(2,'Narumi 2','2023-04-04',158),
(3,'Narumi 3','2023-04-04',158),
(4,'Narumi 4','2023-04-04',158);
/*!40000 ALTER TABLE `amigos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amigos_animes_series`
--

DROP TABLE IF EXISTS `amigos_animes_series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amigos_animes_series` (
  `id_amigo_anime_serie` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_inicio` datetime NOT NULL,
  `fecha_termino` datetime DEFAULT NULL,
  `id_amigo` int(11) NOT NULL,
  `id_anime_serie` int(11) NOT NULL,
  PRIMARY KEY (`id_amigo_anime_serie`),
  KEY `amigos_animes_series_amigos_id_amigo_fk` (`id_amigo`),
  KEY `amigos_animes_series_animes_series_id_anime_serie_fk` (`id_anime_serie`),
  CONSTRAINT `amigos_animes_series_amigos_id_amigo_fk` FOREIGN KEY (`id_amigo`) REFERENCES `amigos` (`id_amigo`),
  CONSTRAINT `amigos_animes_series_animes_series_id_anime_serie_fk` FOREIGN KEY (`id_anime_serie`) REFERENCES `animes_series` (`id_anime_serie`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amigos_animes_series`
--

LOCK TABLES `amigos_animes_series` WRITE;
/*!40000 ALTER TABLE `amigos_animes_series` DISABLE KEYS */;
INSERT INTO `amigos_animes_series` VALUES
(1,'2023-04-05 00:20:52','2023-04-05 00:20:52',1,1),
(2,'2023-04-05 00:20:52','2023-04-05 00:20:52',2,1),
(3,'2023-04-05 00:20:52','2023-04-05 00:20:52',3,2);
/*!40000 ALTER TABLE `amigos_animes_series` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amigos_figuritas`
--

DROP TABLE IF EXISTS `amigos_figuritas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amigos_figuritas` (
  `id_figurita_amigo` int(11) NOT NULL AUTO_INCREMENT,
  `id_figurita` int(11) NOT NULL,
  `id_regalador` int(11) DEFAULT NULL,
  `fecha` date NOT NULL,
  `id_amigo` int(11) NOT NULL,
  PRIMARY KEY (`id_figurita_amigo`),
  KEY `amigos_figuritas_amigos_id_amigo_fk` (`id_regalador`),
  KEY `amigos_figuritas_figuritas_id_figurita_fk` (`id_figurita`),
  KEY `amigos_figuritas_amigos_id_amigo_fk2` (`id_amigo`),
  CONSTRAINT `amigos_figuritas_amigos_id_amigo_fk` FOREIGN KEY (`id_regalador`) REFERENCES `amigos` (`id_amigo`),
  CONSTRAINT `amigos_figuritas_amigos_id_amigo_fk2` FOREIGN KEY (`id_amigo`) REFERENCES `amigos` (`id_amigo`),
  CONSTRAINT `amigos_figuritas_figuritas_id_figurita_fk` FOREIGN KEY (`id_figurita`) REFERENCES `figuritas` (`id_figurita`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amigos_figuritas`
--

LOCK TABLES `amigos_figuritas` WRITE;
/*!40000 ALTER TABLE `amigos_figuritas` DISABLE KEYS */;
/*!40000 ALTER TABLE `amigos_figuritas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `animes_series`
--

DROP TABLE IF EXISTS `animes_series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animes_series` (
  `id_anime_serie` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` tinytext NOT NULL,
  `plataforma` tinytext NOT NULL,
  PRIMARY KEY (`id_anime_serie`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animes_series`
--

LOCK TABLES `animes_series` WRITE;
/*!40000 ALTER TABLE `animes_series` DISABLE KEYS */;
INSERT INTO `animes_series` VALUES
(1,'wotakoi','crunchyroll'),
(2,'test','amazon');
/*!40000 ALTER TABLE `animes_series` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artistas`
--

DROP TABLE IF EXISTS `artistas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artistas` (
  `id_artista` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_artista` tinytext NOT NULL,
  `fecha_debut` date DEFAULT NULL,
  PRIMARY KEY (`id_artista`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artistas`
--

LOCK TABLES `artistas` WRITE;
/*!40000 ALTER TABLE `artistas` DISABLE KEYS */;
/*!40000 ALTER TABLE `artistas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `canciones`
--

DROP TABLE IF EXISTS `canciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `canciones` (
  `id_cancion` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_cancion` tinytext DEFAULT NULL,
  `id_artista` int(11) NOT NULL,
  `id_album` int(11) DEFAULT NULL,
  `lanzamiento` date NOT NULL,
  PRIMARY KEY (`id_cancion`),
  KEY `canciones_artistas_id_artista_fk` (`id_artista`),
  KEY `canciones_album_id_album_fk` (`id_album`),
  CONSTRAINT `canciones_album_id_album_fk` FOREIGN KEY (`id_album`) REFERENCES `album` (`id_album`),
  CONSTRAINT `canciones_artistas_id_artista_fk` FOREIGN KEY (`id_artista`) REFERENCES `artistas` (`id_artista`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canciones`
--

LOCK TABLES `canciones` WRITE;
/*!40000 ALTER TABLE `canciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `canciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `color_pelo`
--

DROP TABLE IF EXISTS `color_pelo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `color_pelo` (
  `id_color_pelo` int(11) NOT NULL AUTO_INCREMENT,
  `color` tinytext NOT NULL,
  `fecha` datetime NOT NULL,
  `id_amigo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_color_pelo`),
  KEY `color_pelo_amigos_id_amigo_fk` (`id_amigo`),
  CONSTRAINT `color_pelo_amigos_id_amigo_fk` FOREIGN KEY (`id_amigo`) REFERENCES `amigos` (`id_amigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `color_pelo`
--

LOCK TABLES `color_pelo` WRITE;
/*!40000 ALTER TABLE `color_pelo` DISABLE KEYS */;
/*!40000 ALTER TABLE `color_pelo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estilo`
--

DROP TABLE IF EXISTS `estilo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estilo` (
  `id_estilo` int(11) NOT NULL,
  `nombre_estilo` tinytext NOT NULL,
  `id_amigo` int(11) NOT NULL,
  PRIMARY KEY (`id_estilo`),
  KEY `estilo_amigos_id_amigo_fk` (`id_amigo`),
  CONSTRAINT `estilo_amigos_id_amigo_fk` FOREIGN KEY (`id_amigo`) REFERENCES `amigos` (`id_amigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estilo`
--

LOCK TABLES `estilo` WRITE;
/*!40000 ALTER TABLE `estilo` DISABLE KEYS */;
/*!40000 ALTER TABLE `estilo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventos`
--

DROP TABLE IF EXISTS `eventos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventos` (
  `id_evento` int(11) NOT NULL,
  `nombre_evento` tinytext NOT NULL,
  `amigo_a` int(11) NOT NULL,
  `amigo_b` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  PRIMARY KEY (`id_evento`),
  KEY `eventos_amigos_id_amigo_fk` (`amigo_a`),
  KEY `eventos_amigos_id_amigo_fk2` (`amigo_b`),
  CONSTRAINT `eventos_amigos_id_amigo_fk` FOREIGN KEY (`amigo_a`) REFERENCES `amigos` (`id_amigo`),
  CONSTRAINT `eventos_amigos_id_amigo_fk2` FOREIGN KEY (`amigo_b`) REFERENCES `amigos` (`id_amigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventos`
--

LOCK TABLES `eventos` WRITE;
/*!40000 ALTER TABLE `eventos` DISABLE KEYS */;
/*!40000 ALTER TABLE `eventos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `figuritas`
--

DROP TABLE IF EXISTS `figuritas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `figuritas` (
  `id_figurita` int(11) NOT NULL,
  `nombre_figurita` tinytext NOT NULL,
  `marca` tinytext NOT NULL,
  PRIMARY KEY (`id_figurita`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `figuritas`
--

LOCK TABLES `figuritas` WRITE;
/*!40000 ALTER TABLE `figuritas` DISABLE KEYS */;
/*!40000 ALTER TABLE `figuritas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `like_cancion`
--

DROP TABLE IF EXISTS `like_cancion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `like_cancion` (
  `id_like_cancion` int(11) NOT NULL AUTO_INCREMENT,
  `id_amigo` int(11) NOT NULL,
  `id_cancion` int(11) NOT NULL,
  `fecha_like` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id_like_cancion`),
  UNIQUE KEY `like_cancion_pk2` (`id_cancion`,`id_amigo`),
  KEY `like_cancion_canciones_id_cancion_fk` (`id_amigo`),
  CONSTRAINT `like_cancion_amigos_id_amigo_fk` FOREIGN KEY (`id_amigo`) REFERENCES `amigos` (`id_amigo`),
  CONSTRAINT `like_cancion_canciones_id_cancion_fk` FOREIGN KEY (`id_cancion`) REFERENCES `canciones` (`id_cancion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `like_cancion`
--

LOCK TABLES `like_cancion` WRITE;
/*!40000 ALTER TABLE `like_cancion` DISABLE KEYS */;
/*!40000 ALTER TABLE `like_cancion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lista`
--

DROP TABLE IF EXISTS `lista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lista` (
  `id_lista` int(11) NOT NULL AUTO_INCREMENT,
  `id_creador` int(11) DEFAULT NULL,
  `nombre_lista` tinytext DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_lista`),
  KEY `lista_amigos_id_amigo_fk` (`id_creador`),
  CONSTRAINT `lista_amigos_id_amigo_fk` FOREIGN KEY (`id_creador`) REFERENCES `amigos` (`id_amigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lista`
--

LOCK TABLES `lista` WRITE;
/*!40000 ALTER TABLE `lista` DISABLE KEYS */;
/*!40000 ALTER TABLE `lista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lista_amigos`
--

DROP TABLE IF EXISTS `lista_amigos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lista_amigos` (
  `id_lista_amigos` int(11) NOT NULL AUTO_INCREMENT,
  `id_amigo` int(11) DEFAULT NULL,
  `id_lista` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_lista_amigos`),
  KEY `lista_amigos_amigos_id_amigo_fk` (`id_amigo`),
  KEY `lista_amigos_lista_id_lista_fk` (`id_lista`),
  CONSTRAINT `lista_amigos_amigos_id_amigo_fk` FOREIGN KEY (`id_amigo`) REFERENCES `amigos` (`id_amigo`),
  CONSTRAINT `lista_amigos_lista_id_lista_fk` FOREIGN KEY (`id_lista`) REFERENCES `lista` (`id_lista`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lista_amigos`
--

LOCK TABLES `lista_amigos` WRITE;
/*!40000 ALTER TABLE `lista_amigos` DISABLE KEYS */;
/*!40000 ALTER TABLE `lista_amigos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lista_canciones`
--

DROP TABLE IF EXISTS `lista_canciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lista_canciones` (
  `id_lista_canciones` int(11) NOT NULL AUTO_INCREMENT,
  `id_lista` int(11) DEFAULT NULL,
  `id_cancion` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_lista_canciones`),
  UNIQUE KEY `lista_canciones_pk2` (`id_lista`,`id_cancion`),
  KEY `lista_canciones___fk2` (`id_cancion`),
  CONSTRAINT `lista_canciones___fk` FOREIGN KEY (`id_lista`) REFERENCES `lista` (`id_lista`),
  CONSTRAINT `lista_canciones___fk2` FOREIGN KEY (`id_cancion`) REFERENCES `canciones` (`id_cancion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lista_canciones`
--

LOCK TABLES `lista_canciones` WRITE;
/*!40000 ALTER TABLE `lista_canciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `lista_canciones` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-19  1:04:41

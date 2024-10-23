-- MySQL dump 10.13  Distrib 8.0.39, for Linux (x86_64)
--
-- Host: localhost    Database: StarWars
-- ------------------------------------------------------
-- Server version	8.0.39-0ubuntu0.24.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Character`
--

DROP TABLE IF EXISTS `Character`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Character` (
  `CharacterId` int NOT NULL,
  `Name` varchar(100) NOT NULL,
  `ActorId` int DEFAULT NULL,
  `CanUseForce` tinyint(1) NOT NULL,
  PRIMARY KEY (`CharacterId`),
  KEY `ActorId` (`ActorId`),
  CONSTRAINT `Character_ibfk_1` FOREIGN KEY (`ActorId`) REFERENCES `Person` (`PersonID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Character`
--

LOCK TABLES `Character` WRITE;
/*!40000 ALTER TABLE `Character` DISABLE KEYS */;
INSERT INTO `Character` VALUES (1,'Obi-Wan Kenobi',1,1),(2,'Qui-Gon Jinn',2,1),(3,'Anakin Skywalker',3,1);
/*!40000 ALTER TABLE `Character` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Movie`
--

DROP TABLE IF EXISTS `Movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Movie` (
  `FilmID` int NOT NULL,
  `Title` varchar(300) DEFAULT NULL,
  `ReleaseDate` date DEFAULT NULL,
  `RunTimeMinutes` int DEFAULT NULL,
  `ScreenWriters` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`FilmID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Movie`
--

LOCK TABLES `Movie` WRITE;
/*!40000 ALTER TABLE `Movie` DISABLE KEYS */;
INSERT INTO `Movie` VALUES (1,'Episode I – The Phantom Menace','1999-05-19',136,NULL),(2,'Episode II – Attack of the Clones','2002-05-16',142,'George Lucas, Leigh Brackett'),(3,'Episode III – Revenge of the Sith','2005-05-19',140,NULL);
/*!40000 ALTER TABLE `Movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MovieCharacter`
--

DROP TABLE IF EXISTS `MovieCharacter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MovieCharacter` (
  `FilmID` int NOT NULL,
  `CharacterId` int NOT NULL,
  PRIMARY KEY (`FilmID`,`CharacterId`),
  KEY `CharacterId` (`CharacterId`),
  CONSTRAINT `MovieCharacter_ibfk_1` FOREIGN KEY (`FilmID`) REFERENCES `Movie` (`FilmID`),
  CONSTRAINT `MovieCharacter_ibfk_2` FOREIGN KEY (`CharacterId`) REFERENCES `Character` (`CharacterId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MovieCharacter`
--

LOCK TABLES `MovieCharacter` WRITE;
/*!40000 ALTER TABLE `MovieCharacter` DISABLE KEYS */;
INSERT INTO `MovieCharacter` VALUES (1,1),(1,2),(1,3);
/*!40000 ALTER TABLE `MovieCharacter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MovieDirector`
--

DROP TABLE IF EXISTS `MovieDirector`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MovieDirector` (
  `FilmID` int NOT NULL,
  `PersonID` int NOT NULL,
  PRIMARY KEY (`FilmID`,`PersonID`),
  KEY `PersonID` (`PersonID`),
  CONSTRAINT `MovieDirector_ibfk_1` FOREIGN KEY (`FilmID`) REFERENCES `Movie` (`FilmID`),
  CONSTRAINT `MovieDirector_ibfk_2` FOREIGN KEY (`PersonID`) REFERENCES `Person` (`PersonID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MovieDirector`
--

LOCK TABLES `MovieDirector` WRITE;
/*!40000 ALTER TABLE `MovieDirector` DISABLE KEYS */;
INSERT INTO `MovieDirector` VALUES (1,4),(1,7);
/*!40000 ALTER TABLE `MovieDirector` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Person`
--

DROP TABLE IF EXISTS `Person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Person` (
  `PersonID` int NOT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `Lastname` varchar(50) DEFAULT NULL,
  `Birthdate` date DEFAULT NULL,
  PRIMARY KEY (`PersonID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Person`
--

LOCK TABLES `Person` WRITE;
/*!40000 ALTER TABLE `Person` DISABLE KEYS */;
INSERT INTO `Person` VALUES (1,'Ewan','McGregor','1971-03-31'),(2,'Liam','Neeson','1952-06-07'),(3,'Jake','Lloyd','1989-03-05'),(4,'George','Lucas','1971-03-31'),(7,'Jonathan','Hales','1974-06-20');
/*!40000 ALTER TABLE `Person` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-23 19:27:12

-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: localhost    Database: footprint_db
-- ------------------------------------------------------
-- Server version	8.0.45-0ubuntu0.24.04.1

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
-- Table structure for table `local_breaches`
--

DROP TABLE IF EXISTS `local_breaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `local_breaches` (
  `id` int NOT NULL AUTO_INCREMENT,
  `target` varchar(255) NOT NULL,
  `breach_source` varchar(255) NOT NULL,
  `severity` varchar(10) DEFAULT NULL,
  `leak_score` int DEFAULT NULL,
  `leak_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `local_breaches`
--

LOCK TABLES `local_breaches` WRITE;
/*!40000 ALTER TABLE `local_breaches` DISABLE KEYS */;
INSERT INTO `local_breaches` VALUES (31,'test@gmail.com','LinkedIn','LOW',25,'2021-05-10'),(32,'test@gmail.com','Adobe','HIGH',75,'2020-11-22'),(33,'user123@yahoo.com','Dropbox','MEDIUM',50,'2022-01-15'),(34,'user123@yahoo.com','Canva','HIGH',70,'2023-02-10'),(35,'admin@company.com','Facebook','HIGH',80,'2021-08-12'),(36,'admin@company.com','Twitter','MEDIUM',55,'2022-04-19'),(37,'john.doe@gmail.com','MyFitnessPal','HIGH',78,'2020-03-25'),(38,'john.doe@gmail.com','Zynga','LOW',30,'2019-07-11'),(39,'jane@gmail.com','Snapchat','HIGH',85,'2022-06-14'),(40,'jane@gmail.com','Tumblr','MEDIUM',60,'2021-09-09'),(41,'192.168.1.1','Botnet Activity','CRITICAL',95,'2024-01-01'),(42,'192.168.1.1','Port Scan','HIGH',75,'2024-02-11'),(43,'10.0.0.5','Malware Host','CRITICAL',98,'2024-03-05'),(44,'10.0.0.5','DDoS Node','HIGH',85,'2024-02-20'),(45,'172.16.0.3','Suspicious Traffic','MEDIUM',55,'2023-11-12'),(46,'172.16.0.3','Brute Force','HIGH',78,'2024-01-22'),(47,'http://phishing.com','Phishing Campaign','CRITICAL',92,'2024-02-02'),(48,'http://phishing.com','Credential Theft','CRITICAL',96,'2024-02-03'),(49,'https://fakebank.com','Fake Login','CRITICAL',97,'2024-01-15'),(50,'https://fakebank.com','Data Theft','HIGH',88,'2024-01-18'),(51,'http://malware-site.com','Trojan Distribution','CRITICAL',99,'2024-03-01'),(52,'http://malware-site.com','Drive-by Download','HIGH',87,'2024-03-03'),(53,'user@test.com','LinkedIn','LOW',20,'2021-02-11'),(54,'user@test.com','Adobe','MEDIUM',50,'2020-09-09'),(55,'secure@bank.com','Bank Leak','CRITICAL',100,'2023-12-01'),(56,'secure@bank.com','Credential Dump','HIGH',85,'2023-12-02');
/*!40000 ALTER TABLE `local_breaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scans`
--

DROP TABLE IF EXISTS `scans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `target` varchar(255) DEFAULT NULL,
  `breaches_found` int DEFAULT NULL,
  `risk_score` int DEFAULT NULL,
  `scan_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scans`
--

LOCK TABLES `scans` WRITE;
/*!40000 ALTER TABLE `scans` DISABLE KEYS */;
INSERT INTO `scans` VALUES (1,'fardeenakmal123@gmail.com',0,5,'2026-03-19 15:25:38'),(2,'https://phishing-site.net',1,25,'2026-03-19 15:26:07'),(3,'fardeenakmal123@gmail.com',0,11,'2026-03-19 16:18:57'),(4,'www.facebook.com',0,13,'2026-03-19 16:19:43'),(5,'fardeenakmal123@gmail.com',0,13,'2026-03-19 16:31:29'),(6,'fardeenakmal123@gmail.com',0,13,'2026-03-19 16:33:44');
/*!40000 ALTER TABLE `scans` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-19 23:27:25

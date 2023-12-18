-- MariaDB dump 10.19  Distrib 10.11.4-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: utop
-- ------------------------------------------------------
-- Server version	10.11.4-MariaDB-1~deb12u1

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
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course` (
  `id` varchar(255) NOT NULL,
  `teacher_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES
('CSE1001','100271'),
('CSE2001','100271'),
('CSE3001','100271');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrolled`
--

DROP TABLE IF EXISTS `enrolled`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enrolled` (
  `student_id` varchar(255) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `midterm_mks` int(11) DEFAULT NULL,
  `termend_mks` int(11) DEFAULT NULL,
  `internal_mks` int(11) DEFAULT NULL,
  `grade` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`student_id`,`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrolled`
--

LOCK TABLES `enrolled` WRITE;
/*!40000 ALTER TABLE `enrolled` DISABLE KEYS */;
INSERT INTO `enrolled` VALUES
('21B01','CSE1001',NULL,NULL,NULL,NULL),
('21B01','CSE2001',NULL,NULL,NULL,NULL),
('21B01','CSE3001',NULL,NULL,NULL,NULL),
('21B02','CSE1001',NULL,NULL,NULL,NULL),
('21B02','CSE2001',NULL,NULL,NULL,NULL),
('21B02','CSE3001',NULL,NULL,NULL,NULL),
('21B03','CSE1001',NULL,NULL,NULL,NULL),
('21B03','CSE2001',NULL,NULL,NULL,NULL),
('21B03','CSE3001',NULL,NULL,NULL,NULL),
('21B04','CSE1001',NULL,NULL,NULL,NULL),
('21B04','CSE2001',NULL,NULL,NULL,NULL),
('21B04','CSE3001',NULL,NULL,NULL,NULL),
('21B05','CSE1001',NULL,NULL,NULL,NULL),
('21B05','CSE2001',NULL,NULL,NULL,NULL),
('21B05','CSE3001',NULL,NULL,NULL,NULL),
('21B06','CSE1001',NULL,NULL,NULL,NULL),
('21B06','CSE2001',NULL,NULL,NULL,NULL),
('21B06','CSE3001',NULL,NULL,NULL,NULL),
('21B07','CSE1001',NULL,NULL,NULL,NULL),
('21B07','CSE2001',NULL,NULL,NULL,NULL),
('21B07','CSE3001',NULL,NULL,NULL,NULL),
('21B08','CSE1001',NULL,NULL,NULL,NULL),
('21B08','CSE2001',NULL,NULL,NULL,NULL),
('21B08','CSE3001',NULL,NULL,NULL,NULL),
('21B09','CSE1001',NULL,NULL,NULL,NULL),
('21B09','CSE2001',NULL,NULL,NULL,NULL),
('21B09','CSE3001',NULL,NULL,NULL,NULL),
('21B10','CSE1001',NULL,NULL,NULL,NULL),
('21B10','CSE2001',NULL,NULL,NULL,NULL),
('21B10','CSE3001',NULL,NULL,NULL,NULL),
('21B11','CSE1001',NULL,NULL,NULL,NULL),
('21B11','CSE2001',NULL,NULL,NULL,NULL),
('21B11','CSE3001',NULL,NULL,NULL,NULL),
('21B12','CSE1001',NULL,NULL,NULL,NULL),
('21B12','CSE2001',NULL,NULL,NULL,NULL),
('21B12','CSE3001',NULL,NULL,NULL,NULL),
('21B13','CSE1001',NULL,NULL,NULL,NULL),
('21B13','CSE2001',NULL,NULL,NULL,NULL),
('21B13','CSE3001',NULL,NULL,NULL,NULL),
('21B14','CSE1001',NULL,NULL,NULL,NULL),
('21B14','CSE2001',NULL,NULL,NULL,NULL),
('21B14','CSE3001',NULL,NULL,NULL,NULL),
('21B15','CSE1001',NULL,NULL,NULL,NULL),
('21B15','CSE2001',NULL,NULL,NULL,NULL),
('21B15','CSE3001',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `enrolled` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `passwd` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES
('21B01','Gul T','1234'),
('21B02','Varun N','1234'),
('21B03','Saketh C','1234'),
('21B04','Uday G','1234'),
('21B05','Ajitava D','1234'),
('21B06','Hemant V','1234'),
('21B07','Nadir K','1234'),
('21B08','Yashwardhan R','1234'),
('21B09','Hariji S','1234'),
('21B10','Kuldeep J','1234'),
('21B11','Sahil S','1234'),
('21B12','Shantanu M','1234'),
('21B13','Ashutosh P','1234'),
('21B14','Prateek S','1234'),
('21B15','Tarun J','1234');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teacher` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `passwd` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES
('100271','Balaji A','password123');
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-15  2:27:52

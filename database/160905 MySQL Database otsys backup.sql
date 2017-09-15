-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: otsys
-- ------------------------------------------------------
-- Server version	5.7.12-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `communcation_method`
--

DROP TABLE IF EXISTS `communcation_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `communcation_method` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  `Abbr` varchar(15) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `ShortName_UNIQUE` (`Abbr`),
  UNIQUE KEY `LongName_UNIQUE` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `communcation_method`
--

LOCK TABLES `communcation_method` WRITE;
/*!40000 ALTER TABLE `communcation_method` DISABLE KEYS */;
/*!40000 ALTER TABLE `communcation_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credentials`
--

DROP TABLE IF EXISTS `credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credentials` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(225) NOT NULL,
  `Password` varchar(225) NOT NULL,
  `UserId` int(11) NOT NULL,
  `IsActive` bit(1) DEFAULT NULL,
  `CreatedBy` int(11) NOT NULL,
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdatedBy` int(11) NOT NULL,
  `UpdateDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `username_UNIQUE` (`UserName`),
  KEY `Id_idx` (`UserId`),
  KEY `Id2_idx` (`CreatedBy`),
  KEY `Id3_idx` (`UpdatedBy`),
  CONSTRAINT `Id` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Id2` FOREIGN KEY (`CreatedBy`) REFERENCES `users` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Id3` FOREIGN KEY (`UpdatedBy`) REFERENCES `users` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credentials`
--

LOCK TABLES `credentials` WRITE;
/*!40000 ALTER TABLE `credentials` DISABLE KEYS */;
INSERT INTO `credentials` VALUES (1,'jwilson0206@gmail.com','Wilson13',1,'',1,'2016-06-20 22:40:01',1,'2016-06-20 22:40:01');
/*!40000 ALTER TABLE `credentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_events`
--

DROP TABLE IF EXISTS `system_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_events` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  `Abbr` varchar(15) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Name_UNIQUE` (`Name`),
  UNIQUE KEY `Abbr_UNIQUE` (`Abbr`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_events`
--

LOCK TABLES `system_events` WRITE;
/*!40000 ALTER TABLE `system_events` DISABLE KEYS */;
INSERT INTO `system_events` VALUES (1,'Login','Login'),(2,'Reset Questions','ResetQuestions'),(3,'Validate Answers','ValidateAnswers'),(4,'Reset Password','ResetPassword');
/*!40000 ALTER TABLE `system_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  `Abbr` varchar(15) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Name_UNIQUE` (`Name`),
  UNIQUE KEY `Abbr_UNIQUE` (`Abbr`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,'Login','login'),(2,'Reset Password','reset'),(3,'Dashboard','dashboard');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_questions`
--

DROP TABLE IF EXISTS `password_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_questions` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Abbr` varchar(8) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Name_UNIQUE` (`Name`),
  UNIQUE KEY `Abbr_UNIQUE` (`Abbr`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_questions`
--

LOCK TABLES `password_questions` WRITE;
/*!40000 ALTER TABLE `password_questions` DISABLE KEYS */;
INSERT INTO `password_questions` VALUES (1,'What is your childhood street?','street'),(2,'What is the name of your first pet?','pet'),(3,'What is your mother\'s maiden name?','mother');
/*!40000 ALTER TABLE `password_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `states` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'PK: Unique state ID',
  `Name` varchar(45) CHARACTER SET utf8 NOT NULL COMMENT 'State name with first letter capital',
  `Abbr` varchar(15) CHARACTER SET utf8 NOT NULL COMMENT 'Optional state abbreviation (US is 2 capital letters)',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `states`
--

LOCK TABLES `states` WRITE;
/*!40000 ALTER TABLE `states` DISABLE KEYS */;
INSERT INTO `states` VALUES (1,'Alabama','AL'),(2,'Alaska','AK'),(3,'Arizona','AZ'),(4,'Arkansas','AR'),(5,'California','CA'),(6,'Colorado','CO'),(7,'Connecticut','CT'),(8,'Delaware','DE'),(9,'District of Columbia','DC'),(10,'Florida','FL'),(11,'Georgia','GA'),(12,'Hawaii','HI'),(13,'Idaho','ID'),(14,'Illinois','IL'),(15,'Indiana','IN'),(16,'Iowa','IA'),(17,'Kansas','KS'),(18,'Kentucky','KY'),(19,'Louisiana','LA'),(20,'Maine','ME'),(21,'Maryland','MD'),(22,'Massachusetts','MA'),(23,'Michigan','MI'),(24,'Minnesota','MN'),(25,'Mississippi','MS'),(26,'Missouri','MO'),(27,'Montana','MT'),(28,'Nebraska','NE'),(29,'Nevada','NV'),(30,'New Hampshire','NH'),(31,'New Jersey','NJ'),(32,'New Mexico','NM'),(33,'New York','NY'),(34,'North Carolina','NC'),(35,'North Dakota','ND'),(36,'Ohio','OH'),(37,'Oklahoma','OK'),(38,'Oregon','OR'),(39,'Pennsylvania','PA'),(40,'Rhode Island','RI'),(41,'South Carolina','SC'),(42,'South Dakota','SD'),(43,'Tennessee','TN'),(44,'Texas','TX'),(45,'Utah','UT'),(46,'Vermont','VT'),(47,'Virginia','VA'),(48,'Washington','WA'),(49,'West Virginia','WV'),(50,'Wisconsin','WI'),(51,'Wyoming','WY');
/*!40000 ALTER TABLE `states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_communication`
--

DROP TABLE IF EXISTS `user_communication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_communication` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` int(11) NOT NULL,
  `CommunicationId` int(11) DEFAULT NULL,
  `Priority` int(11) DEFAULT '0',
  `CreatedBy` int(11) NOT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `UpdatedBy` int(11) DEFAULT NULL,
  `UpdatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  KEY `UserId_idx` (`UserId`),
  KEY `CommId_idx` (`CommunicationId`),
  KEY `CreatedId_idx` (`CreatedBy`),
  KEY `UpdatedId_idx` (`UpdatedBy`),
  CONSTRAINT `CommId` FOREIGN KEY (`CommunicationId`) REFERENCES `communcation_method` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `CreatedId` FOREIGN KEY (`CreatedBy`) REFERENCES `users` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `UpdatedId` FOREIGN KEY (`UpdatedBy`) REFERENCES `users` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_communication`
--

LOCK TABLES `user_communication` WRITE;
/*!40000 ALTER TABLE `user_communication` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_communication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_events`
--

DROP TABLE IF EXISTS `user_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_events` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` int(11) NOT NULL,
  `PageId` int(11) NOT NULL,
  `EventId` int(11) NOT NULL,
  `CreatedBy` int(11) NOT NULL,
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,,
  `UpdatedBy` int(11) DEFAULT NULL,
  `UpdatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  KEY `user_events_userId_idx` (`UserId`),
  KEY `user_events_eventId_idx` (`EventId`),
  KEY `user_events_createdBy_idx` (`CreatedBy`),
  KEY `user_events_updatedBy_idx` (`UpdatedBy`),
  KEY `user_events_pageId_idx` (`PageId`),
  CONSTRAINT `user_events_createdBy` FOREIGN KEY (`CreatedBy`) REFERENCES `users` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_events_updatedBy FOREIGN KEY (`UpdatedBy`) REFERENCES `users` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_events_eventId` FOREIGN KEY (`EventId`) REFERENCES `system_events` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_events_pageId` FOREIGN KEY (`PageId`) REFERENCES `pages` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_events_userId` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_events`
--

LOCK TABLES `user_events` WRITE;
/*!40000 ALTER TABLE `user_events` DISABLE KEYS */;
INSERT INTO `user_events` VALUES (1,1,1,3,1,'2016-07-04 07:19:45'),(2,1,1,1,1,'2016-07-04 07:38:56'),(3,1,1,1,1,'2016-07-04 07:39:53'),(4,1,1,1,1,'2016-07-04 07:44:27'),(5,1,2,2,1,'2016-07-04 07:46:34'),(6,1,2,2,1,'2016-07-04 07:47:47'),(7,1,2,2,1,'2016-07-04 07:49:58'),(8,1,2,2,1,'2016-07-04 07:50:10'),(9,1,2,2,1,'2016-07-04 07:51:40'),(10,1,2,2,1,'2016-07-04 07:51:48'),(11,1,1,1,1,'2016-07-04 21:37:46'),(12,1,2,3,1,'2016-07-12 11:41:05'),(13,1,2,4,1,'2016-07-12 11:41:43'),(14,1,2,3,1,'2016-07-12 11:45:04'),(15,1,2,4,1,'2016-07-12 11:45:25'),(16,1,2,3,1,'2016-07-12 11:48:53'),(17,1,2,4,1,'2016-07-12 11:50:05'),(18,1,2,3,1,'2016-07-12 11:51:16'),(19,1,2,4,1,'2016-07-12 11:51:49'),(20,1,2,3,1,'2016-07-12 11:52:24'),(21,1,2,4,1,'2016-07-12 11:52:32'),(22,1,1,1,1,'2016-07-13 10:40:09'),(23,1,1,1,1,'2016-07-13 10:40:09'),(24,1,1,1,1,'2016-08-08 16:19:29'),(25,1,1,1,1,'2016-08-08 16:19:29'),(26,1,1,1,1,'2016-08-08 16:24:21');
/*!40000 ALTER TABLE `user_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_questions`
--

DROP TABLE IF EXISTS `user_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_questions` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` int(11) NOT NULL,
  `QuestionId` int(11) NOT NULL,
  `Answer` varchar(255) NOT NULL,
  `SortOrder` int(11) DEFAULT NULL,
  `IsActive` bit(1) NOT NULL,
  `CreatedBy` int(11) NOT NULL,
  `CreatedOn` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdatedBy` int(11) NOT NULL,
  `UpdatedOn` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  KEY `UserId_idx` (`UserId`),
  KEY `QuestionId_idx` (`QuestionId`),
  KEY `CreatedBy_idx` (`CreatedBy`),
  KEY `UpdatedBy_idx` (`UpdatedBy`),
  CONSTRAINT `User_Questions_CreatedBy` FOREIGN KEY (`CreatedBy`) REFERENCES `users` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `User_Questions_QuestionId` FOREIGN KEY (`QuestionId`) REFERENCES `password_questions` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `User_Questions_UpdatedBy` FOREIGN KEY (`UpdatedBy`) REFERENCES `users` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `User_Questions_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_questions`
--

LOCK TABLES `user_questions` WRITE;
/*!40000 ALTER TABLE `user_questions` DISABLE KEYS */;
INSERT INTO `user_questions` VALUES (1,1,1,'Monroe',1,'',1,'2016-07-01 20:53:20',1,'2016-07-01 20:53:20'),(2,1,2,'Pepper',2,'\0',1,'2016-07-01 20:56:58',1,'2016-07-01 20:56:58'),(3,1,3,'Blewitt',3,'',1,'2016-07-01 20:56:58',1,'2016-07-01 20:56:58'),(4,5,2,'Sammy',2,'',1,'2016-07-01 20:56:58',1,'2016-07-01 20:56:58');
/*!40000 ALTER TABLE `user_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(45) NOT NULL,
  `MiddleName` varchar(45) DEFAULT '',
  `LastName` varchar(45) NOT NULL,
  `Address` varchar(45) DEFAULT '',
  `City` varchar(45) DEFAULT '',
  `StateId` int(11) DEFAULT '0',
  `IsActive` bit(1) DEFAULT b'1',
  `CreatedBy` int(11) NOT NULL,
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdatedBy` int(11) NOT NULL,
  `UpdatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  KEY `FK_UserId2_idx` (`UpdatedBy`),
  KEY `FK_UserId1_idx` (`CreatedBy`),
  CONSTRAINT `FK_UserId1` FOREIGN KEY (`CreatedBy`) REFERENCES `users` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_UserId2` FOREIGN KEY (`UpdatedBy`) REFERENCES `users` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Jon','Raymond','Wilson','3481 Park Avenue','Fairfield',7,'',1,'2016-06-16 15:45:06',1,'2016-06-16 15:45:06'),(5,'Jeff','','Bloch','100 Reef Road','Fairfield ',7,'',1,'2016-06-16 15:46:52',1,'2016-06-16 15:46:52');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'otsys'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-05 13:46:20

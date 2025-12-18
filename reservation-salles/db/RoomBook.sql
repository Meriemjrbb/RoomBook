-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: reservation_salles
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date_reservation` date NOT NULL,
  `heure_debut` time NOT NULL,
  `heure_fin` time NOT NULL,
  `status` enum('en attente','validée','annulée') NOT NULL DEFAULT 'en attente',
  `utilisateur_id` int NOT NULL,
  `salle_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_reservation` (`utilisateur_id`,`date_reservation`,`heure_debut`),
  UNIQUE KEY `unique_salle_reservation` (`salle_id`,`date_reservation`,`heure_debut`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`salle_id`) REFERENCES `salle` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (1,'2025-01-15','12:00:00','14:00:00','annulée',2,1),(2,'2025-01-16','17:00:00','19:00:00','en attente',3,2),(3,'2025-01-18','11:30:00','14:00:00','annulée',4,3),(4,'2025-01-20','10:00:00','12:00:00','annulée',5,5),(5,'2024-10-10','11:00:00','13:00:00','annulée',2,1),(6,'2024-10-18','16:00:00','18:00:00','annulée',3,4),(7,'2025-02-01','12:00:00','14:00:00','annulée',4,1),(8,'2025-02-03','15:00:00','17:00:00','annulée',5,2),(9,'2025-12-12','02:13:00','06:13:00','en attente',6,6),(10,'2025-12-12','02:04:00','04:04:00','en attente',6,1),(11,'2025-12-12','02:07:00','04:07:00','en attente',6,2),(12,'2025-12-19','09:49:00','13:47:00','en attente',2,6),(13,'2025-12-20','10:12:00','10:16:00','en attente',2,6),(14,'2025-12-17','10:13:00','10:33:00','validée',2,6),(15,'2025-12-10','10:30:00','15:06:00','en attente',2,6),(16,'2025-12-17','10:54:00','10:55:00','annulée',6,2),(17,'2025-12-19','12:22:00','13:22:00','validée',2,2);
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salle`
--

DROP TABLE IF EXISTS `salle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salle` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(150) NOT NULL,
  `capacite` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salle`
--

LOCK TABLES `salle` WRITE;
/*!40000 ALTER TABLE `salle` DISABLE KEYS */;
INSERT INTO `salle` VALUES (1,'Amphi A - Bloc Informatique',12),(2,'Amphi B - Bloc Génie Civil',150),(3,'Salle Réunion 101',25),(4,'Salle Réunion 102',20),(5,'Salle Polyvalente 201',80),(6,'Amphi 5',61);
/*!40000 ALTER TABLE `salle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utilisateur` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user') NOT NULL,
  `nomClub` varchar(100) DEFAULT NULL,
  `descriptionClub` text,
  `logoClub` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilisateur`
--

LOCK TABLES `utilisateur` WRITE;
/*!40000 ALTER TABLE `utilisateur` DISABLE KEYS */;
INSERT INTO `utilisateur` VALUES (1,'Admin','System','admin@univ.tn','admin123','admin',NULL,NULL,NULL),(2,'Ben Ali','Sarra','sarra.benali@isimg.tn','user123','user','Elite Council ISIMG Enourage','Elite Council ISIMG Entourage est un club universitaire dédié au développement personnel, au leadership et à l’esprit d’initiative. Il vise à accompagner les étudiants dans la construction de leurs compétences humaines, sociales et organisationnelles, afin de créer une communauté unie, ambitieuse et engagée dans la vie universitaire\r\n                \r\n                    \r\n                    \r\n                \r\n                \r\n                    \r\n                    ','elite.jpg'),(3,'Haddad','Marwen','marwen.haddad@isimg.tn','user123','user','IOT Club Isimg ','Le IOT Club ISIMG est un club universitaire dédié aux technologies de l’Internet des Objets. Il forme les étudiants aux systèmes embarqués, à la programmation de microcontrôleurs et à la création de projets connectés innovants.','iot.jpg'),(4,'Trabelsi','Ines','ines.trabelsi@isimg.tn','user123','user','VFXisimg ','Le VFX ISIMG est un club dédié aux effets visuels, au montage vidéo et à la création numérique. Il rassemble les étudiants passionnés par l’art digital, la production audiovisuelle et la créativité visuelle.','vfx.jpg'),(5,'Khaldi','Yassine','yassine.khaldi@isimg.tn','user123','user','CPC','Le CPC ISIMG (Competitive Programming Club) accompagne les étudiants passionnés par l’algorithmique, la programmation et les concours informatiques.\nÀ travers des entraînements, des challenges et des compétitions internes, le club développe la logique, la rapidité et la capacité à résoudre des problèmes complexes efficacement.','cpc.jpg'),(6,'Jribi','Meriem','meriem.jribi@isimg.tn','123456789','user','IEEE ISIMG Student Branch','Le IEEE ISIMG Student Branch est un club universitaire dédié aux passionnés de technologie et d’ingénierie. Il offre aux étudiants des opportunités de se former aux nouvelles technologies, de participer à des projets innovants et de développer leurs compétences en électronique, informatique et télécommunications.','ieee.jpg'),(7,'Jribi','Takwa','tak.jhfh@isimg.tn','pass123','user','TPL ISIMG','Le TPL (Tunisians Programming Lovers) est un club universitaire qui rassemble les étudiants passionnés de programmation et de développement logiciel. Il vise à renforcer les compétences en algorithmique, codage et résolution de problèmes à travers des ateliers, des challenges de programmation et des projets collaboratifs.','tpl.jpg');
/*!40000 ALTER TABLE `utilisateur` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-18 19:22:15

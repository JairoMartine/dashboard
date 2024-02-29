-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: newschema
-- ------------------------------------------------------
-- Server version	8.0.21

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
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `idcliente` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `apellido` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `correo_electronico` varchar(45) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `fecha_baja` date DEFAULT NULL,
  PRIMARY KEY (`idcliente`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='lista de clientes de la empresa';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'samuel','zazueta','lomas de la presa','6647756560','samuel.zazueta@gmail.com','2023-12-01','2024-04-04'),(2,'erick','zaueta','lomas de la presa','6642124410','erick.zazueta@gmail.com','2023-12-02','2024-05-01'),(3,'pepe','garcia','terrazas de la presa','6634232989','pepe123@gmail.com','2023-12-03','2024-02-03'),(4,'angelica','valles','villas del alamo','6634523593','vallez67@gmail.com','2023-12-04','2024-01-09'),(5,'dante','gonzales','ciudad de mexico','7324523188','dante892@gmail.com','2023-12-05','2024-04-12'),(6,'homero','santos','durango','2173233211','homer111@gmail.com','2024-01-08','2024-05-12'),(7,'javier','martinez','terrazas de mexico','1244787422','martinez9@gmail.com','2024-01-23','2024-02-17'),(8,'manuel','torres','el cruze','2132312432','manueltorres@gmail.com','2024-01-29',NULL),(9,'miguel','sanchez','tijuana city','4567322111','sanchez777@gmail.com','2024-02-01','2024-02-10'),(10,'cristofer','hoja','el camino rojo','3432576523','XXXsanchez@gmail.com','2024-02-08','2024-03-29');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingresos`
--

DROP TABLE IF EXISTS `ingresos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingresos` (
  `idingresos` int NOT NULL AUTO_INCREMENT,
  `cliente` int DEFAULT NULL,
  `negocio` int DEFAULT NULL,
  `monto` varchar(45) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`idingresos`),
  KEY `cliente_idx` (`cliente`),
  KEY `negocio_idx` (`negocio`),
  CONSTRAINT `cliente` FOREIGN KEY (`cliente`) REFERENCES `cliente` (`idcliente`),
  CONSTRAINT `negocio` FOREIGN KEY (`negocio`) REFERENCES `negocios` (`idnegocios`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingresos`
--

LOCK TABLES `ingresos` WRITE;
/*!40000 ALTER TABLE `ingresos` DISABLE KEYS */;
INSERT INTO `ingresos` VALUES (1,3,10001,'1500','2023-12-01'),(2,2,10001,'1000','2023-12-02'),(3,1,10003,'1050','2023-12-03'),(4,1,10003,'1500','2023-12-04'),(5,3,10002,'2000','2023-12-05'),(6,4,10004,'1000','2023-12-06'),(7,2,10004,'2500','2023-12-07'),(8,4,10001,'3000','2023-12-08'),(9,3,10002,'3500','2023-12-10');
/*!40000 ALTER TABLE `ingresos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metas`
--

DROP TABLE IF EXISTS `metas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text,
  `fecha` date DEFAULT NULL,
  `finalizado` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metas`
--

LOCK TABLES `metas` WRITE;
/*!40000 ALTER TABLE `metas` DISABLE KEYS */;
INSERT INTO `metas` VALUES (1,'Meta 1','Descripción de la Meta 1','2023-01-01',1),(2,'Meta 2','Descripción de la Meta 2','2023-02-15',0),(3,'Meta 3','Descripción de la Meta 3','2023-03-30',0),(4,'Meta 4','Descripción de la Meta 4','2023-04-10',1),(5,'Meta 5','Descripción de la Meta 5','2023-05-22',0),(6,'Meta 6','Descripción de la Meta 6','2023-06-05',1),(7,'Meta 7','Descripción de la Meta 7','2023-07-12',0),(8,'Meta 8','Descripción de la Meta 8','2023-08-18',0),(9,'Meta 9','Descripción de la Meta 9','2023-09-25',1),(10,'Meta 10','Descripción de la Meta 10','2023-10-05',0),(11,'meta 11','Descripcion de la Meta 11','2023-12-01',1);
/*!40000 ALTER TABLE `metas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `negocios`
--

DROP TABLE IF EXISTS `negocios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `negocios` (
  `idnegocios` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `Email` varchar(45) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  PRIMARY KEY (`idnegocios`)
) ENGINE=InnoDB AUTO_INCREMENT=10005 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='lista de los negocios fisicos de la empresa';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `negocios`
--

LOCK TABLES `negocios` WRITE;
/*!40000 ALTER TABLE `negocios` DISABLE KEYS */;
INSERT INTO `negocios` VALUES (10001,'all foods','tijuana','3123231211','allfood@gmail.com','2023-12-01'),(10002,'los ramos','tijuana','6623123422','ramos@gmail.com','2023-12-04'),(10003,'la miranda','mexicali','6662134523','mirada@gmai.com','2023-12-05'),(10004,'limonsin','tijuana','7324423334','limon@gmail.com','2023-12-08');
/*!40000 ALTER TABLE `negocios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `puntos_equlibrio`
--

DROP TABLE IF EXISTS `puntos_equlibrio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `puntos_equlibrio` (
  `idpuntos_equlibrio` int NOT NULL,
  `ingreso` int DEFAULT NULL,
  `monto` int DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`idpuntos_equlibrio`),
  KEY `ingreso_idx` (`ingreso`),
  CONSTRAINT `ingreso` FOREIGN KEY (`ingreso`) REFERENCES `ingresos` (`idingresos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `puntos_equlibrio`
--

LOCK TABLES `puntos_equlibrio` WRITE;
/*!40000 ALTER TABLE `puntos_equlibrio` DISABLE KEYS */;
INSERT INTO `puntos_equlibrio` VALUES (1,4,1500,'2023-12-01'),(2,2,1500,'2023-12-05'),(3,1,2500,'2023-12-10'),(4,2,500,'2023-12-03'),(5,8,1000,'2023-12-08');
/*!40000 ALTER TABLE `puntos_equlibrio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socio`
--

DROP TABLE IF EXISTS `socio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socio` (
  `idsocio` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `Email` varchar(45) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  PRIMARY KEY (`idsocio`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socio`
--

LOCK TABLES `socio` WRITE;
/*!40000 ALTER TABLE `socio` DISABLE KEYS */;
INSERT INTO `socio` VALUES (1,'Juan Perez','Calle 3','4194567890','juan@example.com','2023-12-01'),(2,'Ana García','Avenida abasolo 4','4196543210','ana@example.com','2023-12-04'),(3,'Pedro Rodriguez','Calle juarez 2','4191234567','pedro@example.com','2023-12-07');
/*!40000 ALTER TABLE `socio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ubicacion`
--

DROP TABLE IF EXISTS `ubicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ubicacion` (
  `idubicacion` int NOT NULL AUTO_INCREMENT,
  `negocio` int DEFAULT NULL,
  `latitud` decimal(10,6) NOT NULL,
  `longitud` decimal(10,6) NOT NULL,
  PRIMARY KEY (`idubicacion`),
  KEY `negocio_idx` (`negocio`),
  CONSTRAINT `negocios` FOREIGN KEY (`negocio`) REFERENCES `negocios` (`idnegocios`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ubicacion`
--

LOCK TABLES `ubicacion` WRITE;
/*!40000 ALTER TABLE `ubicacion` DISABLE KEYS */;
INSERT INTO `ubicacion` VALUES (1,10001,19.432600,-99.133200),(2,10002,20.659700,-103.349600),(3,10003,25.438000,-100.973700),(4,10004,32.502700,-117.003700);
/*!40000 ALTER TABLE `ubicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilidades`
--

DROP TABLE IF EXISTS `utilidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utilidades` (
  `idutilidades` int NOT NULL,
  `punto_equlibrio` int DEFAULT NULL,
  `monto` int DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`idutilidades`),
  KEY `eqilibrio_idx` (`punto_equlibrio`),
  CONSTRAINT `eqilibrio` FOREIGN KEY (`punto_equlibrio`) REFERENCES `puntos_equlibrio` (`idpuntos_equlibrio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilidades`
--

LOCK TABLES `utilidades` WRITE;
/*!40000 ALTER TABLE `utilidades` DISABLE KEYS */;
INSERT INTO `utilidades` VALUES (1,3,1500,'2023-01-01'),(2,1,2000,'2023-12-05'),(3,2,1700,'2023-12-08');
/*!40000 ALTER TABLE `utilidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas_por_servicio`
--

DROP TABLE IF EXISTS `ventas_por_servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas_por_servicio` (
  `ID_Ingreso` int NOT NULL,
  `Nombre_Servicio` varchar(255) DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  `Ingreso` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas_por_servicio`
--

LOCK TABLES `ventas_por_servicio` WRITE;
/*!40000 ALTER TABLE `ventas_por_servicio` DISABLE KEYS */;
INSERT INTO `ventas_por_servicio` VALUES (1,'Redes sociales','2024-01-16',1000.00),(2,'Dashboard','2024-01-17',3000.00),(3,'Publicidad','2024-01-18',1500.00),(4,'Marketing ','2024-01-19',2050.00),(5,'Página Web','2024-01-20',5600.00),(6,'Campaña','2024-01-21',2500.00),(7,'Estrategias','2024-01-22',2000.00),(8,'Anuncios','2024-01-23',1500.00);
/*!40000 ALTER TABLE `ventas_por_servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'newschema'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-19 10:39:55

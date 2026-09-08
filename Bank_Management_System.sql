-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: Bank_Management_System
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `Account_No` varchar(20) NOT NULL,
  `Account_Type` varchar(30) NOT NULL,
  `Open_Date` date NOT NULL,
  `Balance` decimal(12,2) DEFAULT '0.00',
  `Status` varchar(20) DEFAULT 'ACTIVE',
  `Customer_ID` int NOT NULL,
  `Branch_ID` int NOT NULL,
  PRIMARY KEY (`Account_No`),
  KEY `Customer_ID` (`Customer_ID`),
  KEY `Branch_ID` (`Branch_ID`),
  CONSTRAINT `account_ibfk_1` FOREIGN KEY (`Customer_ID`) REFERENCES `customer` (`Customer_ID`),
  CONSTRAINT `account_ibfk_2` FOREIGN KEY (`Branch_ID`) REFERENCES `branch` (`Branch_ID`),
  CONSTRAINT `account_chk_1` CHECK ((`Balance` >= 0)),
  CONSTRAINT `account_chk_2` CHECK ((`Status` in (_cp850'ACTIVE',_cp850'INACTIVE',_cp850'CLOSED')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES ('ACC1001','Savings','2025-01-10',48000.00,'ACTIVE',1,101),('ACC1002','Current','2025-02-15',105000.00,'ACTIVE',2,102),('ACC1003','Savings','2025-03-20',75000.00,'ACTIVE',3,103),('ACC1004','Savings','2025-04-05',25000.00,'ACTIVE',1,101);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branch` (
  `Branch_ID` int NOT NULL,
  `Branch_Name` varchar(100) NOT NULL,
  `Address` varchar(200) DEFAULT NULL,
  `City` varchar(50) NOT NULL,
  `IFSC_Code` varchar(20) NOT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Branch_ID`),
  UNIQUE KEY `IFSC_Code` (`IFSC_Code`),
  UNIQUE KEY `Phone` (`Phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
INSERT INTO `branch` VALUES (101,'Main Branch','Abids Road','Hyderabad','BANK000101','9000000001'),(102,'City Branch','MG Road','Warangal','BANK000102','9000000002'),(103,'Central Branch','Benz Circle','Vijayawada','BANK000103','9000000003');
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cheque_book`
--

DROP TABLE IF EXISTS `cheque_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cheque_book` (
  `Account_No` varchar(20) NOT NULL,
  `Book_No` int NOT NULL,
  `Issue_Date` date NOT NULL,
  `No_Of_Leaves` int DEFAULT '25',
  `Status` varchar(20) DEFAULT 'ACTIVE',
  PRIMARY KEY (`Account_No`,`Book_No`),
  CONSTRAINT `cheque_book_ibfk_1` FOREIGN KEY (`Account_No`) REFERENCES `account` (`Account_No`),
  CONSTRAINT `cheque_book_chk_1` CHECK ((`No_Of_Leaves` > 0)),
  CONSTRAINT `cheque_book_chk_2` CHECK ((`Status` in (_cp850'ACTIVE',_cp850'USED',_cp850'CANCELLED')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cheque_book`
--

LOCK TABLES `cheque_book` WRITE;
/*!40000 ALTER TABLE `cheque_book` DISABLE KEYS */;
INSERT INTO `cheque_book` VALUES ('ACC1001',1,'2026-01-10',25,'ACTIVE'),('ACC1001',2,'2026-06-10',25,'ACTIVE'),('ACC1002',1,'2026-02-20',50,'ACTIVE');
/*!40000 ALTER TABLE `cheque_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `Customer_ID` int NOT NULL,
  `Name` varchar(100) NOT NULL,
  `DOB` date NOT NULL,
  `Phone` varchar(15) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Address` varchar(200) DEFAULT NULL,
  `Age` int DEFAULT NULL,
  `Aadhaar_No` varchar(12) NOT NULL,
  `PAN_No` varchar(10) NOT NULL,
  PRIMARY KEY (`Customer_ID`),
  UNIQUE KEY `Phone` (`Phone`),
  UNIQUE KEY `Aadhaar_No` (`Aadhaar_No`),
  UNIQUE KEY `PAN_No` (`PAN_No`),
  UNIQUE KEY `Email` (`Email`),
  CONSTRAINT `chk_customer_age` CHECK ((`Age` >= 18)),
  CONSTRAINT `customer_chk_1` CHECK ((`Age` >= 18))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Rahul Sharma','1995-05-10','9876543210','rahul@gmail.com','Hyderabad',31,'123456789012','ABCDE1234F'),(2,'Priya Reddy','1998-08-15','9876543211','priya@gmail.com','Warangal',28,'123456789013','ABCDE1235F'),(3,'Arjun Kumar','1992-03-20','9876543212','arjun@gmail.com','Vijayawada',34,'123456789014','ABCDE1236F');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `customer_account_view`
--

DROP TABLE IF EXISTS `customer_account_view`;
/*!50001 DROP VIEW IF EXISTS `customer_account_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `customer_account_view` AS SELECT 
 1 AS `Customer_ID`,
 1 AS `Name`,
 1 AS `Account_No`,
 1 AS `Account_Type`,
 1 AS `Balance`,
 1 AS `Status`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `loan`
--

DROP TABLE IF EXISTS `loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loan` (
  `Loan_ID` int NOT NULL,
  `Account_No` varchar(20) NOT NULL,
  `Loan_Type` varchar(50) NOT NULL,
  `Amount` decimal(12,2) NOT NULL,
  `Interest_Rate` decimal(5,2) DEFAULT NULL,
  `Start_Date` date NOT NULL,
  `End_Date` date DEFAULT NULL,
  `Status` varchar(20) DEFAULT 'ACTIVE',
  PRIMARY KEY (`Loan_ID`),
  KEY `Account_No` (`Account_No`),
  CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`Account_No`) REFERENCES `account` (`Account_No`),
  CONSTRAINT `loan_chk_1` CHECK ((`Amount` > 0)),
  CONSTRAINT `loan_chk_2` CHECK ((`Interest_Rate` >= 0)),
  CONSTRAINT `loan_chk_3` CHECK ((`Status` in (_cp850'ACTIVE',_cp850'CLOSED',_cp850'PENDING'))),
  CONSTRAINT `loan_chk_4` CHECK (((`End_Date` is null) or (`End_Date` >= `Start_Date`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan`
--

LOCK TABLES `loan` WRITE;
/*!40000 ALTER TABLE `loan` DISABLE KEYS */;
INSERT INTO `loan` VALUES (501,'ACC1001','Home Loan',5000000.00,7.50,'2026-01-01','2036-01-01','ACTIVE'),(502,'ACC1002','Car Loan',1000000.00,8.50,'2026-02-01','2031-02-01','ACTIVE'),(503,'ACC1003','Personal Loan',500000.00,10.50,'2026-03-01','2029-03-01','ACTIVE');
/*!40000 ALTER TABLE `loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `loan_details_view`
--

DROP TABLE IF EXISTS `loan_details_view`;
/*!50001 DROP VIEW IF EXISTS `loan_details_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `loan_details_view` AS SELECT 
 1 AS `Name`,
 1 AS `Account_No`,
 1 AS `Loan_ID`,
 1 AS `Loan_Type`,
 1 AS `Amount`,
 1 AS `Interest_Rate`,
 1 AS `Status`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `loan_installment`
--

DROP TABLE IF EXISTS `loan_installment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loan_installment` (
  `Loan_ID` int NOT NULL,
  `Installment_No` int NOT NULL,
  `Due_Date` date NOT NULL,
  `Installment_Amount` decimal(12,2) NOT NULL,
  `Paid_Amount` decimal(12,2) DEFAULT '0.00',
  `Payment_Status` varchar(20) DEFAULT 'PENDING',
  PRIMARY KEY (`Loan_ID`,`Installment_No`),
  CONSTRAINT `loan_installment_ibfk_1` FOREIGN KEY (`Loan_ID`) REFERENCES `loan` (`Loan_ID`),
  CONSTRAINT `loan_installment_chk_1` CHECK ((`Installment_Amount` > 0)),
  CONSTRAINT `loan_installment_chk_2` CHECK ((`Paid_Amount` >= 0)),
  CONSTRAINT `loan_installment_chk_3` CHECK ((`Payment_Status` in (_cp850'PENDING',_cp850'PAID',_cp850'PARTIAL')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan_installment`
--

LOCK TABLES `loan_installment` WRITE;
/*!40000 ALTER TABLE `loan_installment` DISABLE KEYS */;
INSERT INTO `loan_installment` VALUES (501,1,'2026-02-01',45000.00,45000.00,'PAID'),(501,2,'2026-03-01',45000.00,45000.00,'PAID'),(501,3,'2026-04-01',45000.00,20000.00,'PARTIAL'),(502,1,'2026-03-01',25000.00,25000.00,'PAID'),(502,2,'2026-04-01',25000.00,0.00,'PENDING'),(503,1,'2026-04-01',18000.00,0.00,'PENDING');
/*!40000 ALTER TABLE `loan_installment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `Transaction_ID` int NOT NULL,
  `Account_No` varchar(20) NOT NULL,
  `Transaction_Date` datetime DEFAULT CURRENT_TIMESTAMP,
  `Mode` varchar(30) NOT NULL,
  `Transaction_Type` varchar(20) NOT NULL,
  `Amount` decimal(12,2) NOT NULL,
  `Description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`Transaction_ID`),
  KEY `Account_No` (`Account_No`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`Account_No`) REFERENCES `account` (`Account_No`),
  CONSTRAINT `transaction_chk_1` CHECK ((`Transaction_Type` in (_cp850'DEPOSIT',_cp850'WITHDRAW'))),
  CONSTRAINT `transaction_chk_2` CHECK ((`Amount` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1,'ACC1001','2026-09-01 10:00:00','UPI','DEPOSIT',10000.00,'Salary'),(2,'ACC1001','2026-09-02 11:30:00','ATM','WITHDRAW',5000.00,'Cash withdrawal'),(3,'ACC1002','2026-09-03 12:00:00','NEFT','DEPOSIT',25000.00,'Business payment'),(4,'ACC1003','2026-09-04 14:00:00','UPI','WITHDRAW',3000.00,'Shopping'),(10,'ACC1001','2026-09-08 19:50:01','UPI','DEPOSIT',5000.00,'Cash deposit');
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Update_Account_Balance` AFTER INSERT ON `transaction` FOR EACH ROW BEGIN

    IF NEW.Transaction_Type = 'DEPOSIT' THEN

        UPDATE ACCOUNT
        SET Balance = Balance + NEW.Amount
        WHERE Account_No = NEW.Account_No;

    ELSEIF NEW.Transaction_Type = 'WITHDRAW' THEN

        UPDATE ACCOUNT
        SET Balance = Balance - NEW.Amount
        WHERE Account_No = NEW.Account_No;

    END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `customer_account_view`
--

/*!50001 DROP VIEW IF EXISTS `customer_account_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `customer_account_view` AS select `c`.`Customer_ID` AS `Customer_ID`,`c`.`Name` AS `Name`,`a`.`Account_No` AS `Account_No`,`a`.`Account_Type` AS `Account_Type`,`a`.`Balance` AS `Balance`,`a`.`Status` AS `Status` from (`customer` `c` join `account` `a` on((`c`.`Customer_ID` = `a`.`Customer_ID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `loan_details_view`
--

/*!50001 DROP VIEW IF EXISTS `loan_details_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `loan_details_view` AS select `c`.`Name` AS `Name`,`a`.`Account_No` AS `Account_No`,`l`.`Loan_ID` AS `Loan_ID`,`l`.`Loan_Type` AS `Loan_Type`,`l`.`Amount` AS `Amount`,`l`.`Interest_Rate` AS `Interest_Rate`,`l`.`Status` AS `Status` from ((`customer` `c` join `account` `a` on((`c`.`Customer_ID` = `a`.`Customer_ID`))) join `loan` `l` on((`a`.`Account_No` = `l`.`Account_No`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-08 20:02:17

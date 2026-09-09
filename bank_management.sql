1. Database
CREATE DATABASE bank_management_system;
USE bank_management_system;
SHOW DATABASES;
SHOW TABLES;
2. DDL and Constraints
CREATE TABLE CUSTOMER (
 Customer_ID INT PRIMARY KEY, Name VARCHAR(100) NOT NULL,
 DOB DATE NOT NULL, Phone VARCHAR(15) NOT NULL UNIQUE,
 Email VARCHAR(100) UNIQUE, Address VARCHAR(200),
 Age INT CHECK (Age >= 18), Aadhaar_No VARCHAR(12) UNIQUE NOT NULL,
 PAN_No VARCHAR(10) UNIQUE NOT NULL
);
CREATE TABLE BRANCH (
 Branch_ID INT PRIMARY KEY, Branch_Name VARCHAR(100) NOT NULL,
 Address VARCHAR(200), City VARCHAR(50) NOT NULL,
 IFSC_Code VARCHAR(20) UNIQUE NOT NULL, Phone VARCHAR(15) UNIQUE
);
CREATE TABLE ACCOUNT (
 Account_No VARCHAR(20) PRIMARY KEY, Account_Type VARCHAR(30) NOT NULL,
 Open_Date DATE NOT NULL, Balance DECIMAL(12,2) DEFAULT 0 CHECK (Balance >= 0),
 Status VARCHAR(20) DEFAULT 'ACTIVE' CHECK (Status IN ('ACTIVE','INACTIVE','CLOSED')),
 Customer_ID INT NOT NULL, Branch_ID INT NOT NULL,
 FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID),
 FOREIGN KEY (Branch_ID) REFERENCES BRANCH(Branch_ID)
);
CREATE TABLE `TRANSACTION` (
 Transaction_ID INT PRIMARY KEY, Account_No VARCHAR(20) NOT NULL,
 Transaction_Date DATETIME DEFAULT CURRENT_TIMESTAMP, Mode VARCHAR(30) NOT NULL,
 Transaction_Type VARCHAR(20) NOT NULL CHECK (Transaction_Type IN ('DEPOSIT','WITHDRAW')),
 Amount DECIMAL(12,2) NOT NULL CHECK (Amount > 0),
 Description VARCHAR(200), FOREIGN KEY (Account_No) REFERENCES ACCOUNT(Account_No)
);
CREATE TABLE LOAN (
 Loan_ID INT PRIMARY KEY, Account_No VARCHAR(20) NOT NULL,
 Loan_Type VARCHAR(50) NOT NULL, Amount DECIMAL(12,2) NOT NULL CHECK (Amount > 0),
 Interest_Rate DECIMAL(5,2) CHECK (Interest_Rate >= 0),
 Start_Date DATE NOT NULL, End_Date DATE,
 Status VARCHAR(20) DEFAULT 'ACTIVE' CHECK (Status IN ('ACTIVE','CLOSED','PENDING')),
 FOREIGN KEY (Account_No) REFERENCES ACCOUNT(Account_No),
 CHECK (End_Date IS NULL OR End_Date >= Start_Date)
);
CREATE TABLE CHEQUE_BOOK (
 Account_No VARCHAR(20), Book_No INT, Issue_Date DATE NOT NULL,
 No_Of_Leaves INT DEFAULT 25 CHECK (No_Of_Leaves > 0),
 Status VARCHAR(20) DEFAULT 'ACTIVE' CHECK (Status IN ('ACTIVE','USED','CANCELLED')),
 PRIMARY KEY (Account_No, Book_No), FOREIGN KEY (Account_No) REFERENCES ACCOUNT(Account_No)
);
CREATE TABLE LOAN_INSTALLMENT (
 Loan_ID INT, Installment_No INT, Due_Date DATE NOT NULL,
 Installment_Amount DECIMAL(12,2) NOT NULL CHECK (Installment_Amount > 0),
 Paid_Amount DECIMAL(12,2) DEFAULT 0 CHECK (Paid_Amount >= 0),
 Payment_Status VARCHAR(20) DEFAULT 'PENDING'
 CHECK (Payment_Status IN ('PENDING','PAID','PARTIAL')),
 PRIMARY KEY (Loan_ID, Installment_No), FOREIGN KEY (Loan_ID) REFERENCES LOAN(Loan_ID)
);
3. Structure and Data
DESC CUSTOMER;
DESC BRANCH;
DESC ACCOUNT;
DESC `TRANSACTION`;
DESC LOAN;
DESC CHEQUE_BOOK;
DESC LOAN_INSTALLMENT;
SELECT * FROM CUSTOMER;
SELECT * FROM BRANCH;
SELECT * FROM ACCOUNT;
SELECT * FROM `TRANSACTION`;
SELECT * FROM LOAN;
SELECT * FROM CHEQUE_BOOK;
SELECT * FROM LOAN_INSTALLMENT;
4. Derived Age
SELECT Customer_ID, Name, DOB, TIMESTAMPDIFF(YEAR, DOB, CURDATE()) AS Age FROM CUSTOMER;
5. CRUD
INSERT INTO CUSTOMER VALUES (4,'Test User','2000-01-01','9876543222','test@gmail.com','Hyderabad',26,'123456789015','ABCDE1237F');
SELECT * FROM CUSTOMER;
UPDATE CUSTOMER SET Phone = '9876543299' WHERE Customer_ID = 1;
DELETE FROM CUSTOMER WHERE Customer_ID = 4;
6. Joins
SELECT c.Name, a.Account_No, a.Account_Type, a.Balance
FROM CUSTOMER c JOIN ACCOUNT a ON c.Customer_ID = a.Customer_ID;
SELECT a.Account_No, b.Branch_Name, b.City
FROM ACCOUNT a JOIN BRANCH b ON a.Branch_ID = b.Branch_ID;
SELECT c.Name, a.Account_No, l.Loan_ID, l.Loan_Type, l.Amount
FROM CUSTOMER c JOIN ACCOUNT a ON c.Customer_ID=a.Customer_ID
JOIN LOAN l ON a.Account_No=l.Account_No;
SELECT a.Account_No, t.Transaction_ID, t.Transaction_Type, t.Amount
FROM ACCOUNT a LEFT JOIN `TRANSACTION` t ON a.Account_No=t.Account_No;
SELECT a.Account_No, b.Branch_Name FROM ACCOUNT a CROSS JOIN BRANCH b;
7. Subqueries
SELECT * FROM ACCOUNT WHERE Balance > (SELECT AVG(Balance) FROM ACCOUNT);
SELECT Name FROM CUSTOMER WHERE Customer_ID IN (SELECT Customer_ID FROM ACCOUNT);
SELECT * FROM LOAN WHERE Amount = (SELECT MAX(Amount) FROM LOAN);
8. Views
CREATE VIEW Customer_Account_View AS
SELECT c.Customer_ID,c.Name,a.Account_No,a.Account_Type,a.Balance,a.Status
FROM CUSTOMER c JOIN ACCOUNT a ON c.Customer_ID=a.Customer_ID;
SELECT * FROM Customer_Account_View;
CREATE VIEW Loan_Details_View AS
SELECT c.Name,a.Account_No,l.Loan_ID,l.Loan_Type,l.Amount,l.Interest_Rate,l.Status
FROM CUSTOMER c JOIN ACCOUNT a ON c.Customer_ID=a.Customer_ID
JOIN LOAN l ON a.Account_No=l.Account_No;
SELECT * FROM Loan_Details_View;
SHOW FULL TABLES WHERE TABLE_TYPE='VIEW';
9. Stored Procedures
DELIMITER //
CREATE PROCEDURE GetAllCustomers()
BEGIN SELECT * FROM CUSTOMER; END //
DELIMITER ;
CALL GetAllCustomers();
DELIMITER //
CREATE PROCEDURE GetAccountDetails(IN acc_no VARCHAR(20))
BEGIN SELECT * FROM ACCOUNT WHERE Account_No=acc_no; END //
DELIMITER ;
CALL GetAccountDetails('ACC1001');
DELIMITER //
CREATE PROCEDURE DepositMoney(IN acc_no VARCHAR(20), IN amount DECIMAL(12,2))
BEGIN
 INSERT INTO `TRANSACTION`(Account_No,Mode,Transaction_Type,Amount,Description)
 VALUES(acc_no,'UPI','DEPOSIT',amount,'Deposit through procedure');
END //
DELIMITER ;
DELIMITER //
CREATE PROCEDURE WithdrawMoney(IN acc_no VARCHAR(20), IN amount DECIMAL(12,2))
BEGIN
 INSERT INTO `TRANSACTION`(Account_No,Mode,Transaction_Type,Amount,Description)
 VALUES(acc_no,'ATM','WITHDRAW',amount,'Withdrawal through procedure');
END //
DELIMITER ;
SHOW PROCEDURE STATUS WHERE Db='bank_management_system';
10. Trigger
DELIMITER //
CREATE TRIGGER Update_Account_Balance
AFTER INSERT ON `TRANSACTION`
FOR EACH ROW
BEGIN
 IF NEW.Transaction_Type='DEPOSIT' THEN
  UPDATE ACCOUNT SET Balance=Balance+NEW.Amount WHERE Account_No=NEW.Account_No;
 ELSEIF NEW.Transaction_Type='WITHDRAW' THEN
  UPDATE ACCOUNT SET Balance=Balance-NEW.Amount WHERE Account_No=NEW.Account_No;
 END IF;
END //
DELIMITER ;
SHOW TRIGGERS;
SHOW CREATE TRIGGER Update_Account_Balance;
INSERT INTO `TRANSACTION`
(Transaction_ID,Account_No,Mode,Transaction_Type,Amount,Description)
VALUES(11,'ACC1001','UPI','DEPOSIT',5000,'Test deposit');
SELECT Account_No,Balance FROM ACCOUNT WHERE Account_No='ACC1001';
11. Transactions
START TRANSACTION;
UPDATE ACCOUNT SET Balance=Balance-1000 WHERE Account_No='ACC1001';
UPDATE ACCOUNT SET Balance=Balance+1000 WHERE Account_No='ACC1002';
COMMIT;
ROLLBACK;
12. Useful Demo Commands
SHOW TABLES;
SHOW CREATE TABLE ACCOUNT;
SHOW CREATE TABLE `TRANSACTION`;
SHOW FULL TABLES WHERE TABLE_TYPE='VIEW';
SHOW TRIGGERS;
SHOW PROCEDURE STATUS WHERE Db='bank_management_system';

Bank Management System

Project Overview

The Bank Management System is a database project developed using MySQL to manage and organize banking operations efficiently. It stores and manages information related to customers, accounts, transactions, loans, and branches while maintaining relationships and data integrity.

Features

* Customer and account management
* Bank branch management
* Transaction management
* Loan management
* Primary and foreign key relationships
* Data validation using constraints
* SQL queries for retrieving banking information
* Joins and subqueries for data analysis
* Views for simplified data access
* Stored procedures for reusable operations
* Triggers for automatic database actions
* CRUD operations

Tech Stack

* Database:MySQL 8.0
* Language:SQL
* Tools: MySQL Command Line Client
* Database Concepts:DDL, DML, DQL, Joins, Subqueries, Views, Stored Procedures, and Triggers

Setup and Run

1. Install MySQL 8.0 or later.
2. Open MySQL Command Line Client.
3. Create a database:

sql
CREATE DATABASE bank_management;
USE bank_management;


4. Execute the `bank_management.sql` file.
5. Verify the tables using:

sql
SHOW TABLES;


6. Execute the required queries, procedures, and other database operations.

Environment Variables

This project is a standalone MySQL database project and does not require environment variables, API keys, or external credentials.

Database Notes

The database contains the following major entities:

* Customers
* Accounts
* Transactions
* Loans
* Branches

The database uses primary keys, foreign keys, UNIQUE, NOT NULL, CHECK, and DEFAULT constraints to maintain data integrity.

API Notes

No external API is used in this project. The system is implemented as a MySQL database project using SQL commands.

Team Member Contributions

Sruthii

* Designed the database structure.
* Created the ER model.
* Created tables using DDL commands.
* Implemented database constraints.
* Inserted sample data.
* Developed SQL queries using CRUD operations, joins, and subqueries.
* Created views, stored procedures, and triggers.
* Tested and validated the database operations.

Project Outcome

The project demonstrates how a relational database can be designed and implemented to manage core banking operations while maintaining data consistency, relationships, and efficient data retrieval.

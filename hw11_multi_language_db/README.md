# Multi-Language Database Access (JDBC + PHP)

This project demonstrates database interaction across multiple languages including Java (JDBC) and PHP (PDO).

## Programs

### ProgramA — Stored Procedure Call
Calls a stored procedure that returns a customer order summary including:
- total orders
- total revenue
- most recent order

### ProgramB — Java Prepared Statement
Filters products by category and sorts by price (ASC/DESC).

### ProgramC — PHP PDO Version
Implements the same behavior as ProgramB using PHP.

## Concepts Demonstrated

- JDBC CallableStatement
- JDBC PreparedStatement
- PHP PDO prepared queries
- Stored procedures
- Parameter binding
- SQL injection prevention
- Multi-language DB clients

## Files

- schema_and_procedures.sql
- ProgramA.java
- ProgramB.java
- ProgramC.php

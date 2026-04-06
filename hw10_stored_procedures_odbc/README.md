# Stored Procedures and ODBC Database Programming

This project demonstrates stored procedures and client-side database programming using ODBC in C.

## Topics Covered

### Stored Procedures
- Aggregation-based stored procedure
- Parameterized procedure calls
- Update procedures
- Server-side business logic

### Performance Optimization
- Index on Staff(role) for faster procedure execution

### ODBC Programming (C)
- ODBC environment initialization
- Database connection handling
- Query execution
- Parameter binding
- Row-by-row result fetching
- Proper cleanup of handles

## Files

- schema_and_procedures.sql — database schema and stored procedures
- query_odbc.c — executes SELECT query using ODBC
- stored_proc_odbc.c — calls stored procedure with parameter binding

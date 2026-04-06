#include <stdio.h>
#include <string.h>
#include <sql.h>
#include <sqlext.h>

// Print ODBC errors
void printSQLError(SQLHANDLE handle, SQLSMALLINT type) {
    SQLCHAR sqlState[1024];
    SQLCHAR message[1024];

    if (SQLGetDiagRec(type, handle, 1, sqlState, NULL,
                      message, 1024, NULL) == SQL_SUCCESS) {
        printf("ODBC Error: %s (%s)\n", message, sqlState);
    }
}

int main() {
    SQLHENV hEnv;
    SQLHDBC hDbc;
    SQLHSTMT hStmt;
    SQLRETURN ret;

    // Allocate environment handle
    SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &hEnv);
    SQLSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION, (void*)SQL_OV_ODBC3, 0);

    // Allocate connection handle
    SQLAllocHandle(SQL_HANDLE_DBC, hEnv, &hDbc);

    // CONNECTION STRING
    SQLCHAR connStr[] =
    "DRIVER={MariaDB Unicode};"
    "SERVER=35.24.200.118;"
    "PORT=3306;"
    "DATABASE=HW10;"
    "UID=root;"
    "PWD=(I am hiding my password);"
    "TCPIP=1;"
    "NO_PROMPT=1;";

    printf("Connecting to MySQL...\n");

    ret = SQLDriverConnect(
        hDbc,
        NULL,
        connStr,
        SQL_NTS,
        NULL,
        0,
        NULL,
        SQL_DRIVER_COMPLETE
    );

    if (!SQL_SUCCEEDED(ret)) {
        printf("Connection failed!\n");
        printSQLError(hDbc, SQL_HANDLE_DBC);
        return 1;
    }

    printf("Connected successfully!\n\n");

    // Allocate statement handle
    SQLAllocHandle(SQL_HANDLE_STMT, hDbc, &hStmt);

    // Query required
    const char *query =
        "SELECT name, city FROM Customers WHERE state = 'MI';";

    printf("Executing query:\n%s\n\n", query);

    ret = SQLExecDirect(hStmt, (SQLCHAR*)query, SQL_NTS);

    if (!SQL_SUCCEEDED(ret)) {
        printf("Query failed.\n");
        printSQLError(hStmt, SQL_HANDLE_STMT);
        return 1;
    }

    // Variables to store results
    char name[100], city[100];

    // Bind columns
    SQLBindCol(hStmt, 1, SQL_C_CHAR, name, sizeof(name), NULL);
    SQLBindCol(hStmt, 2, SQL_C_CHAR, city, sizeof(city), NULL);

    // Print table header
    printf("Results:\n");
    printf("%-20s %-20s\n", "Name", "City");
    printf("---------------------------------------------\n");

    // Fetch rows
    while ((ret = SQLFetch(hStmt)) != SQL_NO_DATA) {
        if (SQL_SUCCEEDED(ret)) {
            printf("%-20s %-20s\n", name, city);
        } else {
            printSQLError(hStmt, SQL_HANDLE_STMT);
        }
    }

    // Clean up
    SQLFreeHandle(SQL_HANDLE_STMT, hStmt);
    SQLDisconnect(hDbc);
    SQLFreeHandle(SQL_HANDLE_DBC, hDbc);
    SQLFreeHandle(SQL_HANDLE_ENV, hEnv);

    printf("\nDisconnected.\n");

    return 0;
}

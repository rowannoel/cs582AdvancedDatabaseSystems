#include <stdio.h>
#include <string.h>
#include <sql.h>
#include <sqlext.h>

// Prints ODBC diagnostic messages
void printSQLError(SQLHANDLE handle, SQLSMALLINT type) {
    SQLCHAR sqlState[1024];
    SQLCHAR message[1024];
    if (SQLGetDiagRec(type, handle, 1, sqlState, NULL, message, 1024, NULL) == SQL_SUCCESS) {
        printf("ODBC Error: %s (%s)\n", message, sqlState);
    }
}

int main() {
    SQLHENV  hEnv   = NULL;
    SQLHDBC  hDbc   = NULL;
    SQLHSTMT hStmt  = NULL;
    SQLRETURN ret;

    // --- allocate environment + set ODBC version ---
    SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &hEnv);
    SQLSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION, (void*)SQL_OV_ODBC3, 0);
    SQLAllocHandle(SQL_HANDLE_DBC, hEnv, &hDbc);

    // Connection string 
    SQLCHAR connStr[] =
        "DRIVER={MariaDB Unicode};"
        "SERVER=35.24.200.118;"      
        "PORT=3306;"
        "DATABASE=HW10;"
        "UID=root;"
        "PWD=(I'm hiding my password);"
        "TCPIP=1;"
        "NO_PROMPT=1;";

    printf("Connecting to MySQL...\n");

    ret = SQLDriverConnect(hDbc, NULL, connStr, SQL_NTS, NULL, 0, NULL, SQL_DRIVER_COMPLETE);
    if (!SQL_SUCCEEDED(ret)) {
        printf("Connection failed!\n");
        printSQLError(hDbc, SQL_HANDLE_DBC);
        SQLFreeHandle(SQL_HANDLE_DBC, hDbc);
        SQLFreeHandle(SQL_HANDLE_ENV, hEnv);
        return 1;
    }
    printf("Connected successfully!\n\n");

    // --- prompt user for a customer name ---
    char inputName[100];
    printf("Enter customer name: ");
    fflush(stdout);
    if (fgets(inputName, sizeof(inputName), stdin) == NULL) {
        printf("No input received.\n");
        return 1;
    }
    // Remove trailing newline if present
    size_t len = strlen(inputName);
    if (len > 0 && inputName[len - 1] == '\n')
        inputName[len - 1] = '\0';

    // --- prepare stored procedure call ---
    SQLAllocHandle(SQL_HANDLE_STMT, hDbc, &hStmt);
    const char *procCall = "{CALL GetCustomerOrders(?)}";
    printf("\nCalling stored procedure: %s\n\n", procCall);

    ret = SQLPrepare(hStmt, (SQLCHAR*)procCall, SQL_NTS);
    if (!SQL_SUCCEEDED(ret)) {
        printf("Failed to prepare statement.\n");
        printSQLError(hStmt, SQL_HANDLE_STMT);
    } else {
        // bind the parameter with user input
        SQLBindParameter(
            hStmt, 1, SQL_PARAM_INPUT,
            SQL_C_CHAR, SQL_CHAR,
            100, 0, inputName, 0, NULL
        );

        // execute the stored procedure
        ret = SQLExecute(hStmt);
        if (!SQL_SUCCEEDED(ret)) {
            printf("Execution failed.\n");
            printSQLError(hStmt, SQL_HANDLE_STMT);
        } else {
            // columns returned by procedure
            int order_id;
            char order_date[20];
            double total_value;

            SQLBindCol(hStmt, 1, SQL_C_SLONG, &order_id, 0, NULL);
            SQLBindCol(hStmt, 2, SQL_C_CHAR, order_date, sizeof(order_date), NULL);
            SQLBindCol(hStmt, 3, SQL_C_DOUBLE, &total_value, 0, NULL);

            printf("Results for customer '%s':\n", inputName);
            printf("%-10s %-15s %-15s\n", "OrderID", "OrderDate", "TotalValue");
            printf("----------------------------------------------------\n");

            while ((ret = SQLFetch(hStmt)) != SQL_NO_DATA) {
                if (SQL_SUCCEEDED(ret))
                    printf("%-10d %-15s $%-14.2f\n", order_id, order_date, total_value);
                else
                    printSQLError(hStmt, SQL_HANDLE_STMT);
            }
        }
    }

    // --- cleanup ---
    SQLFreeHandle(SQL_HANDLE_STMT, hStmt);
    SQLDisconnect(hDbc);
    SQLFreeHandle(SQL_HANDLE_DBC, hDbc);
    SQLFreeHandle(SQL_HANDLE_ENV, hEnv);

    printf("\nDisconnected.\n");
    return 0;
}

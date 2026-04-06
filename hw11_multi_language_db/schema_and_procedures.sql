DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Staff;
DROP DATABASE IF EXISTS HW11;

CREATE DATABASE HW11 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE HW11;


CREATE TABLE Customers (
cust_id INT PRIMARY KEY,
name VARCHAR(50),
city VARCHAR(50),
state VARCHAR(2),
signup_date DATE
);

CREATE TABLE Staff (
staff_id INT PRIMARY KEY,
name VARCHAR(50),
role VARCHAR(50),
hire_date DATE,
salary INT
);

CREATE TABLE Products (
prod_id INT PRIMARY KEY,
name VARCHAR(50),
category VARCHAR(50),
unit_price DECIMAL(10,2)
);

CREATE TABLE Orders(
order_id INT PRIMARY KEY,
cust_id INT,
staff_id INT,
order_date DATE,
FOREIGN KEY (cust_id) REFERENCES Customers(cust_id),
FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
);

CREATE TABLE OrderItems(
order_id INT,
prod_id INT,
quantity INT,
unit_price DECIMAL(10,2),
FOREIGN KEY (order_id) REFERENCES Orders(order_id),
FOREIGN KEY (prod_id) REFERENCES Products(prod_id)
);


INSERT INTO Customers VALUES
(1, 'Alice Smith', 'Detroit', 'MI', '2020-02-15'),
(2, 'Bob Smith', 'Chicago', 'IL', '2022-08-20'),
(3, 'Charlie Davis', 'Ann Arbor', 'MI', '2023-09-01'),
(4, 'Dana Kim', 'Cleveland', 'OH', '2024-01-05'),
(5, 'Eli Nguyen', 'Lansing', 'MI', '2024-03-17'),
(6, 'Mary Sue', 'Battle Creek', 'MI', '2019-08-20'),
(7, 'Sally Mae', 'Green Bay', 'WI', '2023-09-01'),
(8, 'Sam Booth', 'Rhinelander', 'WI', '2024-09-05'),
(9, 'Johnny Appleseed', 'Lansing', 'MI', '2025-03-17'),
(10, 'Lou Shadow', 'Detroit', 'MI', '2025-02-15');

INSERT INTO Staff VALUES
(101, 'Sarah Lee', 'Sales Rep', '2022-05-10', 60000),
(102, 'Tom Parker', 'Sales Rep', '2023-02-01', 58000),
(103, 'Maria Lopez', 'Manager', '2021-11-12', 80000),
(104, 'Cam Hoggins', 'Sales Rep', '2021-11-12', 49000);

INSERT INTO Products VALUES
(201, 'Laptop X', 'Electronics', 1200),
(202, 'Phone Z', 'Electronics', 900),
(203, 'Tablet A', 'Electronics', 500),
(204, 'Monitor B', 'Peripherals', 250),
(205, 'Keyboard C', 'Peripherals', 80),
(206, 'Mouse A', 'Electronics', 50);

INSERT INTO Orders VALUES
(301, 1, 101, '2024-02-20'),
(302, 2, 101, '2024-02-25'),
(303, 3, 102, '2024-03-01'),
(304, 4, 103, '2024-03-05'),
(305, 5, 101, '2024-03-10');

INSERT INTO OrderItems VALUES
(301, 201, 3, 1200),   
(301, 202, 2, 900),    
(302, 205, 5, 80),     
(303, 203, 6, 500),    
(304, 201, 2, 1200),  
(304, 202, 4, 900),   
(305, 204, 10, 250);  

DELIMITER //
CREATE PROCEDURE populate_orders()
BEGIN
  DECLARE i INT DEFAULT 1;
  WHILE i <= 300 DO
    INSERT INTO Orders (order_id, cust_id, staff_id, order_date)
    VALUES (
      i,                                          -- order_id
      FLOOR(1 + RAND() * 5),                      -- random customer 1–5
      FLOOR(101 + RAND() * 3),                    -- random staff 101–103
      DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 730) DAY)  -- random date in 2023–2024
    );
    SET i = i + 1;
  END WHILE;
END//
DELIMITER ;

CALL populate_orders();
DROP PROCEDURE populate_orders;

DELIMITER //

CREATE PROCEDURE GetCustomerOrderSummary(IN in_cust_id INT)
BEGIN
    SELECT 
        C.cust_id,
        C.name AS customer_name,
        COUNT(order_totals.order_id) AS total_orders,
        COALESCE(SUM(order_totals.order_total), 0) AS total_revenue,
        MAX(O.order_date) AS most_recent_order
    FROM Customers C
    LEFT JOIN Orders O 
        ON C.cust_id = O.cust_id
    LEFT JOIN (
        SELECT order_id, SUM(quantity * unit_price) AS order_total
        FROM OrderItems
        GROUP BY order_id
    ) AS order_totals 
        ON O.order_id = order_totals.order_id
    WHERE C.cust_id = in_cust_id
    GROUP BY C.cust_id, C.name;
END //

DELIMITER ;




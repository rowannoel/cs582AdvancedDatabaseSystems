DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Staff;
DROP DATABASE IF EXISTS HW9;

CREATE DATABASE HW9 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE HW9;


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

-- Quick Verification Queries to make sure everything is working
-- SELECT * FROM Customers;
-- SELECT * FROM Staff;
-- SELECT * FROM Products;
-- SELECT * FROM Orders;
-- SELECT * FROM OrderItems;

CREATE VIEW HighValueOrders AS
SELECT 
    o.order_id,
    o.cust_id,
    SUM(oi.quantity * oi.unit_price) AS total_value
FROM Orders o
JOIN OrderItems oi ON o.order_id = oi.order_id
GROUP BY o.order_id, o.cust_id
HAVING SUM(oi.quantity * oi.unit_price) > 5000;

-- SELECT * FROM HighValueOrders;

-- SELECT c.name, c.city
-- FROM Customers c
-- JOIN HighValueOrders hvo ON c.cust_id = hvo.cust_id;

CREATE VIEW InStateCustomers AS
SELECT cust_id, name, city, state, signup_date
FROM Customers
WHERE state = 'MI'
WITH CHECK OPTION;

INSERT INTO InStateCustomers (cust_id, name, city, state, signup_date)
VALUES (205, 'Alex Turner', 'Detroit', 'MI', '2025-10-30');

-- SELECT * FROM InStateCustomers;

CREATE TABLE StaffSalesMV AS
SELECT 
    s.staff_id,
    SUM(oi.quantity * oi.unit_price) AS totalSales
FROM Staff s
JOIN Orders o ON s.staff_id = o.staff_id
JOIN OrderItems oi ON o.order_id = oi.order_id
GROUP BY s.staff_id;

-- SELECT * FROM StaffSalesMV;

-- INSERT INTO OrderItems (order_id, prod_id, quantity, unit_price)
-- VALUES (301, 205, 2, 80);

-- SELECT * FROM StaffSalesMV;

-- SET SQL_SAFE_UPDATES = 0;
-- DELETE FROM StaffSalesMV;

-- INSERT INTO StaffSalesMV
-- SELECT 
    -- s.staff_id,
    -- SUM(oi.quantity * oi.unit_price) AS total_sales
-- FROM Staff s
-- JOIN Orders o ON s.staff_id = o.staff_id
-- JOIN OrderItems oi ON o.order_id = oi.order_id
-- GROUP BY s.staff_id;

-- SELECT * FROM StaffSalesMV;

-- EXPLAIN SELECT * 
-- FROM Orders 
-- WHERE order_date BETWEEN '2024-02-01' AND '2024-03-01';

-- CREATE INDEX idxOrdersOrderDate ON Orders(order_date);

-- EXPLAIN SELECT * 
-- FROM Orders 
-- WHERE order_date BETWEEN '2024-02-01' AND '2024-03-01';

-- CREATE INDEX idx_orderitems_order_prod ON OrderItems(order_id, prod_id);

-- EXPLAIN SELECT * 
-- FROM OrderItems 
-- WHERE order_id = 301 AND prod_id = 201;

-- EXPLAIN SELECT * 
-- FROM OrderItems 
-- WHERE prod_id = 201;

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE Orders;

SET FOREIGN_KEY_CHECKS = 1;


-- Generate 1000 random rows with order dates across 2023-2024
-- You can paste this whole block in MySQL Workbench

DELIMITER //
CREATE PROCEDURE populate_orders()
BEGIN
  DECLARE i INT DEFAULT 1;
  WHILE i <= 1000 DO
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


EXPLAIN SELECT * 
FROM Orders 
WHERE order_date BETWEEN '2024-02-01' AND '2024-03-01';

CREATE TABLE OrdersClustered AS
SELECT * FROM Orders
ORDER BY order_date;

EXPLAIN SELECT * 
FROM OrdersClustered 
WHERE order_date BETWEEN '2024-02-01' AND '2024-03-01';


-- HW6 - Problem 2: Subqueries with IN / EXISTS / ANY / ALL

-- (a) List the names of Customers who placed any order containing a product
-- in the 'Electronics' category.
SELECT DISTINCT c.name
FROM Customers c
WHERE c.cust_id IN (
    SELECT o.cust_id
    FROM Orders o
    JOIN OrderItems oi ON o.order_id = oi.order_id
    JOIN Products p ON oi.prod_id = p.prod_id
    WHERE p.category = 'Electronics'
);

-- (b) Find the Staff whose salary is strictly greater than the salaries
-- of all staff in the role 'Sales Associate'.
SELECT name
FROM Staff
WHERE salary > ALL (
    SELECT salary
    FROM Staff
    WHERE role = 'Sales Associate'
);

-- (c) Report the Products.name whose unit_price is greater than any price
-- among products in the 'Books' category.
SELECT name
FROM Products
WHERE unit_price > ANY (
    SELECT unit_price
    FROM Products
    WHERE category = 'Books'
);

-- (d) List the names of Customers who have at least one order on record.
SELECT DISTINCT c.name
FROM Customers c
WHERE EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.cust_id = c.cust_id
);

-- (e) List the Products that have never been ordered.
SELECT name
FROM Products p
WHERE NOT EXISTS (
    SELECT 1
    FROM OrderItems oi
    WHERE oi.prod_id = p.prod_id
);

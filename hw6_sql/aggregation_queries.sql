-- HW6 - Problem 1: Aggregation and Grouping

-- (a) For each product category, report the total number of distinct products
-- and the average unit price from Products. Sort by category.
SELECT category,
       COUNT(DISTINCT prod_id) AS num_products,
       AVG(unit_price) AS avg_price
FROM Products
GROUP BY category
ORDER BY category ASC;

-- (b) For each role in Staff, report the number of staff hired on or before 2022
-- and the maximum salary in that role. Include only roles with at least 3 staff.
SELECT role,
       COUNT(*) AS num_staff,
       MAX(salary) AS max_salary
FROM Staff
WHERE hire_date <= '2022-12-31'
GROUP BY role
HAVING COUNT(*) >= 3;

-- (c) For each YYYY-MM month in 2025, report:
-- (i) number of orders and
-- (ii) total revenue computed as SUM(quantity * unit_price) over OrderItems.
-- Include only months with at least 50 orders.
SELECT EXTRACT(YEAR FROM o.order_date) AS order_year,
       EXTRACT(MONTH FROM o.order_date) AS order_month,
       COUNT(DISTINCT o.order_id) AS num_orders,
       SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM Orders o
JOIN OrderItems oi ON o.order_id = oi.order_id
WHERE EXTRACT(YEAR FROM o.order_date) = 2025
GROUP BY EXTRACT(YEAR FROM o.order_date),
         EXTRACT(MONTH FROM o.order_date)
HAVING COUNT(DISTINCT o.order_id) >= 50
ORDER BY order_year, order_month;

-- (d) For each city, count how many distinct customers placed >= 2 orders in 2025.
-- Show only cities with a count >= 5.
SELECT city,
       COUNT(*) AS num_customers
FROM (
    SELECT c.city,
           c.cust_id
    FROM Customers c
    JOIN Orders o ON c.cust_id = o.cust_id
    WHERE EXTRACT(YEAR FROM o.order_date) = 2025
    GROUP BY c.city, c.cust_id
    HAVING COUNT(DISTINCT o.order_id) >= 2
) AS multi_order_customers
GROUP BY city
HAVING COUNT(*) >= 5;

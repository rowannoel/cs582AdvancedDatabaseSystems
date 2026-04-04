-- HW6 - Problem 3: Scalar & Correlated Subqueries + HAVING

-- (a) For each staff member, report (name, role, salary) and a fourth column
-- showing the role average salary via a scalar subquery over Staff.
-- Include only those whose salary is strictly below their role's average.
SELECT s.name,
       s.role,
       s.salary,
       (
           SELECT AVG(s2.salary)
           FROM Staff s2
           WHERE s2.role = s.role
       ) AS role_avg
FROM Staff s
WHERE s.salary < (
    SELECT AVG(s2.salary)
    FROM Staff s2
    WHERE s2.role = s.role
);

-- (b) List each category in Products where the earliest order date
-- (minimum across all orders that include a product in that category)
-- is before 2024.
SELECT p.category
FROM Products p
JOIN OrderItems oi ON p.prod_id = oi.prod_id
JOIN Orders o ON oi.order_id = o.order_id
GROUP BY p.category
HAVING MIN(o.order_date) < '2024-01-01';

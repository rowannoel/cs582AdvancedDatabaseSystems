# Advanced SQL: Subqueries, Grouping, and HAVING

This project demonstrates advanced SQL querying techniques including aggregation, subqueries, and correlated queries.

## Schema

- Customers(cust_id, name, city, state, signup_date)
- Staff(staff_id, name, role, hire_date, salary)
- Products(prod_id, name, category, unit_price)
- Orders(order_id, cust_id, staff_id, order_date)
- OrderItems(order_id, prod_id, quantity, unit_price)

---

## Topics Covered

### Aggregation & Grouping
- GROUP BY and HAVING
- COUNT, AVG, SUM
- Filtering grouped results

### Subqueries
- IN, EXISTS
- ANY, ALL
- Nested queries across multiple tables

### Advanced Queries
- Scalar subqueries
- Correlated subqueries
- Multi-level filtering

---

## Key Concepts

- Writing complex queries across multiple tables
- Using subqueries for dynamic filtering
- Understanding how SQL evaluates nested queries
- Applying aggregation with constraints

---

## Files

- `aggregation_queries.sql` — grouping, aggregation, and HAVING queries
- `subqueries.sql` — nested subqueries using IN / EXISTS / ANY / ALL
- `advanced_queries.sql` — scalar and correlated subqueries

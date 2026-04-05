-- HW8 - Problem 5: Triggers

-- (a) BEFORE INSERT repair:
-- If Orders.order_date is NULL, replace it with the current date.
CREATE TRIGGER fixOrderDate
BEFORE INSERT ON Orders
REFERENCING NEW ROW AS NewRow
FOR EACH ROW
WHEN (NewRow.order_date IS NULL)
BEGIN
    SET NewRow.order_date = CURRENT_DATE;
END;

-- Example success: order_date auto-filled
INSERT INTO Orders (order_id, cust_id, staff_id, order_date)
VALUES (1, 5, 2, NULL);

-- Example success: existing date remains unchanged
INSERT INTO Orders (order_id, cust_id, staff_id, order_date)
VALUES (2, 5, 2, '2025-10-25');


-- (b) AFTER INSERT check:
-- Reject insert if OrderItems.unit_price differs from Products.unit_price
-- by more than 50%.
CREATE TRIGGER checkPriceDeviation
AFTER INSERT ON OrderItems
REFERENCING NEW ROW AS NewRow
FOR EACH ROW
WHEN (
    NewRow.unit_price >
        (SELECT unit_price
         FROM Products
         WHERE prod_id = NewRow.prod_id) * 1.5
    OR
    NewRow.unit_price <
        (SELECT unit_price
         FROM Products
         WHERE prod_id = NewRow.prod_id) * 0.5
)
BEGIN
    RAISE ERROR 'Unit price differs by more than 50% from Products price.';
END;

-- Example success: valid price
INSERT INTO OrderItems (order_id, prod_id, quantity, unit_price)
VALUES (1, 101, 2, 100);

-- Example violation: price too low
INSERT INTO OrderItems (order_id, prod_id, quantity, unit_price)
VALUES (1, 101, 2, 40);


-- (c) Statement-level roll-up:
-- Log the count of rows inserted by a statement into Audit(order_id, rows_added, ts).
CREATE TRIGGER logOrderItems
AFTER INSERT ON OrderItems
REFERENCING NEW TABLE AS NewRows
FOR EACH STATEMENT
BEGIN
    INSERT INTO Audit (order_id, rows_added)
    SELECT order_id, COUNT(*)
    FROM NewRows
    GROUP BY order_id;
END;

-- Example success: multiple inserted rows logged into Audit
INSERT INTO OrderItems (order_id, prod_id, quantity, unit_price)
VALUES (10, 1, 2, 50),
       (10, 2, 1, 20);

SELECT * FROM Audit;

-- Example violation: nonexistent order_id causes FK failure, so trigger does not fire
INSERT INTO OrderItems (order_id, prod_id, quantity, unit_price)
VALUES (999, 101, 1, 100);

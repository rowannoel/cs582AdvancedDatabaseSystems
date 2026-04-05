-- HW7 - Problem 2: Foreign Keys & Referential Integrity Options

-- (a) Add a named FK from Orders(cust_id) to Customers(cust_id)
-- with ON DELETE RESTRICT and ON UPDATE CASCADE.
ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customers
FOREIGN KEY (cust_id) REFERENCES Customers(cust_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- (b) Add a named FK from Orders(staff_id) to Staff(staff_id)
-- with ON DELETE SET NULL. Ensure Orders.staff_id allows NULL.
ALTER TABLE Orders
ALTER COLUMN staff_id DROP NOT NULL;

ALTER TABLE Orders
ADD CONSTRAINT leaveNull
FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
ON DELETE SET NULL;

-- (c) Sample statements rejected by the FK policies

-- Rejected: cannot delete a customer that is still referenced by Orders
DELETE FROM Customers
WHERE cust_id = 5;

-- Rejected: staff_id = 999 does not exist in Staff
INSERT INTO Orders (order_id, cust_id, staff_id, order_date)
VALUES (501, 2, 999, CURRENT_DATE);

-- Successful statements under the FK policies

-- Allowed: updating the customer ID cascades to related Orders rows
UPDATE Customers
SET cust_id = 20
WHERE cust_id = 5;

-- Allowed: deleting a staff row sets related Orders.staff_id to NULL
DELETE FROM Staff
WHERE staff_id = 3;

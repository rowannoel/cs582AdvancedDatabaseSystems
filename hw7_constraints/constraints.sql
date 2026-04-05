-- HW7 - Problem 1: Basic Attribute & Tuple Constraints

-- (a) Ensure Products.unit_price is NOT NULL and strictly positive.
ALTER TABLE Products
ADD CONSTRAINT itemsPriced
CHECK (unit_price > 0);

ALTER TABLE Products
ALTER COLUMN unit_price SET NOT NULL;

-- (b) Constrain Products.category to one of:
-- Books, Electronics, Grocery, Clothing
ALTER TABLE Products
ADD CONSTRAINT validCategory
CHECK (category IN ('Books', 'Electronics', 'Grocery', 'Clothing'));

-- (c) In OrderItems, ensure quantity >= 1 and unit_price >= 0
-- using a single tuple-level CHECK.
ALTER TABLE OrderItems
ADD CONSTRAINT ValidOrder
CHECK (quantity >= 1 AND unit_price >= 0);

-- (d) Named constraint example that can later be dropped or modified.
ALTER TABLE Products
ADD CONSTRAINT PositiveUnitPrice
CHECK (unit_price > 0);

ALTER TABLE Products
DROP CONSTRAINT PositiveUnitPrice;

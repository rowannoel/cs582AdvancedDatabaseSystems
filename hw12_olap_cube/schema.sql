-- HW12 - OLAP Schema Setup

-- Product dimension table
CREATE TABLE Product (
    productID SERIAL PRIMARY KEY,
    productName VARCHAR(50) NOT NULL
);

-- Dealer dimension table
CREATE TABLE Dealer (
    dealerID SERIAL PRIMARY KEY,
    dealerName VARCHAR(50) NOT NULL,
    region VARCHAR(50)
);

-- Sales fact table
CREATE TABLE Sales (
    saleID SERIAL PRIMARY KEY,
    productID INT REFERENCES Product(productID),
    dealerID INT REFERENCES Dealer(dealerID),
    saleDate DATE NOT NULL,
    price NUMERIC(10,2) NOT NULL
);

-- Insert Products

INSERT INTO Product (productName) VALUES
('Laptop'),
('Tablet'),
('Phone');

-- Insert Dealers

INSERT INTO Dealer (dealerName, region) VALUES
('TechWorld', 'Midwest'),
('GigaStore', 'Southeast'),
('ElectroHub', 'Northeast');

-- Insert Sales Data

INSERT INTO Sales (productId, dealerId, saleDate, price) VALUES
(1, 1, '2024-01-10', 1200.00),
(1, 1, '2024-01-15', 1300.00),
(1, 2, '2024-02-01', 1250.00),
(2, 1, '2024-01-12', 500.00),
(2, 3, '2024-03-05', 550.00),
(2, 3, '2024-03-07', 530.00),
(3, 2, '2024-02-10', 900.00),
(3, 2, '2024-02-11', 920.00),
(3, 3, '2024-03-20', 890.00),
(3, 1, '2024-01-22', 880.00),
(1, 3, '2024-03-18', 1280.00),
(2, 2, '2024-02-19', 510.00);

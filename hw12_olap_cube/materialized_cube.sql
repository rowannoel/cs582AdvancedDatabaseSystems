CREATE MATERIALIZED VIEW sales_cube_mv AS
SELECT
    p.productName,
    d.dealerName,
    s.saleDate,
    SUM(s.price) AS totalSales
FROM Sales s
JOIN Product p ON s.productId = p.productId
JOIN Dealer d ON s.dealerId = d.dealerId
GROUP BY CUBE (p.productName, d.dealerName, s.saleDate);


-- insert new data
INSERT INTO Sales (productId, dealerId, saleDate, price) VALUES
(1, 3, '2025-04-02', 1400.00),
(2, 2, '2025-04-05', 540.00),
(3, 1, '2025-04-07', 930.00);

-- refresh cube
REFRESH MATERIALIZED VIEW sales_cube_mv;

-- view updated cube
SELECT *
FROM sales_cube_mv
ORDER BY productName, dealerName, saleDate;

--Slide
SELECT
    d.dealerName,
    s.saleDate,
    SUM(s.price) AS totalSales
FROM Sales s
JOIN Product p ON s.productId = p.productId
JOIN Dealer d ON s.dealerId = d.dealerId
WHERE p.productName = 'Laptop'
GROUP BY d.dealerName, s.saleDate
ORDER BY s.saleDate;

--Dice
SELECT
    p.productName,
    d.dealerName,
    d.region,
    s.saleDate,
    SUM(s.price) AS totalSales
FROM Sales s
JOIN Product p ON s.productId = p.productId
JOIN Dealer d ON s.dealerId = d.dealerId
WHERE d.region IN ('Southeast', 'Northeast')
AND s.saleDate BETWEEN '2024-02-01' AND '2024-03-31'
GROUP BY p.productName, d.dealerName, d.region, s.saleDate
ORDER BY s.saleDate;

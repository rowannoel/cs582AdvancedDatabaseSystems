SELECT
    p.productName,
    d.dealerName,
    s.saleDate,
    SUM(s.price) AS totalSales
FROM Sales s
JOIN Product p ON s.productId = p.productId
JOIN Dealer d ON s.dealerId = d.dealerId
GROUP BY CUBE (p.productName, d.dealerName, s.saleDate)
ORDER BY p.productName, d.dealerName, s.saleDate;

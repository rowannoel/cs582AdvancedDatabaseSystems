SELECT
    s.saleId,
    p.productName,
    d.dealerName,
    d.region,
    s.saleDate,
    s.price
FROM Sales s
JOIN Product p ON s.productId = p.productId
JOIN Dealer d ON s.dealerId = d.dealerId
ORDER BY s.saleDate;

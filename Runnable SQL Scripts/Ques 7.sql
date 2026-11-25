SELECT
    OrderItemID,
    COUNT(*) AS ReturnTransactionCount,
    SUM(ReturnQuantity) AS TotalReturnedUnits
FROM Returns
GROUP BY OrderItemID
HAVING COUNT(*) > 1;
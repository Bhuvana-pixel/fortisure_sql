SELECT
    r.RegionName,
    COUNT(DISTINCT o.OrderID) AS CompletedOrderCount,
    SUM(oi.Quantity * oi.UnitPrice) AS GrossSales
FROM Orders o
JOIN Stores s
    ON o.StoreID = s.StoreID
JOIN Regions r
    ON s.RegionID = r.RegionID
JOIN OrderItems_Clean oi
    ON o.OrderID = oi.OrderID
WHERE o.OrderStatus = 'Completed'
AND o.OrderDate >= '2026-10-01'
AND o.OrderDate < '2026-11-01'
GROUP BY r.RegionName;


SELECT
    r.RegionName,
    COALESCE(
        SUM(ret.ReturnQuantity * oi.UnitPrice), 0
    ) AS ReturnValue
FROM Regions r
JOIN Stores s
    ON r.RegionID = s.RegionID
LEFT JOIN Orders o
    ON s.StoreID = o.StoreID
    AND o.OrderStatus = 'Completed'
LEFT JOIN OrderItems_Clean oi
    ON o.OrderID = oi.OrderID
LEFT JOIN Returns ret
    ON oi.OrderItemID = ret.OrderItemID
    AND ret.ReturnDate >= '2026-10-01'
    AND ret.ReturnDate < '2026-11-01'
GROUP BY r.RegionName;
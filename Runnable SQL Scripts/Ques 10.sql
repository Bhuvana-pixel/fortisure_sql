SELECT
    s.StoreID,
    s.StoreName,
    r.RegionName,
    SUM(oi.Quantity * oi.UnitPrice) AS GrossSales
FROM Stores s
JOIN Regions r
    ON s.RegionID = r.RegionID
JOIN Orders o
    ON s.StoreID = o.StoreID
JOIN OrderItems_Clean oi
    ON o.OrderID = oi.OrderID
WHERE o.OrderStatus = 'Completed'
AND o.OrderDate >= '2026-10-01'
AND o.OrderDate < '2026-11-01'
GROUP BY s.StoreID, s.StoreName, r.RegionName
ORDER BY r.RegionName, GrossSales DESC;

SELECT
    s.StoreID,
    s.StoreName,
    r.RegionName,
    COALESCE(
        SUM(ret.ReturnQuantity * oi.UnitPrice), 0
    ) AS ReturnValue
FROM Stores s
JOIN Regions r
    ON s.RegionID = r.RegionID
LEFT JOIN Orders o
    ON s.StoreID = o.StoreID
    AND o.OrderStatus = 'Completed'
LEFT JOIN OrderItems_Clean oi
    ON o.OrderID = oi.OrderID
LEFT JOIN Returns ret
    ON oi.OrderItemID = ret.OrderItemID
    AND ret.ReturnDate >= '2026-10-01'
    AND ret.ReturnDate < '2026-11-01'
GROUP BY s.StoreID, s.StoreName, r.RegionName
ORDER BY r.RegionName, ReturnValue DESC;
WITH CategoryReturns AS (
    SELECT
        p.Category,
        SUM(ret.ReturnQuantity * oi.UnitPrice) AS ReturnValue
    FROM Returns ret
    JOIN OrderItems_Clean oi
        ON ret.OrderItemID = oi.OrderItemID
    JOIN Products p
        ON oi.ProductID = p.ProductID
    JOIN Orders o
        ON oi.OrderID = o.OrderID
    JOIN Stores s
        ON o.StoreID = s.StoreID
    JOIN Regions r
        ON s.RegionID = r.RegionID
    WHERE r.RegionName = 'North'
      AND o.OrderStatus = 'Completed'
      AND ret.ReturnDate >= '2026-10-01'
      AND ret.ReturnDate < '2026-11-01'
    GROUP BY p.Category
)
SELECT
    Category,
    ReturnValue,
    ROUND(
        ReturnValue * 100 / SUM(ReturnValue) OVER (), 2
    ) AS ReturnShare
FROM CategoryReturns
ORDER BY ReturnValue DESC;
CREATE TABLE OrderItems_Clean LIKE OrderItems;

INSERT INTO OrderItems_Clean
SELECT * FROM OrderItems;

SET SQL_SAFE_UPDATES = 0;

DELETE o1
FROM OrderItems_Clean o1
JOIN OrderItems_Clean o2
ON o1.OrderItemID = o2.OrderItemID
WHERE
    o1.LoadedAt < o2.LoadedAt
    OR
    (o1.LoadedAt = o2.LoadedAt AND o1.RowID < o2.RowID);

SET SQL_SAFE_UPDATES = 1;

SELECT
    OrderItemID,
    COUNT(*) AS DuplicateCount
FROM OrderItems_Clean
GROUP BY OrderItemID
HAVING COUNT(*) > 1;
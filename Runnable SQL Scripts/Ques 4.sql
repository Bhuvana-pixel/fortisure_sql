SELECT
    o.OrderID,
    o.CustomerID,
    c.CustomerName
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID;
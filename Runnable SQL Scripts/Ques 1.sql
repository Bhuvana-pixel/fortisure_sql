CREATE TABLE Regions (
    RegionID INT PRIMARY KEY,
    RegionName VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO Regions (RegionID, RegionName)
VALUES
(1, 'North'),
(2, 'South'),
(3, 'West');

UPDATE Stores s
JOIN Regions r
ON CASE
    WHEN UPPER(TRIM(s.RegionRaw)) IN ('N', 'NORTH') THEN 'North'
    WHEN UPPER(TRIM(s.RegionRaw)) IN ('S', 'SOUTH') THEN 'South'
    WHEN UPPER(TRIM(s.RegionRaw)) IN ('W', 'WEST') THEN 'West'
END = r.RegionName
SET s.RegionID = r.RegionID;

SELECT
    s.StoreID,
    s.StoreName,
    s.RegionRaw,
    r.RegionName
FROM Stores s
LEFT JOIN Regions r
ON s.RegionID = r.RegionID;

SELECT *
FROM Stores
WHERE RegionID IS NULL;
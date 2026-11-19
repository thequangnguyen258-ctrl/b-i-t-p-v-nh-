



-- bài 1 --
SELECT AccountKey, AccountDescription, AccountType
FROM DimAccount;



-- bài 2--
SELECT 
    CustomerKey,
    FirstName,
    MiddleName,
    LastName,
    FirstName + ' ' + ISNULL(MiddleName + ' ', '') + LastName AS FullName,
    BirthDate,
    MaritalStatus,
    Gender,
    EmailAddress
FROM DimCustomer;


--bài 4 -- 
SELECT OrderDate, ProductKey, CustomerPONumber, SalesAmount, OrderQuantity, UnitPrice
FROM FactResellerSales
ORDER BY OrderDate ASC, ProductKey ASC, SalesAmount DESC;

-- phần 2--
-- bài 1 --
SELECT *
FROM DimCustomer
WHERE FirstName + ' ' + MiddleName + ' ' + LastName IN (
    'Hannah E Long', 
    'Mason D Roberts', 
    'Jennifer S Cooper'
)
ORDER BY BirthDate ASC;

--bài 2 --
SELECT OrderDate, SalesOrderNumber, ProductKey, UnitPrice, OrderQuantity, ResellerKey
FROM FactResellerSales
WHERE ResellerKey = 322;

--bài 3 --
SELECT *
FROM FactFinance
WHERE AccountKey = 61;


--bài 4-- 
SELECT *
FROM FactCallCenter
WHERE Shift = 'AM' AND Calls >= 400
ORDER BY Calls DESC;


--bài 5 --
SELECT DISTINCT [Date]
FROM FactCallCenter
WHERE IssuesRaised > 2 AND AverageTimePerIssue > 60;

--bài 6--
SELECT DISTINCT [Date]
FROM FactCallCenter
WHERE IssuesRaised > 2 AND AverageTimePerIssue > 60;


--bài 7--
SELECT *
FROM DimEmployee
WHERE Title = 'Sales Representative' 
  AND SalesTerritoryKey IN (10, 1);


--bài 8--
SELECT TOP 9 ProductKey,Status, ReorderPoint, SafetyStockLevel, ListPrice
FROM DimProduct
WHERE Status = 'Current'
  AND (
      (ReorderPoint > 300 AND SafetyStockLevel > 400)
      OR (ListPrice BETWEEN 100 AND 300)
  )
ORDER BY ListPrice DESC;


-- PHẦN 3 --

-- BÀI 1--  
SELECT 
    ProductKey,
    (ListPrice - DealerPrice) * 1.1 AS [Gap Price]
FROM DimProduct
WHERE Color IS NOT NULL AND Color <> 'NA'
ORDER BY [Gap Price] DESC;


-- bài 2--
SELECT 
    SalesOrderNumber,
    OrderDate,
    Freight / OrderQuantity AS FreightPerUnit,
    (SalesAmount + TaxAmt + Freight) AS TotalAmountDue,
    (TaxAmt / (SalesAmount + TaxAmt + Freight)) * 100 AS TaxPercentage,
    (SalesAmount - TotalProductCost) AS Profit
FROM FactResellerSales
WHERE ShipDate <= DueDate
  AND YEAR(OrderDate) IN (2012, 2013);


--  Phần 4--
--bài 1--
SELECT CustomerKey ,FirstName , LastName, EnglishEducation
FROM DimCustomer
WHERE EnglishEducation IN ('Partial High School', 'High School', 'Graduate Degree');


--bài 2 --
SELECT  CustomerKey ,FirstName , LastName, EnglishOccupation, EnglishOccupation, CommuteDistance
FROM DimCustomer
WHERE EnglishEducation IN ('Partial High School', 'High School', 'Graduate Degree')
  AND (
      (EnglishOccupation = 'Professional' AND CommuteDistance = '10+ Miles')
      OR (EnglishOccupation = 'Clerical' AND CommuteDistance = '0-1 Miles')
  );

 -- Phần 5--


 -- bài 1 --
SELECT CustomerKey, FirstName, LastName, GeographyKey
FROM DimCustomer
WHERE GeographyKey IN (
    SELECT DISTINCT GeographyKey
    FROM DimCustomer
    WHERE CustomerKey IN (
        SELECT CustomerKey
        FROM FactInternetSales
        WHERE SalesAmount > 2000
    )
);


--bài 2 --

SELECT *
FROM DimProduct
WHERE Color = 'Red'
  AND ListPrice > 500
  AND ProductKey IN (
      SELECT TOP 5 ProductKey
      FROM FactInternetSales
      ORDER BY SalesAmount DESC
  );















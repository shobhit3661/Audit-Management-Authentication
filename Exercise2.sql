/*Write separate queries using a join, a subquery, a CTE, and then an EXISTS to list all AdventureWorks
customers who have not placed an order.*/

USE [AdventureWorks2008R2]
GO

--using join

SELECT * FROM Sales.Customer c
LEFT JOIN  Sales.SalesOrderHeader soh
ON c.CustomerID=soh.CustomerID
WHERE soh.SalesOrderID IS NULL


--using subquery

SELECT * FROM Sales.Customer c
WHERE CustomerID NOT IN
(SELECT CustomerID FROM Sales.SalesOrderHeader)
ORDER BY CustomerID

--using CTE

WITH soh AS
(
    SELECT SalesOrderID,CustomerID FROM Sales.SalesOrderHeader 
)
SELECT * FROM Sales.Customer c
LEFT JOIN soh ON c.CustomerID=soh.CustomerID
WHERE soh.SalesOrderID IS NULL


--using exists

SELECT * FROM Sales.Customer c
WHERE NOT EXISTS
(
   SELECT CustomerID FROM Sales.SalesOrderHeader soh
   WHERE soh.CustomerID=c.CustomerID
)
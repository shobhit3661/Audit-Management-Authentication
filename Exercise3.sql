/*Show the most recent five orders that were purchased from account numbers that have spent more than $70,000 with AdventureWorks.*/

USE [AdventureWorks2008R2]
GO

  WITH s
  AS(
       SELECT sh.*,
          SUM(sd.LineTotal) OVER (PARTITION BY sh.AccountNumber ) AS TotalPurchase,
          ROW_NUMBER() OVER (PARTITION BY sh.AccountNumber ORDER BY sh.OrderDate DESC) AS SNo
       FROM Sales.SalesOrderHeader sh
       JOIN Sales.SalesOrderDetail sd ON sh.SalesOrderID = sd.SalesOrderID
  )

  SELECT CustomerID,AccountNumber,OrderDate FROM s
  WHERE TotalPurchase > 70000
  AND SNo <= 5
  
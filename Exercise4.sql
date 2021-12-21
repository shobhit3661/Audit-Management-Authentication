/*Create a function that takes as inputs a SalesOrderID, a Currency Code, and a date, and returns a table of allthe SalesOrderDetail
rows for that Sales Order including Quantity, ProductID, UnitPrice, and the unit price converted to the target currency based on the
end of day rate for the date provided. Exchange rates can be found in the Sales.CurrencyRate table. ( Use AdventureWorks)*/

USE [AdventureWorks2008R2]
GO

CREATE FUNCTION CurrencyConversion(@SalesOrderId int,@CurrencyCode nchar(3),@Date datetime)
RETURNS TABLE
AS
RETURN 
	SELECT ProductID,OrderQty,UnitPrice AS 'UnitPriceBefore',
		   UnitPrice*(
		               SELECT EndOfDayRate FROM Sales.CurrencyRate
				       WHERE ToCurrencyCode=@CurrencyCode AND ModifiedDate=@Date
		             ) AS 'UnitPriceAfter'
	FROM Sales.SalesOrderDetail
	WHERE @SalesOrderId=@SalesOrderId
Go

-- Execute the function
Select * from CurrencyConversion('43681','EUR','2005-07-01');
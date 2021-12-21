/*Write a trigger for the Product table to ensure the list price can never be raised more than 15 Percent in a single change. */

USE [AdventureWorks2008R2]
GO

CREATE TRIGGER tr_Product_Update
ON Production.Product
FOR UPDATE
AS 
IF EXISTS
(
SELECT * FROM inserted i
JOIN deleted d
ON i.ProductID=d.ProductID
WHERE i.ListPrice>d.ListPrice*1.15
)

BEGIN
RAISERROR('price can never be raised more than 15 Percent in a single change',16,1)
ROLLBACK TRANSACTION
END


--Updating the price so that trigger gets called

UPDATE Production.Product SET ListPrice=1000 WHERE ProductID = 830


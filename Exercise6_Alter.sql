/* Modify the above trigger to execute its check code only if the ListPrice column is   updated*/

Use [AdventureWorks2008R2]
GO

ALTER TRIGGER tr_Product_Update
ON Production.Product
FOR UPDATE
AS
IF UPDATE(ListPrice)
BEGIN

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
END

--Updating the price so that trigger gets called

UPDATE Production.Product SET ListPrice=1000 WHERE ProductID=830
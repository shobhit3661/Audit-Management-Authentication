USE [AdventureWorks2008R2]
GO

/*1.Display the number of records in the [SalesPerson] table. (Schema(s) involved: Sales) */

SELECT COUNT(*) AS Count from Sales.SalesPerson


/* 2.Select both the FirstName and LastName of records from the Person table where the FirstName
begins with the letter ‘B’. (Schema(s) involved: Person)*/

SELECT FirstName,LastName from Person.Person WHERE Firstname LIKE 'B%'


/* 3.Select a list of FirstName and LastName for employees where Title is one of Design Engineer,
Tool Designer or Marketing Assistant. (Schema(s) involved: HumanResources, Person)*/

SELECT p.FirstName,p.LastName from Person.Person AS p inner join HumanResources.Employee e
on p.BusinessEntityID=e.BusinessEntityID
WHERE JobTitle ='Design Engineer' or JobTitle = 'Tool Designer' or JobTitle ='Marketing Assistant'


/*4.Display the Name and Color of the Product with the maximum weight. (Schema(s) involved: Production)*/

SELECT ProductID,Name,Color from Production.Product
WHERE Weight=(SELECT MAX(Weight) from Production.Product)


/* 5.Display Description and MaxQty fields from the SpecialOffer table. Some of the MaxQty values are NULL,
in this case display the value 0.00 instead. (Schema(s) involved: Sales)*/

SELECT Description,ISNULL(MaxQty,0) AS MaxQty
FROM Sales.SpecialOffer



/*6.Display the overall Average of the [CurrencyRate].[AverageRate] values for the exchange
rate ‘USD’ to ‘GBP’ for the year 2005 i.e. FromCurrencyCode = ‘USD’ and ToCurrencyCode = ‘GBP’.
Note: The field [CurrencyRate].[AverageRate] is defined as 'Average exchange rate for the day.' (Schema(s) involved: Sales) */

SELECT AVG(AverageRate*EndOfDayRate) AS 'Overall average'
FROM Sales.CurrencyRate
WHERE FromCurrencyCode = 'USD' AND ToCurrencyCode = 'GBP'  AND YEAR(CurrencyRateDate)='2005'



/*7.	Display the FirstName and LastName of records from the Person table where FirstName contains the letters ‘ss’.
Display an additional column with sequential numbers for each row returned beginning at integer 1. (Schema(s) involved: Person)*/

WITH EmployeeName(FirstName,LastName)
AS
(
     SELECT FirstName,LastName FROM Person.Person WHERE FirstName LIKE '%s%'
)
SELECT ROW_NUMBER() OVER (ORDER BY FirstName) RowNum,FirstName,LastName FROM EmployeeName




/*8.	Sales people receive various commission rates that belong to 1 of 4 bands. (Schema(s) involved: Sales)
Display the [SalesPersonID] with an additional column entitled ‘Commission Band’ indicating the appropriate band as above.*/

SELECT BusinessEntityID AS SalesPersonID,
CASE WHEN CommissionPct = 0 THEN 'Band 0'
WHEN CommissionPct <=0.01  THEN 'Band 1'
WHEN CommissionPct <=0.015  THEN 'Band 2'
else 'Band 3'
END AS ComissionBand
FROM Sales.SalesPerson



/*9.	Display the managerial hierarchy from Ruth Ellerbrock (person type – EM) up to CEO Ken Sanchez. 
Hint: use [uspGetEmployeeManagers] (Schema(s) involved: [Person], [HumanResources])  */

declare @BusinessEntityId int;

select @BusinessEntityId = BusinessEntityID from Person.Person
where FirstName='Ruth' and LastName='Ellerbrock' and PersonType='EM'


exec uspGetEmployeeManagers @BusinessEntityId


/* 10.	Display the ProductId of the product with the largest stock level. Hint: Use the Scalar-valued function [dbo]. [UfnGetStock].
(Schema(s) involved: Production)*/

SELECT ProductID FROM Production.Product
WHERE dbo.ufnGetStock(ProductID)= 
(SELECT MAX(dbo.ufnGetStock(ProductID)) FROM Production.Product);






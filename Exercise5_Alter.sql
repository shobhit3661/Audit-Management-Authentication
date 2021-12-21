/* Alter the above Store Procedure to supply Default Values if user does not enter any value*/

USE [AdventureWorks2008R2]
GO

ALTER PROCEDURE spGetPersonDetailsByFirstName
@FirstName nvarchar(20)='James'
AS
BEGIN
     SELECT FirstName,MiddleName,LastName FROM Person.Person
	 WHERE FirstName=@FirstName
END

--Execute procedure
exec spGetPersonDetailsByFirstName
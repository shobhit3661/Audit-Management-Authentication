/*Write a Procedure supplying name information from the Person.Person table and accepting a filter for the first name.*/

USE [AdventureWorks2008R2]
GO

CREATE PROCEDURE spGetPersonDetailsByFirstName
@FirstName nvarchar(20)
AS
BEGIN
     SELECT FirstName,MiddleName,LastName FROM Person.Person
	 WHERE FirstName=@FirstName
END

--Execute procedure
 exec spGetPersonDetailsByFirstName 'James'
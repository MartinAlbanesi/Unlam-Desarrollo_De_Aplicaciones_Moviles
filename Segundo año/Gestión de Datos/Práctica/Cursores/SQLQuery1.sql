USE AdventureWorks2014
GO

	DECLARE @Description AS nvarchar(400) 
	DECLARE ProdInfo CURSOR FOR SELECT [Description] FROM Production.ProductDescription 
	OPEN ProdInfo
	FETCH NEXT FROM ProdInfo INTO @Description
	WHILE @@fetch_status = 0
	BEGIN
	    PRINT @Description
	    FETCH NEXT FROM ProdInfo INTO @Description
	END
	CLOSE ProdInfo
	DEALLOCATE ProdInfo



DECLARE @Names AS nvarchar (40)
DECLARE pn_cursor CURSOR FOR SELECT [FirstName] FROM Person.Person GROUP BY FirstName ORDER BY FirstName
OPEN pn_cursor
FETCH NEXT FROM pn_cursor INTO @Names
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT @Names
	FETCH NEXT FROM pn_cursor INTO @Names
END
CLOSE pn_cursor
DEALLOCATE pn_cursor



DECLARE @Name VARCHAR(10)
DECLARE personName_Cursor CURSOR SCROLL FOR SELECT [FirstName] FROM Person.Person GROUP BY FirstName ORDER BY FirstName

OPEN personName_Cursor
FETCH ABSOLUTE 2 FROM personName_Cursor INTO @Name
FETCH RELATIVE 3 FROM personName_Cursor INTO @Name
PRINT @Name
CLOSE personName_Cursor
DEALLOCATE personName_Cursor






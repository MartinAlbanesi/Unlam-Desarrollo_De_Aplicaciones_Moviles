USE AdventureWorks2014
SELECT 
	SUBSTRING(ea.EmailAddress, 0, CHARINDEX('@', ea.EmailAddress)) as Nombre,
   	SUBSTRING(ea.EmailAddress, 
              CHARINDEX('@', ea.EmailAddress) + 1, 
              CHARINDEX('.', SUBSTRING(ea.EmailAddress, CHARINDEX('@', ea.EmailAddress)+1, len(ea.EmailAddress))) - 1
             ) AS Dominio
FROM 
	Person.EmailAddress AS ea
JOIN
	Person.Person AS p
ON 
	ea.BusinessEntityID = p.BusinessEntityID;



SELECT 
	LEFT(ea.EmailAddress, CHARINDEX('@', ea.EmailAddress)-1),
   	SUBSTRING(ea.EmailAddress, 
              CHARINDEX('@', ea.EmailAddress) + 1, 
              CHARINDEX('.', SUBSTRING(ea.EmailAddress, CHARINDEX('@', ea.EmailAddress)+1, len(ea.EmailAddress))) - 1
             ) AS Dominio
FROM 
	Person.EmailAddress ea



USE AdventureWorks2014

-- 1. Realizar una consulta que permita devolver la fecha y hora actual
SELECT GETDATE();

-- 2. Realizar una consulta que permita devolver �nicamente el a�o y mes actual:
SELECT CONVERT(VARCHAR(10),GETDATE(),103);
SELECT FORMAT(GETDATE(), 'MMM yyyy');
SELECT YEAR(GETDATE()) a�o, MONTH(GETDATE()) mes;

-- 3. Realizar una consulta que permita saber cu�ntos d�as faltan para el d�a de la primavera (21-Sep)
USE AdventureWorks2014
DECLARE @SecondDate DATE = '2022-09-21'
SELECT DATEDIFF(DAY, GETDATE(), @SecondDate);

-- 4. Realizar una consulta que permita redondear el n�mero 385,86 con �nicamente 1 decimal.
SELECT STR(385.86,5,1);

-- 5. Realizar una consulta permita saber cu�nto es el mes actual al cuadrado. Por ejemplo, si estamos en Junio, ser�a 62
SELECT MONTH(GETDATE()) * MONTH(GETDATE());

-- 6. Devolver cu�l es el usuario que se encuentra conectado a la base de datos
SELECT CURRENT_USER;

-- 7. Realizar una consulta que permita conocer la edad de cada empleado (Ayuda: HumanResources.Employee)
SELECT DATEDIFF(YEAR, e.BirthDate, GETDATE())
FROM HumanResources.Employee e;

-- 8. Realizar una consulta que retorne la longitud de cada apellido de los Contactos, ordenados por apellido. En el caso que se repita el apellido devolver �nicamente uno de ellos
SELECT p.LastName Apellido, LEN(p.LastName) Longitud
FROM Person.Person p
GROUP BY p.LastName;

-- 9. Realizar una consulta que permita encontrar el apellido con mayor longitud. 
SELECT *
FROM Person.Person p
WHERE LEN(p.LastName) = (
		SELECT MAX(LEN(p.LastName))
		FROM Person.Person p);

-- 10. Realizar una consulta que devuelva los nombres y apellidos de los contactos que hayan sido modificados en los �ltimos 3 a�os. 
SELECT p.FirstName, p.LastName
FROM Person.Person p
WHERE DATEDIFF(YEAR, p.ModifiedDate, GETDATE()) <= 3;

-- 11. Se quiere obtener los emails de todos los contactos, pero en may�scula.
SELECT UPPER(p.EmailAddress)
FROM Person.EmailAddress p;

-- 12. Realizar una consulta que permita particionar el mail de cada contacto, obteniendo lo siguiente:
USE AdventureWorks2014
SELECT *
FROM Person.Person p
JOIN Person.EmailAddress ea
ON p.BusinessEntityID = ea.BusinessEntityID;

SELECT p.BusinessEntityID, ea.EmailAddress , LEFT(ea.EmailAddress, CHARINDEX('@', ea.EmailAddress) - 1) AS Nombre  , LEFT(RIGHT(ea.EmailAddress, LEN(ea.EmailAddress) - CHARINDEX('@', ea.EmailAddress)), CHARINDEX('.', RIGHT(ea.EmailAddress, LEN(ea.EmailAddress) - CHARINDEX('@', ea.EmailAddress))) - 1) AS Dominio
FROM Person.Person p
JOIN Person.EmailAddress ea
ON p.BusinessEntityID = ea.BusinessEntityID;

-- 13. Devolver los �ltimos 3 d�gitos del NationalIDNumber de cada empleado
SELECT e.BusinessEntityID ,Right(e.NationalIDNumber,3) 
FROM HumanResources.Employee e
ORDER BY e.BusinessEntityID;

-- 14. Se desea enmascarar el NationalIDNumbre de cada empleado, de la siguiente forma ###-####-##
SELECT FORMAT(CAST(e.NationalIDNumber AS NUMERIC), ' ###-####-##')
FROM HumanResources.Employee e;

-- 15. Listar la direcci�n de cada empleado �supervisor� que haya nacido hace m�s de 30 a�os. Listar todos los datos en may�scula. Los datos a visualizar son: nombre y apellido del empleado, direcci�n y ciudad. 
SELECT UPPER(p.FirstName), UPPER(p.LastName)
FROM HumanResources.Employee e
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID 
WHERE e.JobTitle LIKE '%supervisor%' AND DATEDIFF(YEAR,e.BirthDate,GETDATE()) > 30;

-- 16 Listar la cantidad de empleados hombres y mujeres, de la siguiente forma: .... Nota: Debe decir, Femenino y Masculino de la misma forma que se muestra.
SELECT CASE
			WHEN e.Gender = 'M' THEN 'Masculino'
			WHEN e.Gender = 'F' THEN 'Femenino'
		END AS Sexo
,COUNT(e.Gender)
FROM HumanResources.Employee e
GROUP BY e.Gender

-- 17 Categorizar a los empleados seg�n la cantidad de horas de vacaciones, seg�n el siguiente formato: Alto = m�s de 50 / medio= entre 20 y 50 / bajo = menos de 20
SELECT p.FirstName + ' ' + p.LastName AS Empleado,
CASE
			WHEN e.VacationHours > 50 THEN 'Alto'
			WHEN e.VacationHours >= 20 AND e.VacationHours <= 50 THEN 'Medio'
			WHEN e.VacationHours < 20 THEN 'Bajo'
		END AS Horas
FROM HumanResources.Employee e
JOIN Person.Person p
ON e.BusinessEntityID = p.BusinessEntityID

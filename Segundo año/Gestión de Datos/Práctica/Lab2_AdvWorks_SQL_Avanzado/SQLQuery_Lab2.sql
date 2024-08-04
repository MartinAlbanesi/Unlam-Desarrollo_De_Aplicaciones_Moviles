use AdventureWorks2014;

-- 1
SELECT p.Name, pm.ProductModelID 
FROM Production.Product AS p 
INNER JOIN Production.ProductModel AS pm 
ON p.ProductModelID = pm.ProductModelID;

-- 2
SELECT p.Name, pm.ProductModelID 
FROM Production.Product AS p 
LEFT JOIN Production.ProductModel AS pm 
ON p.ProductModelID = pm.ProductModelID;

-- 3
SELECT p.Name,
	CASE
		WHEN pm.Name IS NULL THEN 'Sin Modelo'
		ELSE pm.Name
	END
FROM Production.Product AS p 
LEFT JOIN Production.ProductModel AS pm 
ON p.ProductModelID = pm.ProductModelID;

-- 4
SELECT pm.Name, COUNT(p.Name) AS totalProducts 
FROM Production.ProductModel AS pm 
LEFT JOIN Production.Product AS p 
ON p.ProductModelID = pm.ProductModelID 
GROUP BY pm.Name;

-- 5 Contar la cantidad de Productos que poseen asignado cada uno de los modelos, pero mostrar solo aquellos modelos que posean asignados 2 o más productos. 
SELECT pm.Name, 
	CASE
		WHEN COUNT(p.Name) > 2 THEN COUNT(p.Name)
	END 
AS totalProducts 
FROM Production.ProductModel AS pm 
LEFT JOIN Production.Product AS p 
ON p.ProductModelID = pm.ProductModelID 
GROUP BY pm.Name;

-- 6 Contar la cantidad de Productos que poseen asignado un modelo valido, es decir, que se encuentre cargado en la tabla de modelos. Realizar este ejercicio de 3 formas posibles: “exists” / “in” / “inner join”. 
SELECT COUNT(p.ProductModelID) AS totalProducts 
FROM Production.Product AS p
WHERE EXISTS 
(SELECT pm.ProductModelID FROM Production.ProductModel pm);

-- 7 Contar cuantos productos poseen asignado cada uno de los modelos, es decir, se quiere visualizar el nombre del modelo y la cantidad de productos asignados. Si algún modelo no posee asignado ningún producto, se quiere visualizar 0 (cero).
SELECT pm.Name, COUNT(p.Name) AS totalProducts 
FROM Production.ProductModel AS pm 
LEFT JOIN Production.Product AS p 
ON p.ProductModelID = pm.ProductModelID 
GROUP BY pm.Name;

-- 8 Se quiere visualizar, el nombre del producto, el nombre modelo que posee asignado, la ilustración que posee asignada y la fecha de última modificación de dicha ilustración y el diagrama que tiene asignado la ilustración. Solo nos interesan los productos que cuesten más de $150 y que posean algún color asignado. 
SELECT p.Name , pm.Name, pmi.IllustrationID, i.ModifiedDate, i.Diagram
FROM Production.Product AS p
INNER JOIN Production.ProductModel AS pm
ON p.ProductModelID = pm.ProductModelID
INNER JOIN Production.ProductModelIllustration AS pmi
ON pm.ProductModelID = pmi.ProductModelID
INNER JOIN Production.Illustration AS i
ON pmi.IllustrationID = i.IllustrationID
WHERE p.ListPrice > 150.0 AND p.Color is not null;

-- 9 Mostrar aquellas culturas que no están asignadas a ningún producto/modelo. (Production.ProductModelProductDescriptionCulture) 
SELECT * 
FROM Production.Culture
WHERE CultureID NOT IN
(SELECT CultureID FROM Production.ProductModelProductDescriptionCulture);

-- 10 Agregar a la base de datos el tipo de contacto “Ejecutivo de Cuentas” (Person.ContactType)
INSERT INTO Person.ContactType (Name)
VALUES ('Ejecutivo de Cuentas');

-- 11 Agregar la cultura llamada “nn” – “Cultura Moderna”. 
INSERT INTO Production.Culture (CultureID,Name)
VALUES('nn','Cultura Moderna');

-- 12 Cambiar la fecha de modificación de las culturas Spanish, French y Thai para indicar que fueron modificadas hoy. 
UPDATE Production.Culture
SET ModifiedDate = CAST(getDate() AS Date)
WHERE Production.Culture.CultureID IN ('es','fr','th');

-- 13 En la tabla Production.CultureHis agregar todas las culturas que fueron modificadas hoy. (Insert/Select). 
CREATE TABLE Production.CultureHis (
	CultureID varchar(2),
	Name varchar(255),
	ModifiedDate datetime
);

INSERT INTO Production.CultureHis 
SELECT c.CultureID, c.Name, c.ModifiedDate 
FROM Production.Culture c 
WHERE c.ModifiedDate = CAST(getDate() AS Date);

-- 14 Al contacto con ID 10 colocarle como nombre “Juan Perez”.
UPDATE Person.Person
SET Person.Person.FirstName = 'Juan', Person.Person.LastName = 'Perez'
WHERE Person.Person.BusinessEntityID = 10;

-- 15 Agregar la moneda “Peso Argentino” con el código “PAR” (Sales.Currency)
SELECT * FROM Sales.Currency
INSERT INTO Sales.Currency (CurrencyCode,Name)
VALUES ('PAR','Peso Argentino');

-- 16 ¿Qué sucede si tratamos de eliminar el código ARS correspondiente al Peso Argentino? ¿Por qué?
DELETE FROM Sales.Currency WHERE Sales.Currency.CurrencyCode = 'ARS';
-- El registro a eliminar está presente como una FK en la tabla Sales.CountryRegionCurrency



-- 17 Realice los borrados necesarios para que nos permita eliminar el registro de la moneda con código ARS. 
SELECT * FROM Sales.CountryRegionCurrency
DELETE FROM Sales.CountryRegionCurrency WHERE Sales.CountryRegionCurrency.CurrencyCode = 'ARS'
DELETE FROM Sales.CurrencyRate WHERE Sales.CurrencyRate.FromCurrencyCode = 'ARS' OR Sales.CurrencyRate.ToCurrencyCode = 'ARS';

-- 18 Eliminar aquellas culturas que no estén asignadas a ningún producto (Production.ProductModelProductDescriptionCulture)
DELETE FROM Production.Culture 
WHERE CultureID IN (
	SELECT c.CultureID
	FROM Production.Culture c
	WHERE c.CultureID NOT IN (SELECT CultureID FROM Production.ProductModelProductDescriptionCulture
	)
);
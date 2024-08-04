USE AdventureWorks2014
-- 1
SELECT Product.ProductID, Product.Name FROM Production.Product

-- 2
SELECT * FROM Production.ProductSubcategory WHERE ProductSubcategoryID = 17

-- 3
SELECT * FROM Production.Product WHERE Product.Name LIKE 'D%'

-- 4
SELECT Product.Name FROM Production.Product WHERE Product.Name LIKE '%8'

-- 5
SELECT * FROM Production.Product WHERE Product.Color is not null

-- 6
SELECT Product.ProductID, Product.Name FROM Production.Product WHERE Product.Color = 'Black' AND Product.SafetyStockLevel = 500

-- 7
SELECT * FROM Production.Product WHERE Product.Color = 'Black' OR Product.Color = 'Silver'

-- 8
SELECT DISTINCT Product.Color FROM Production.Product

-- 9
SELECT COUNT(*) AS totalProductCategories FROM Production.ProductCategory

-- 10
SELECT COUNT(*) AS totalSubcategoryByCategoryID FROM Production.ProductSubcategory WHERE ProductSubcategory.ProductCategoryID = 2

-- 11
SELECT DISTINCT Product.Color, COUNT(Production.Product.Color) AS totalProductsByColor FROM Production.Product GROUP BY Product.Color

-- 12
SELECT SUM(Product.SafetyStockLevel) AS totalSafetyStockLevel FROM Production.Product WHERE Product.Color = 'Black'

-- 13
SELECT AVG(Product.SafetyStockLevel) AS avgSafetyStockLevel FROM Production.Product WHERE Product.ProductID BETWEEN 316 AND 320

-- 14
SELECT p.Name, sc.Name FROM Production.Product AS p INNER JOIN Production.ProductSubcategory AS sc ON p.ProductID = sc.ProductCategoryID

-- 15
SELECT * FROM Production.ProductCategory AS c INNER JOIN Production.ProductSubcategory AS sc ON c.ProductCategoryID = sc.ProductCategoryID

-- 16
SELECT p.ProductID, p.Name FROM Production.Product AS p INNER JOIN Production.ProductProductPhoto AS ppp ON p.ProductID = ppp.ProductID INNER JOIN Production.ProductPhoto AS pp ON pp.ProductPhotoID = ppp.ProductPhotoID

-- 17
SELECT p.Class, COUNT(*) FROM Production.Product AS p GROUP BY Class

-- 18
SELECT p.Name,
	CASE
		WHEN p.Color = 'Black' OR p.Color = 'Silver' THEN p.Color
		ELSE 'Other'
	END
FROM Production.Product AS p 

-- 19
SELECT c.Name, sc.Name, p.Name FROM Production.Product AS p JOIN Production.ProductSubcategory AS sc ON p.ProductSubcategoryID = sc.ProductSubcategoryID JOIN Production.ProductCategory AS c ON c.ProductCategoryID = sc.ProductCategoryID

-- 20
SELECT DISTINCT p.ProductSubcategoryID, COUNT(p.ProductID) AS totalProducts FROM Production.Product AS p GROUP BY p.ProductSubcategoryID

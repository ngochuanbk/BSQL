USE	AdventureWorks2012
GO
-----Exercise 1: Querying and Filtering Data
-----Question 1.--------

SELECT ProductID, Name, Color, ListPrice
FROM	Production.Product

-----Question 2.--------

SELECT ProductID, Name, Color, ListPrice
FROM	Production.Product
WHERE	ListPrice > 0

-----Question 3.--------

SELECT ProductID, Name, Color, ListPrice
FROM	Production.Product
WHERE Color IS NULL

-----Question 4.--------

SELECT ProductID, Name, Color, ListPrice
FROM	Production.Product
WHERE Color IS NOT NULL

-----Question 5.--------

SELECT ProductID, Name, Color, ListPrice
FROM	Production.Product
WHERE Color IS NOT NULL
AND ListPrice > 0

-----Question 6.--------

SELECT Name + ' : ' + Color AS	'Name And Color'
FROM	Production.Product
WHERE Color IS NOT NULL

-----Question 7.--------

SELECT Name + ' -- COLOR: ' + Color AS	'Name And Color'
FROM	Production.Product
WHERE Color IS NOT NULL

-----Question 8.--------

SELECT ProductID, Name
FROM Production.Product
WHERE	ProductID BETWEEN 400 AND 500

-----Question 9.--------

SELECT ProductID, Name, Color
FROM Production.Product
WHERE	Color IN ('Black', 'Blue')

-----Question 10.--------

SELECT Name, ListPrice
FROM Production.Product
WHERE	Name LIKE 's%'
ORDER BY Name

-----Question 11.--------

SELECT Name, ListPrice
FROM Production.Product
WHERE	Name LIKE '[sa]%'
ORDER BY Name

-----Question 12.--------

SELECT Name, ListPrice
FROM Production.Product
WHERE	Name LIKE 'spo[^k]%'
ORDER BY Name

-----Question 13.--------

SELECT DISTINCT Color
FROM Production.Product

-----Question 14.--------

SELECT	DISTINCT ProductSubcategoryID, Color
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
AND	Color IS NOT NULL
ORDER BY ProductSubcategoryID ASC, Color DESC

-----Question 15.--------

SELECT ProductSubCategoryID
      , LEFT([Name],35) AS [Name]
      , Color, ListPrice
FROM Production.Product
WHERE Color IN ('Red','Black')
	  AND ProductSubCategoryID = 1
      OR ListPrice BETWEEN 1000 AND 2000     
ORDER BY ProductID

-----Question 16.--------

SELECT  Name, ISNULL(Color, 'Unknown') AS Color, ListPrice
FROM Production.Product


-----Exercise 2: Grouping and Summarizing Data
-----Question 1.--------

SELECT COUNT(*) FROM Production.Product

-----Question 2.--------

SELECT COUNT(ProductSubcategoryID) AS HasSubCategoryID
FROM Production.Product

-----Question 3.--------

SELECT ProductSubcategoryID, COUNT(Name) AS CountedProducts
FROM Production.Product
GROUP BY ProductSubcategoryID

-----Question 4.--------
--Query 1--
SELECT	COUNT(*) - COUNT(ProductSubcategoryID)
FROM	Production.Product

--Query 2--
SELECT	COUNT(*) AS	NoSubCat
FROM	Production.Product
WHERE	ProductSubcategoryID IS NULL

-----Question 5.--------

SELECT	ProductID, SUM(Quantity) AS	TheSum
FROM	Production.ProductInventory
GROUP	BY	ProductID

-----Question 6.--------

SELECT	ProductID, SUM(Quantity) AS	TheSum
FROM	Production.ProductInventory
WHERE	LocationID = 40
GROUP	BY	ProductID
HAVING SUM(Quantity) < 100

-----Question 7.--------

SELECT	Shelf, ProductID, SUM(Quantity) AS	TheSum
FROM	Production.ProductInventory
WHERE	LocationID = 40
GROUP BY ProductID, Shelf
HAVING SUM(Quantity) < 100

-----Question 8.--------

SELECT AVG(Quantity) AS	TheAvg
FROM	Production.ProductInventory
WHERE	LocationID = 10

-----Question 9.--------

SELECT ProductID, Shelf, AVG(Quantity) AS TheAvg
FROM	Production.ProductInventory
WHERE	LocationID = 10 
AND		Shelf <> 'N/A'
GROUP BY ROLLUP (Shelf, ProductID)
ORDER BY Shelf

-----Question 10.--------

SELECT Color, Class, COUNT(*) AS TheCount, AVG(ListPrice) AS AvgPrice
FROM	Production.Product
WHERE	Class IS NOT NULL
AND		Color IS NOT NULL
GROUP BY GROUPING SETS ((Color), (Class))

-----Question 11.--------

SELECT ProductSubcategoryID, COUNT(Name) AS	 Counted,
		GROUPING(ProductSubcategoryID) AS	IsGrandTotal
FROM	Production.Product
GROUP BY ROLLUP (ProductSubcategoryID)
ORDER BY ProductSubcategoryID
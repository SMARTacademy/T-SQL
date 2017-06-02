--Сколько экземпляров каждой книги было продано? Решите задачу двумя способами.
SELECT title_id, title, 
(
	SELECT SUM(qty)
	FROM sales
	WHERE title_id = titles.title_id
)
FROM titles

SELECT t.title_id, MAX(title), SUM(qty)
FROM titles t INNER JOIN sales s
ON t.title_id = s.title_id
GROUP BY t.title_id


--Сколько денег потрачено на каждый товар? Решите задачу двумя способами.
SELECT ProductID, ProductName, 
(
	SELECT SUM(UnitPrice*(1 - Discount)*Quantity) 
	FROM [Order Details]
	WHERE ProductID = Products.ProductID
)
FROM Products

SELECT p.ProductID, MAX(p.ProductName), SUM(od.UnitPrice*(1 - od.Discount)*od.Quantity)
FROM Products p INNER JOIN [Order Details] od
ON p.ProductID = od.ProductID
GROUP BY p.ProductID
ORDER BY p.ProductID

--Сколько заказов сделал каждый покупатель в январе 1997? Решите задачу двумя способами.
SELECT * FROM (
SELECT CustomerID, ContactName, 
(
	SELECT COUNT(OrderID)
	FROM Orders
	WHERE CustomerID = Customers.CustomerID AND
	YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 1
) AS Total
FROM Customers ) AS NewTbl
WHERE Total <> '0'

SELECT cust.CustomerID, MAX(cust.ContactName), COUNT(ord.OrderID)
FROM Customers cust INNER JOIN Orders ord
ON cust.CustomerID = ord.CustomerID
WHERE YEAR(ord.OrderDate) = 1997 AND MONTH(ord.OrderDate) = 1
GROUP BY cust.CustomerID


--Сколько заказов сделал каждый покупатель в январе 1997? 
SELECT cust.CustomerID, MAX(cust.ContactName), COUNT(ord.OrderID)
FROM Customers cust LEFT JOIN Orders ord
ON cust.CustomerID = ord.CustomerID AND
YEAR(ord.OrderDate) = 1997 AND MONTH(ord.OrderDate) = 1
GROUP BY cust.CustomerID

--Сколько денег потратили австрийцы на каждый товар? Решите задачу двумя способами.
SELECT ProductID, ProductName, 
(
	SELECT SUM(UnitPrice*(1 - Discount)*Quantity)
	FROM [Order Details]
	WHERE OrderID IN 
	(
		SELECT OrderID
		FROM Orders
		WHERE ShipCountry = 'Austria'
	) AND ProductID = Products.ProductID
) 
FROM Products

SELECT au_id, au_lname, au_fname, city
FROM authors
WHERE city IN (SELECT city
				FROM publishers)
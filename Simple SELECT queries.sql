--Необходимо разослать письма авторам – покажите адреса авторов
--Столбцы результирующего набора данных: почтовый индекс, адрес, полное имя
select au_fname + ' ' + au_lname AS FullName, address, zip from authors

--Покажите заказы сделанные весной 97 года.Решите задачу четырьмя способами.
select * from Orders where OrderDate >= '1997-03-01' AND OrderDate < '1997-06-01'

select * from Orders where OrderDate BETWEEN '1997-03-01' AND '1997-06-01'

select * from Orders 
where Year(OrderDate) = 1997 AND MONTH(OrderDate) BETWEEN '3' AND '5'

select * from Orders
where OrderDate BETWEEN '1997-03-01' AND DATEADD(month, 3, '1997-03-01')

--Покажите покупателей (таблица Customers) из Франции, у которых есть факс
select * from Customers where Country = 'France' AND Fax IS NOT NULL

--В каких городах живут покупатели имеющие факс?
select city from customers where Fax IS NOT NULL

--В каких странах есть покупатели без факса?
select country from Customers where Fax IS NULL

--Найдите самую дешевую книгу по бизнесу.Решите задачу двумя способами.
select TOP(1) title, price from titles where type='business' order by price

select MIN(price) from titles where type='business'

--В какую страну был отгружен первый заказ осенью 97 года?
select TOP(1) WITH TIES ShipCountry, OrderDate from Orders
where YEAR(OrderDate) = 1997 order by OrderDate 

--Каких покупателей больше, с факсом или без?
select COUNT(Fax) AS S, COUNT(*) - COUNT(Fax) AS BEZ FROM Customers

--Сколько в среднем стоит книга по психологии? 
select avg(price) from titles where type='psychology' 

--Сколько стоит самая дорогая/дешевая книга по психологии?
select max(price), min(price) from titles where type='psychology'

--Сколько покупателей живет в каждой стране?
select Country, Count(CustomerID) 
from Customers 
group by country

--Отобразите количество разных городов в каждой стране?
select Country, COUNT(DISTINCT City) AS UniqCities
from Customers
group by Country

--Сколько заказов сделано в каждом году?
select YEAR(OrderDate), COUNT(OrderID)
from Orders
group by YEAR(OrderDate)

--В каком году было сделано больше всего заказов?
select TOP(1) WITH TIES YEAR(OrderDate), COUNT(OrderID)
from Orders
group by YEAR(OrderDate)
order by COUNT(OrderID) DESC

--В какой категории самая дорогая книга?
select TOP(1) type, MAX(price)
from titles
group by type
order by MAX(price) DESC

--Какой продавец в 1997 году сделал больше всего заказов одному покупателю?
select TOP(1) EmployeeID, CustomerID, COUNT(OrderID)
from Orders
where YEAR(OrderDate) = 1997
group by EmployeeID, CustomerID
order by COUNT(OrderID) DESC

--В какой стране в течение месяца было обслужено самое большое кол-во покупателей?
select TOP(1) WITH TIES ShipCountry, COUNT(OrderID)
from Orders
group by ShipCountry, YEAR(OrderDate), MONTH(OrderDate)
order by COUNT(OrderID) DESC 

--В каких городах проживает больше 5-и клиентов?
select city, COUNT(CustomerID)
from Customers
group by city
having COUNT(CustomerID) > 5

--Сколько денег было заплачено за каждый заказ?
select OrderID, SUM(UnitPrice * Quantity) AS FullPrice, 
Sum(1 - Discount) AS FullDiscount, 
SUM(UnitPrice*(1 - Discount) * Quantity) AS OrderPrice  
from [Order Details]
group by OrderID

/*select *
from [Order Details]*/

--На каких товарах компания заработала более 10 000?
select ProductID, SUM(UnitPrice*(1 - Discount) * Quantity) AS ProductSellment
from [Order Details]
group by ProductID
having SUM((UnitPrice - Discount) * Quantity) > 10000

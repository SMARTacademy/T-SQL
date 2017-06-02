--В какие немецкие города в 1997 году было продано больше одного заказа?
select ShipCity, Count(OrderID)
from orders
where ShipCountry = 'Germany' AND Year(OrderDate) = 1997
group by ShipCity
having Count(OrderID) > 1

--Создать нового автора: 
--Имя: Greeen
--Фамилия: Ann
--Город: Gary
--Штат: IN

--Обновить у созданного автора Город

--Удалить созданного автора
Insert into authors (au_id, au_lname, au_fname, city, [state, [contract])
values ('444-22-1156', 'Green', 'Ann', 'Gary', 'IN', 1);

select * from authors

Update authors set city = 'Kiev' WHERE au_id = '444-22-1156';

delete from authors where au_id = '444-22-1156'

-- examples
select title, price from pubs..titles
UNION
select ProductName, UnitPrice from Northwind..Products
select City from Employees
UNION ALL
select City from Customers

select City from Employees
INTERSECT
select City from Customers

select City from Employees
EXCEPT
select City from Customers

select City from Customers
EXCEPT
select City from Employees
-- no correlation
select FirstName, LastName, (SELECT COUNT(*) from Orders)
from Employees
-- with correlation
select FirstName, LastName, (SELECT COUNT(*) from Orders
							WHERE EmployeeID = Employees.EmployeeID)
from Employees





 
 
 

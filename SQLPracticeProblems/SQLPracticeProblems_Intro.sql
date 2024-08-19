--1 
select * from shippers

--2
select c.CategoryName,
c.Description 
from Categories c

--3
select e.FirstName,
e.LastName,
e.HireDate
from Employees e
where e.Title = 'Sales Representative'

--4
select e.FirstName,
e.LastName,
e.HireDate
from Employees e
where e.Title = 'Sales Representative'
and e.Country = 'USA'

--5
select o.OrderId, 
o.OrderDate
from orders o
where o.EmployeeID = 5

--6
select s.SupplierId,
s.ContactName,
s.ContactTitle
from suppliers s
where s.ContactTitle not in ('Marketing Manager')

--7
select p.ProductId,
p.ProductName
from products p
where p.ProductName like '%queso%'

--8
select o.OrderID,
o.CustomerID,
o.ShipCountry
from orders o
where o.ShipCountry in ('France', 'Belgium')

--9
select o.OrderID,
o.CustomerID,
o.ShipCountry
from orders o
where o.ShipCountry in ('Brazil', 'Mexico', 'Argentina', 'Venezuela')

--10
select e.FirstName,
e.LastName,
e.Title,
e.BirthDate
from Employees e
order by e.BirthDate 

--11
select e.FirstName,
e.LastName,
e.Title,
convert(date, e.BirthDate, 31) as DateOnlyBirthDate
from Employees e
order by e.BirthDate

--12
select e.FirstName,
e.LastName,
concat(e.FirstName, ' ', e.LastName) as FullName
from Employees e
order by e.BirthDate 

--13
select od.OrderId,
od.ProductId,
od.UnitPrice, 
od.Quantity,
(od.UnitPrice * od.Quantity) as TotalPrice
from orderdetails od
order by od.OrderId, od.ProductId

--14
select count(*) as TotalCustomers
from customers c

--15
select top 1 o.OrderDate as FirstOrder
from orders o 
order by o.OrderDate

select min(o.OrderDate) as FirstOrder
from orders o

--16
select distinct c.Country
from customers c 
group by Country

--17
select c.ContactTitle,
count(c.ContactTitle) as TotalContactTitle
from customers c 
group by ContactTitle
order by TotalContactTitle desc

--18 
select p.ProductId,
p.ProductName, 
s.CompanyName as SupplierName
from products p
join suppliers s on s.SupplierID = p.SupplierID

--19
select o.OrderID,
convert(date, o.OrderDate, 31) as Orderdate,
s.CompanyName as Shipper
from orders o
join shippers s on s.ShipperID = o.ShipVia
where o.OrderId < 10270
--20
select c.CategoryName,
count(*) as TotalProducts
from products p
join Categories c on c.CategoryID = p.CategoryID
group by CategoryName
order by TotalProducts desc

--21
select c.Country, 
c.City,
count(*) as TotalCustomers
from customers c
group by Country, City
order by TotalCustomers desc

--22
select p.ProductId,
p.ProductName, 
p.UnitsInStock,
p.ReorderLevel
from products p
where p.UnitsInStock <= p.ReorderLevel

--23
select p.ProductId,
p.ProductName, 
p.UnitsInStock,
p.UnitsOnOrder,
p.ReorderLevel,
p.Discontinued
from products p
where (p.UnitsInStock + p.UnitsOnOrder) <= p.ReorderLevel
and p.Discontinued = 0

--24
select c.CustomerId,
c.CompanyName,
c.Region
from customers c
order by iif(c.Region is null, 1, 0), 
c.Region, 
c.CustomerID

--25
select top 3 o.ShipCountry,
AverageFreight = avg(o.Freight)
from orders o 
group by ShipCountry
order by AverageFreight desc

--26
select top 3 o.ShipCountry,
AverageFreight = avg(o.Freight)
from orders o 
where year(o.orderdate) = 2015
group by ShipCountry
order by AverageFreight desc

--27
--28

--29
select e.EmployeeID,
e.LastName,
o.OrderID,
p.ProductName,
od.Quantity
from Employees e 
join orders o on o.EmployeeID = e.EmployeeID
join OrderDetails od on od.OrderID = o.OrderID
join Products p on p.ProductID = od.ProductID

--30
select Customers_CustomerId = c.CustomerId,
Orders_CustomerId = o.CustomerID
from customers c 
left join orders o on o.CustomerID = c.CustomerID
where o.CustomerId is null
order by c.CustomerID

--31
select Customers_CustomerId = c.CustomerId,
Orders_CustomerId = o.CustomerID
from customers c 
left join orders o on o.CustomerID = c.CustomerID
and o.EmployeeID = 4
where o.CustomerId is null
order by c.CustomerID


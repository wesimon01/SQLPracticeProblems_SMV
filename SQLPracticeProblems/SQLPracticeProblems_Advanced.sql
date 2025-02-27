--32
select c.CustomerId,
c.CompanyName,
o.OrderId,
TotalOrderAmount = sum(unitprice * quantity)
from customers c
join orders o on o.CustomerID = c.CustomerId
join OrderDetails od on od.OrderID = o.orderId
where year(OrderDate) = 2016
group by c.CustomerId, CompanyName, o.OrderId
having sum(unitprice * quantity) > 10000
order by TotalOrderAmount desc

--33
select c.CustomerId,
c.CompanyName,
TotalOrderAmount = sum(unitprice * quantity)
from customers c
join orders o on o.CustomerID = c.CustomerId
join OrderDetails od on od.OrderID = o.orderId
where year(OrderDate) = 2016
group by c.CustomerId, CompanyName
having sum(unitprice * quantity) >= 15000
order by TotalOrderAmount desc

--34
select c.CustomerId,
c.CompanyName,
TotalOrderAmountNoDiscount = sum(unitprice * quantity),
TotalOrderAmountWithDiscount = sum((unitprice - (unitprice * discount)) * quantity)
from customers c
join orders o on o.CustomerID = c.CustomerId
join OrderDetails od on od.OrderID = o.orderId
where year(OrderDate) = 2016
group by c.CustomerId, CompanyName
having sum((unitprice - (unitprice * discount)) * quantity) >= 15000
order by TotalOrderAmountWithDiscount desc

--35

--36
select top 10 with ties 
o.OrderId,
count(*) as TotalOrderDetails
from orders o
join orderdetails od on o.OrderID = od.OrderID
group by o.OrderId
order by TotalOrderDetails desc

--37
select top 2 percent orderid
from orders
order by NewId()

--38
select od.OrderId
from OrderDetails od
where od.Quantity >= 60
group By od.OrderID, od.Quantity
having count(*) > 1
order by od.OrderID

--39
with PotentialDuplicates as 
(
select od.OrderId
From OrderDetails od
Where od.Quantity >= 60
group By od.OrderID, od.Quantity
having count(*) > 1
)

select 
od.OrderID,
od.ProductID,
od.UnitPrice,
od.Quantity,
od.Discount
from OrderDetails od
where od.OrderId in (select OrderId from PotentialDuplicates)
order by od.OrderId, od.Quantity

--40

--41
select o.OrderId,
o.OrderDate,
convert(date, o.RequiredDate, 31) as RequiredDate,
convert(date, o.ShippedDate, 31) as ShippedDate
from orders o
where o.ShippedDate >= RequiredDate
order by o.OrderID

--42 
select e.EmployeeID,
e.LastName,
TotalLateOrders = count(*)
from employees e 
join orders o on o.EmployeeID = e.EmployeeId
where o.ShippedDate >= o.RequiredDate
group by e.EmployeeId, e.LastName
order by TotalLateOrders desc

--43


--55
with CTE_FirstOrderForCountry as (
select
o.ShipCountry,
o.CustomerID,
o.OrderId,
OrderDate = convert(date, o.orderdate),
RowNumberPerCountry = ROW_NUMBER() over (partition by ShipCountry order by ShipCountry, OrderId)
from orders o
)

select
ShipCountry,
CustomerId,
OrderId, 
OrderDate
from CTE_FirstOrderForCountry
where RowNumberPerCountry = 1
order by ShipCountry
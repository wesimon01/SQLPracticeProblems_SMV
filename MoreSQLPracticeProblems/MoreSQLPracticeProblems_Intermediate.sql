
--1
select ch.ProductId,
TotalPriceChanges = count(*)
from productcosthistory ch
group by ch.ProductID
order by ch.ProductID

--2
select c.CustomerID,
TotalOrders = count(*)
from SalesOrderHeader oh
join Customer c on oh.CustomerID = c.CustomerId
group by c.CustomerID
order by TotalOrders desc

--3
select p.ProductID,
FirstOrder = convert(date, min(soh.OrderDate)),
LastOrder = convert(date, max(soh.OrderDate))
from product p
join salesorderdetail sod on sod.ProductID = p.ProductID
join SalesOrderHeader soh on soh.SalesOrderID = sod.SalesOrderID
group by p.ProductID
order by p.ProductId

--4
select p.ProductID,
p.ProductName,
FirstOrder = convert(date, min(soh.OrderDate)),
LastOrder = convert(date, max(soh.OrderDate))
from product p
join salesorderdetail sod on sod.ProductID = p.ProductID
join SalesOrderHeader soh on soh.SalesOrderID = sod.SalesOrderID
group by p.ProductID, p.ProductName
order by p.ProductId

--5
select ch.ProductID,
ch.StandardCost
from ProductCostHistory ch
where '2012-04-15' between ch.StartDate and ch.EndDate
order by ch.ProductID

--6
select ch.ProductID,
ch.StandardCost
from ProductCostHistory ch
where '2014-04-15' between ch.StartDate and IsNull(ch.EndDate, getdate())
order by ch.ProductID

--7
select format(StartDate, 'yyyy/MM') as ProductListPriceMonth,
count(*) as TotalRows
from ProductListPriceHistory ph 
group by format(StartDate, 'yyyy/MM')

--8
--9
select ph.ProductId,
ph.ListPrice
from ProductListPriceHistory ph
where ph.EndDate is null 
or ph.EndDate > getdate()

--10
select p.ProductId,
p.ProductName
from Product p
left join ProductListPriceHistory ph on ph.ProductID = p.ProductID
where ph.ListPrice is null
order by p.ProductId

--11
--12
select ph.ProductId
from ProductListPriceHistory ph 
where Enddate is null or EndDate > getdate()
group by ph.ProductID
having count(*) > 1



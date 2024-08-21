
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
where Enddate is null 
or EndDate > getdate()
group by ph.ProductID
having count(*) > 1

--13
select p.ProductID,
p.ProductName,
FirstOrder = convert(date, min(soh.OrderDate)),
LastOrder = convert(date, max(soh.OrderDate))
from product p
left join ProductSubcategory sub on sub.ProductSubcategoryID = p.ProductSubcategoryID
left join salesorderdetail sod on sod.ProductID = p.ProductID
left join SalesOrderHeader soh on soh.SalesOrderID = sod.SalesOrderID
group by p.ProductID, p.ProductName
order by p.ProductName

--14
select p.ProductId,
p.ProductName,
p.ListPrice as Prod_ListPrice,
ph.ListPrice as PriceHist_LastestListPrice,
Diff = abs(p.ListPrice - ph.ListPrice)
from product p 
join ProductListPriceHistory ph on ph.ProductID = p.ProductID
where (ph.EndDate is null or ph.EndDate > getdate())
and ph.ListPrice <> p.ListPrice
and abs(p.ListPrice - ph.ListPrice) > 0
order by p.ProductId

--15
select p.ProductId,
OrderDate = convert(date, soh.Orderdate),
p.ProductName,
sod.OrderQty,
SellStartDate = convert(date, p.SellStartDate),
SellEndDate = convert(date, p.SellEndDate)
from product p
join salesorderdetail sod on sod.ProductID = p.ProductId
join salesorderheader soh on soh.SalesOrderID = sod.SalesOrderID 
where Orderdate not between SellStartDate and SellEndDate
order by p.ProductId, soh.OrderDate

--16
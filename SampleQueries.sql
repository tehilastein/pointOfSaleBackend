use DatabaseProject
go 

--1.
select CustomerFirstName +' '+CustomerLastName as CustName,
CustomerStreet+' '+CustomerCity+' '+CustomerState+' '+CustomerZip as Address,
CustomerPhoneNumber
from CUSTOMER

--2.
select CategoryDesc, isnull(sum(QtySold*UnitPrice),0.0) as SalesGenerated
from ITEM
right outer join ITEM_CATEGORY on Item.ItemCategory = ITEM_CATEGORY.CategoryID
left outer join SALESORDER_DETAILS on SALESORDER_DETAILS.UPC 
= ITEM.UPC
group by CategoryDesc

--3.
select SalesOrder_details.UPC, ItemName, sum(UnitPrice * QtySold) - (select sum(subtotal) 
from ORDER_LINE where UPC = SALESORDER_DETAILS.UPC) as ItemIncome
from SALESORDER_DETAILS
inner join ITEM on ITEM.UPC = SALESORDER_DETAILS.UPC
group by SALESORDER_DETAILS.UPC,ItemName

--4.
select ITEM.UPC, ItemName,VendorName, count(DISCOUNT_ITEM.UPC) as TimesDiscounted
from ITEM
left outer join DISCOUNT_ITEM on ITEM.UPC = DISCOUNT_ITEM.UPC
inner join Vendor on Vendor.VendorID = Item.vendorID
group by ItemName, ITEM.UPC, VendorName

--5.
select ItemName
from ITEM
inner join DISCOUNT_ITEM on Item.Upc = DISCOUNT_ITEM.Upc
where SaleDateID = (
select SaleDateID
from SALE_DATE
where '2020-01-12' between beginDate and EndDate)

--6.
select ItemName
from ITEM
inner join SALESORDER_DETAILS on SALESORDER_DETAILS.UPC = ITEM.UPC
group by ItemName
having count(*) = (select max(ItemsOrdered.TimesOrdered)
from
(select count(*) as TimesOrdered from SALESORDER_DETAILS
group by UPC) as ItemsOrdered)

--7. 
select EmployeeFirstName+' '+EmployeeLastName as CashierName
from EMPLOYEE
inner join SALES_ORDER on SALES_ORDER.CashierID = Employee.EmployeeID
group by EmployeeFirstName+ ' '+EmployeeLastName
having sum(Subtotal) = (select max(Cashiers.Totals)
from 
(select sum(subtotal) as Totals from SALES_ORDER
group by CashierID) as Cashiers)

--8.
select Vendor.VendorID, VendorName, count(*) as ItemsSupplied
from Vendor
left outer join ITEM on ITEM.VendorID = Vendor.VendorID
group by Vendor.VendorID, VendorName

--9.
select distinct ITEM.UPC, ItemName, VendorName
from Item
inner join VENDOR on VENDOR.VendorID = ITEM.VendorID
where ItemQty<ReorderLevel

--10.
select ItemName
from Item 
where ItemPrice = (select max(ITEMPRICE) from ITEM)

--11.
select EBT_ID,CustomerFirstName+' '+CustomerLastName as CustName, EBT_Balance, max(SaleDate) as MostRecentUse
from CUSTOMER
inner join CUSTOMER_EBT on Customer.CustomerID = CUSTOMER_EBT.CustomerID
inner join SALES_ORDER on Customer.CustomerID = SALES_ORDER.CustomerID
inner join Payment on Payment.SalesOrderID = SALES_ORDER.SalesOrderNum
group by EBT_ID,CustomerFirstName+' '+CustomerLastName, EBT_Balance


--12.
select CustomerFirstName+' '+CustomerLastName as Name, Customer.CustomerID
from sales_order
inner join Customer on Customer.CustomerID = Sales_Order.CustomerID
group by Customer.customerID, CustomerFirstName+' '+CustomerLastName having count(*) = (select max(Customers.NumOrders)
from
(select count(*) as NumOrders
from SALES_ORDER
group by CustomerID) as Customers)

--13. 
select ItemCategory
from item
inner join SALESORDER_DETAILS on SALESORDER_DETAILS.UPC = item.UPC
group by ItemCategory having sum(QtySold * UnitPrice) =
(select max(Sub.total)
 from
(select sum(qtySold * unitPrice) as total
from SALESORDER_DETAILS
inner join ITEM on SALESORDER_DETAILS.UPC  = ITEM.UPC
group by ItemCategory)as Sub)

--14.
select ITEM.VendorID, VendorName, ItemName
from Vendor
inner join ITEM on ITEM.VENDORID = VENDOR.VendorID

--15.
select SalesOrderNum
from SALES_ORDER
where CustomerID is null

--16.
select VendorName
from Vendor
where VendorID not in
(select VendorID
from PURCHASE_ORDER
group by VendorID
having datediff(month,max(OrderDate),getdate())<1)

--17.
select CustomerFirstName+' '+CustomerLastName as CustomerName
from Customer
where CustomerID not in
(select CustomerID
from SALES_ORDER
where CustomerID is not null
group by CustomerID
having datediff(day,max(SaleDate),getdate()) < 30)

--18.
select customer.CustomerFirstName+' '+CUSTOMER.CustomerLastName
from customer
inner join SALES_ORDER on  SALES_ORDER.CustomerID = customer.CustomerID 
inner join SALESORDER_DETAILS on SALESORDER_DETAILS.SalesOrderID = SALES_ORDER.SalesOrderNum
inner join item on item.UPC = SALESORDER_DETAILS.UPC
inner join ITEM_CATEGORY on ITEM_CATEGORY.CategoryID = item.ItemCategory
where CategoryDesc = 'Meat'
intersect
select customer.CustomerFirstName+' '+CUSTOMER.CustomerLastName as CustName
from customer
inner join SALES_ORDER on  SALES_ORDER.CustomerID = customer.CustomerID
inner join SALESORDER_DETAILS on SALESORDER_DETAILS.SalesOrderID = SALES_ORDER.SalesOrderNum
inner join item on item.UPC = SALESORDER_DETAILS.UPC
inner join ITEM_CATEGORY on ITEM_CATEGORY.CategoryID = item.ItemCategory
where CategoryDesc = 'Fish'

--19.
select VendorID
from Vendor V1
where not exists
(select ItemCategory,VendorID
from Item I1
where VendorID = 100 and I1.ItemCategory
not in (select ItemCategory
from Item
where VendorID = V1.VendorID))

--20.
select ItemName, count(Customer_Return.UPC) as TimesReturned
from Item
inner join SALESORDER_DETAILS on SALESORDER_DETAILS.UPC = Item.UPC
left outer join CUSTOMER_RETURN on CUSTOMER_RETURN.UPC = Item.UPC
group by ItemName

--21.
select sum(TotalFood) as TotalFood, 
(select sum(PaymentAmount) from Payment
where PaymentMethodID in (2,5)) as TotalEBT,
(select sum(TotalFood) from Sales_Order) - 
(select sum(PaymentAmount) from Payment
where PaymentMethodID in (2,5)) as TotalOthers
from SALES_ORDER


--THIS IS THE QUERY WE WOULD SUGGEST FOR A RECEIPT
select * from SALES_ORDER
where SalesOrderNum = 10
select *
from SALESORDER_DETAILS where SalesOrderID = 10












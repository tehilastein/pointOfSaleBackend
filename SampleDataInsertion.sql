--How data would be put in to our database: 

-- an item
insert into item(upc,itemName,itemPrice,ItemCategory,Taxable, FoodItem, ItemQty,ReorderLevel,vendorID)
values('121234589101112','Granny Smith Apples',2.99,6,'N','Y',200,150,100),
	('123456789101112','Cortland Apples',2.99,6,'N','Y',300,150,100),
	('246810121416182','Brownie Bars',1.75,2,'Y','Y',85,25,102),
	('970567000432654','Chicken Cutlets',10.75,4,'Y','Y',215,15,103),
	('281466728930012','Paper Cups',2.99,10,'Y','N',295,100,101)


-- a vendor
insert into vendor(VendorName,VendorPhoneNum)
values
('Farm Fresh','8004566444'),
('Papers R Us','8888900000'),
('Reismans','2324445565'),
('Satmar Meats','3728889909')

-- an employee
insert into EMPLOYEE_TYPE (TypeID,TypeDescription)
values(1,'CASHIER'),(2,'MANAGER'),(3,'STOCKER')

insert into EMPLOYEE(EmployeeFirstName, EmployeeLastName,EmployeeBirthdate,EmployeeStreet,EmployeeCity,EmployeeStateInitial,EmployeeZip, EmployeeType,EmployeeHireDate)
values('John','White','1982-01-01','100 East 9th','Bklyn','NY','11230',2,getdate()),
	('Ruth','Smith','1985-01-01','1456 East 9th','Bklyn','NY','11230',1,getdate())
	
-- a customer
insert into CUSTOMER(CustomerFirstName, CustomerLastName, CustomerPhoneNumber, CustomerStreet, CustomerCity, CustomerState, CustomerZip)
values('Esty','Nass','3478310641','100 Harvard Road','Linden','NJ','98765')

-- a purchase order
-- an order line
declare @VendorDetails OrderLineTableType
insert into @VendorDetails(upc,orderNum,qtyOrdered,unitCost)
values('121234589101112',2,100,.75),
	('123456789101112',2,100,.75)
exec usp_InsertVendorOrder 2,'2020-01-13',100,@vendorDetails

declare @orderReceived ReceivedVendorOrderTableType
insert into @vendorDetails(upc,orderNum,qtyOrdered)
values('121234589101112',2,300)
exec usp_ReceiveVendorOrder @orderReceived

-- a sales order
-- a sales order detail
-- accepting a customer payment 
declare @details SalesOrderDetailTableType
insert into @details(upc, salesOrderID, qtySold)
values ('123456789101112', 700, 10)
exec usp_InsertCustomerOrder 100, 100,3,700, '2020-01-13',@details
exec usp_UpdateSalesOrderTotal 700
--fill in totals according to order amount
exec usp_AcceptCustomerPaymentEBTFile 700,1,5.99,'3478310641'
exec usp_AcceptPaymentNotOnFile 700,2,3,34.55

-- a customer return 
exec usp_CustomerReturn 1,700,'123456789101112',2,100,0.0

-- returning to a vendor (deleting an order line)
exec usp_DeletePurchaseOrder 2

-- paying a vendor
exec usp_InsertVendorPayment 2
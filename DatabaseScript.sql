USE [master]
GO
/****** Object:  Database [DatabaseProject]    Script Date: 1/17/2020 1:12:53 PM ******/
CREATE DATABASE [DatabaseProject]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DatabaseProject', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\DatabaseProject.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DatabaseProject_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\DatabaseProject_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [DatabaseProject] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DatabaseProject].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DatabaseProject] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DatabaseProject] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DatabaseProject] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DatabaseProject] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DatabaseProject] SET ARITHABORT OFF 
GO
ALTER DATABASE [DatabaseProject] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DatabaseProject] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DatabaseProject] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DatabaseProject] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DatabaseProject] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DatabaseProject] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DatabaseProject] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DatabaseProject] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DatabaseProject] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DatabaseProject] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DatabaseProject] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DatabaseProject] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DatabaseProject] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DatabaseProject] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DatabaseProject] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DatabaseProject] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DatabaseProject] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DatabaseProject] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DatabaseProject] SET  MULTI_USER 
GO
ALTER DATABASE [DatabaseProject] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DatabaseProject] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DatabaseProject] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DatabaseProject] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DatabaseProject] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DatabaseProject] SET QUERY_STORE = OFF
GO
USE [DatabaseProject]
GO
/****** Object:  UserDefinedTableType [dbo].[OrderLineTableType]    Script Date: 1/17/2020 1:12:53 PM ******/
CREATE TYPE [dbo].[OrderLineTableType] AS TABLE(
	[upc] [varchar](15) NULL,
	[orderNum] [int] NULL,
	[qtyOrdered] [int] NULL,
	[unitCost] [decimal](8, 2) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[ReceivedVendorOrderTableType]    Script Date: 1/17/2020 1:12:53 PM ******/
CREATE TYPE [dbo].[ReceivedVendorOrderTableType] AS TABLE(
	[upc] [varchar](15) NULL,
	[orderNum] [int] NULL,
	[qtyReceived] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[SalesOrderDetailTableType]    Script Date: 1/17/2020 1:12:53 PM ******/
CREATE TYPE [dbo].[SalesOrderDetailTableType] AS TABLE(
	[upc] [varchar](15) NULL,
	[salesOrderID] [int] NULL,
	[qtySold] [int] NULL
)
GO
/****** Object:  Table [dbo].[CUSTOMER]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CUSTOMER](
	[CustomerID] [int] IDENTITY(100,1) NOT NULL,
	[CustomerFirstName] [varchar](30) NOT NULL,
	[CustomerLastName] [varchar](30) NOT NULL,
	[CustomerStreet] [varchar](30) NOT NULL,
	[CustomerCity] [varchar](45) NOT NULL,
	[CustomerState] [char](2) NOT NULL,
	[CustomerZip] [nchar](9) NOT NULL,
	[CustomerPhoneNumber] [numeric](10, 0) NOT NULL,
 CONSTRAINT [PK_CUSTOMER] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UIX_CustomerPhoneNumber] UNIQUE NONCLUSTERED 
(
	[CustomerPhoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CUSTOMER_CREDITCARD]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CUSTOMER_CREDITCARD](
	[CustomerID] [int] NOT NULL,
	[CustomerCCNum] [numeric](16, 0) NOT NULL,
	[CCExpMonth] [char](2) NOT NULL,
	[CCExpYear] [char](4) NOT NULL,
 CONSTRAINT [PK_CUSTOMER_CREDITCARD] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UIX_CUSTOMERCCNUM] UNIQUE NONCLUSTERED 
(
	[CustomerCCNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CUSTOMER_EBT]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CUSTOMER_EBT](
	[CustomerID] [int] NOT NULL,
	[EBT_ID] [int] NOT NULL,
	[EBT_Balance] [decimal](8, 2) NOT NULL,
 CONSTRAINT [PK_EBT] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UIX_EBT_ID] UNIQUE NONCLUSTERED 
(
	[EBT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CUSTOMER_RETURN]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CUSTOMER_RETURN](
	[ReturnID] [int] NOT NULL,
	[UPC] [varchar](15) NOT NULL,
	[SalesOrderNum] [int] NOT NULL,
	[QtyReturned] [int] NOT NULL,
	[ManagerID] [int] NOT NULL,
	[RefundAmount] [decimal](8, 2) NOT NULL,
 CONSTRAINT [PK_CUSTOMER_RETURN] PRIMARY KEY CLUSTERED 
(
	[ReturnID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DISCOUNT_ITEM]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DISCOUNT_ITEM](
	[UPC] [varchar](15) NOT NULL,
	[SaleDateID] [int] NOT NULL,
	[QtyLimit] [int] NOT NULL,
	[SalePrice] [decimal](8, 2) NOT NULL,
 CONSTRAINT [PK_DISCOUNT_ITEM] PRIMARY KEY CLUSTERED 
(
	[UPC] ASC,
	[SaleDateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EMP_TYPE]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EMP_TYPE](
	[TypeID] [int] NOT NULL,
	[TypeDescription] [varchar](45) NOT NULL,
 CONSTRAINT [PK_EMPTYPE] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UIX_TypeDescription] UNIQUE NONCLUSTERED 
(
	[TypeDescription] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EMPLOYEE]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EMPLOYEE](
	[EmployeeID] [int] IDENTITY(100,1) NOT NULL,
	[EmployeeFirstName] [varchar](30) NOT NULL,
	[EmployeeLastName] [varchar](30) NOT NULL,
	[EmployeeStreet] [varchar](30) NOT NULL,
	[EmployeeCity] [varchar](45) NOT NULL,
	[EmployeeStateInitial] [varchar](2) NOT NULL,
	[EmployeeZip] [nchar](9) NOT NULL,
	[EmployeeSSN] [nchar](9) NOT NULL,
	[EmployeeBirthdate] [date] NOT NULL,
	[EmployeeType] [int] NOT NULL,
	[EmployeeHireDate] [date] NOT NULL,
 CONSTRAINT [PK_EMPLOYEE] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UIX_EmployeeSSN] UNIQUE NONCLUSTERED 
(
	[EmployeeSSN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ITEM]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ITEM](
	[UPC] [varchar](15) NOT NULL,
	[ItemName] [varchar](20) NOT NULL,
	[ItemPrice] [decimal](8, 2) NOT NULL,
	[ItemCategory] [int] NOT NULL,
	[Taxable] [char](1) NOT NULL,
	[FoodItem] [char](1) NOT NULL,
	[ItemQty] [int] NOT NULL,
	[ReorderLevel] [int] NOT NULL,
	[VendorID] [int] NOT NULL,
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[UPC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ITEM_CATEGORY]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ITEM_CATEGORY](
	[CategoryID] [int] NOT NULL,
	[CategoryDesc] [varchar](45) NOT NULL,
 CONSTRAINT [PK_ITEM_CATEGORY] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UIX_CategoryDesc] UNIQUE NONCLUSTERED 
(
	[CategoryDesc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ITEM_SALESTAX]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ITEM_SALESTAX](
	[TaxDate] [date] NOT NULL,
	[TaxAmount] [decimal](4, 2) NOT NULL,
 CONSTRAINT [PK_ITEM_SALESTAX] PRIMARY KEY CLUSTERED 
(
	[TaxDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ORDER_LINE]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ORDER_LINE](
	[UPC] [varchar](15) NOT NULL,
	[OrderNum] [int] NOT NULL,
	[QtyOrdered] [int] NOT NULL,
	[UnitCost] [decimal](8, 2) NOT NULL,
	[Subtotal]  AS ([QtyOrdered]*[UnitCost]),
 CONSTRAINT [PK_ORDER_LINE] PRIMARY KEY CLUSTERED 
(
	[UPC] ASC,
	[OrderNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[PaymentID] [int] NOT NULL,
	[PaymentMethodID] [int] NOT NULL,
	[PaymentAmount] [decimal](8, 2) NULL,
	[SalesOrderID] [int] NOT NULL,
	[CustomerPhoneNum] [char](10) NULL,
 CONSTRAINT [PK_PAYMENT] PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentMethods]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentMethods](
	[PaymentMethodID] [int] NOT NULL,
	[PaymentMethodDescription] [varchar](45) NOT NULL,
 CONSTRAINT [PK_PAYMENTMETHODS] PRIMARY KEY CLUSTERED 
(
	[PaymentMethodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UIX_MethodDescription] UNIQUE NONCLUSTERED 
(
	[PaymentMethodDescription] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PURCHASE_ORDER]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PURCHASE_ORDER](
	[OrderNum] [int] NOT NULL,
	[OrderDate] [date] NOT NULL,
	[VendorID] [int] NOT NULL,
	[TotalDue] [decimal](8, 2) NULL,
 CONSTRAINT [PK_PURCHASE_ORDER] PRIMARY KEY CLUSTERED 
(
	[OrderNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RECEIPT_OF_ORDER]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RECEIPT_OF_ORDER](
	[OrderNum] [int] NOT NULL,
	[UPC] [varchar](15) NOT NULL,
	[QtyRecieved] [int] NOT NULL,
 CONSTRAINT [PK_RECEIPT_OF_ORDER] PRIMARY KEY CLUSTERED 
(
	[UPC] ASC,
	[OrderNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SALE_DATE]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SALE_DATE](
	[SaleDateID] [int] IDENTITY(1,1) NOT NULL,
	[BeginDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[MinPurchase] [decimal](8, 2) NOT NULL,
 CONSTRAINT [PK_SALE_DATE] PRIMARY KEY CLUSTERED 
(
	[SaleDateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SALES_ORDER]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SALES_ORDER](
	[SalesOrderNum] [int] NOT NULL,
	[SaleDate] [date] NULL,
	[CustomerID] [int] NULL,
	[CashierID] [int] NOT NULL,
	[Subtotal] [decimal](8, 2) NULL,
	[RegisterNum] [int] NOT NULL,
	[TotalNonFood] [decimal](10, 2) NULL,
	[TotalFood] [decimal](10, 2) NULL,
	[TotalSale] [decimal](10, 2) NULL,
	[TotalNonSale] [decimal](10, 2) NULL,
	[OrderBalance] [decimal](10, 2) NULL,
 CONSTRAINT [PK_SALES_ORDER] PRIMARY KEY CLUSTERED 
(
	[SalesOrderNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SALESORDER_DETAILS]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SALESORDER_DETAILS](
	[UPC] [varchar](15) NOT NULL,
	[SalesOrderID] [int] NOT NULL,
	[QtySold] [int] NOT NULL,
	[UnitPrice] [decimal](8, 2) NULL,
	[Sale] [char](1) NULL,
 CONSTRAINT [PK_SALESORDER_DETAILS] PRIMARY KEY CLUSTERED 
(
	[UPC] ASC,
	[SalesOrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VENDOR]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VENDOR](
	[VendorID] [int] IDENTITY(100,1) NOT NULL,
	[VendorName] [varchar](45) NOT NULL,
	[VendorPhoneNum] [numeric](10, 0) NOT NULL,
 CONSTRAINT [PK_VENDOR] PRIMARY KEY CLUSTERED 
(
	[VendorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UIX_VENDOR_PHONE_NUMBER] UNIQUE NONCLUSTERED 
(
	[VendorPhoneNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VENDOR_PAYMENT]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VENDOR_PAYMENT](
	[OrderNum] [int] NOT NULL,
	[PaymentAmount] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_VENDOR_PAYMENT] PRIMARY KEY CLUSTERED 
(
	[OrderNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DISCOUNT_ITEM] ADD  CONSTRAINT [DFLT_QtyLimit]  DEFAULT ((0)) FOR [QtyLimit]
GO
ALTER TABLE [dbo].[PURCHASE_ORDER] ADD  CONSTRAINT [DFLT_TOTAL_DUE]  DEFAULT ((0.0)) FOR [TotalDue]
GO
ALTER TABLE [dbo].[SALES_ORDER] ADD  CONSTRAINT [DFLT_SUBTOTAL]  DEFAULT ((0.0)) FOR [Subtotal]
GO
ALTER TABLE [dbo].[SALES_ORDER] ADD  CONSTRAINT [DFLT_TOTAL_NONFOOD]  DEFAULT ((0.0)) FOR [TotalNonFood]
GO
ALTER TABLE [dbo].[SALES_ORDER] ADD  CONSTRAINT [DFLT_TOTAL_FOOD]  DEFAULT ((0.0)) FOR [TotalFood]
GO
ALTER TABLE [dbo].[CUSTOMER_CREDITCARD]  WITH CHECK ADD  CONSTRAINT [FK_CUSTOMER_CREDITCARD_CUSTOMER] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[CUSTOMER] ([CustomerID])
GO
ALTER TABLE [dbo].[CUSTOMER_CREDITCARD] CHECK CONSTRAINT [FK_CUSTOMER_CREDITCARD_CUSTOMER]
GO
ALTER TABLE [dbo].[CUSTOMER_EBT]  WITH CHECK ADD  CONSTRAINT [FK_EBT_CUSTOMER] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[CUSTOMER] ([CustomerID])
GO
ALTER TABLE [dbo].[CUSTOMER_EBT] CHECK CONSTRAINT [FK_EBT_CUSTOMER]
GO
ALTER TABLE [dbo].[CUSTOMER_RETURN]  WITH CHECK ADD  CONSTRAINT [FK_CUSTOMER_RETURN_EMPLOYEE] FOREIGN KEY([ManagerID])
REFERENCES [dbo].[EMPLOYEE] ([EmployeeID])
GO
ALTER TABLE [dbo].[CUSTOMER_RETURN] CHECK CONSTRAINT [FK_CUSTOMER_RETURN_EMPLOYEE]
GO
ALTER TABLE [dbo].[CUSTOMER_RETURN]  WITH CHECK ADD  CONSTRAINT [FK_CUSTOMER_RETURN_SALESORDER_DETAILS] FOREIGN KEY([UPC], [SalesOrderNum])
REFERENCES [dbo].[SALESORDER_DETAILS] ([UPC], [SalesOrderID])
GO
ALTER TABLE [dbo].[CUSTOMER_RETURN] CHECK CONSTRAINT [FK_CUSTOMER_RETURN_SALESORDER_DETAILS]
GO
ALTER TABLE [dbo].[DISCOUNT_ITEM]  WITH CHECK ADD  CONSTRAINT [FK_DISCOUNT_ITEM_ITEM] FOREIGN KEY([UPC])
REFERENCES [dbo].[ITEM] ([UPC])
GO
ALTER TABLE [dbo].[DISCOUNT_ITEM] CHECK CONSTRAINT [FK_DISCOUNT_ITEM_ITEM]
GO
ALTER TABLE [dbo].[DISCOUNT_ITEM]  WITH CHECK ADD  CONSTRAINT [FK_DISCOUNT_ITEM_SALE_DATE] FOREIGN KEY([SaleDateID])
REFERENCES [dbo].[SALE_DATE] ([SaleDateID])
GO
ALTER TABLE [dbo].[DISCOUNT_ITEM] CHECK CONSTRAINT [FK_DISCOUNT_ITEM_SALE_DATE]
GO
ALTER TABLE [dbo].[EMPLOYEE]  WITH CHECK ADD  CONSTRAINT [FK_EMPLOYEE_EMPTYPE] FOREIGN KEY([EmployeeType])
REFERENCES [dbo].[EMP_TYPE] ([TypeID])
GO
ALTER TABLE [dbo].[EMPLOYEE] CHECK CONSTRAINT [FK_EMPLOYEE_EMPTYPE]
GO
ALTER TABLE [dbo].[ITEM]  WITH CHECK ADD  CONSTRAINT [FK_ITEM_ITEM_CATEGORY] FOREIGN KEY([ItemCategory])
REFERENCES [dbo].[ITEM_CATEGORY] ([CategoryID])
GO
ALTER TABLE [dbo].[ITEM] CHECK CONSTRAINT [FK_ITEM_ITEM_CATEGORY]
GO
ALTER TABLE [dbo].[ITEM]  WITH CHECK ADD  CONSTRAINT [FK_ITEM_VENDOR] FOREIGN KEY([VendorID])
REFERENCES [dbo].[VENDOR] ([VendorID])
GO
ALTER TABLE [dbo].[ITEM] CHECK CONSTRAINT [FK_ITEM_VENDOR]
GO
ALTER TABLE [dbo].[ORDER_LINE]  WITH CHECK ADD  CONSTRAINT [FK_ORDER_LINE_ITEM] FOREIGN KEY([UPC])
REFERENCES [dbo].[ITEM] ([UPC])
GO
ALTER TABLE [dbo].[ORDER_LINE] CHECK CONSTRAINT [FK_ORDER_LINE_ITEM]
GO
ALTER TABLE [dbo].[ORDER_LINE]  WITH CHECK ADD  CONSTRAINT [FK_ORDER_LINE_PURCHASE_ORDER] FOREIGN KEY([OrderNum])
REFERENCES [dbo].[PURCHASE_ORDER] ([OrderNum])
GO
ALTER TABLE [dbo].[ORDER_LINE] CHECK CONSTRAINT [FK_ORDER_LINE_PURCHASE_ORDER]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [FK_PAYMENT_PAYMENT_METHOD] FOREIGN KEY([PaymentMethodID])
REFERENCES [dbo].[PaymentMethods] ([PaymentMethodID])
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [FK_PAYMENT_PAYMENT_METHOD]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [FK_PAYMENT_SALESORDER] FOREIGN KEY([SalesOrderID])
REFERENCES [dbo].[SALES_ORDER] ([SalesOrderNum])
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [FK_PAYMENT_SALESORDER]
GO
ALTER TABLE [dbo].[PURCHASE_ORDER]  WITH CHECK ADD  CONSTRAINT [FK_PURCHASE_ORDER_VENDOR] FOREIGN KEY([VendorID])
REFERENCES [dbo].[VENDOR] ([VendorID])
GO
ALTER TABLE [dbo].[PURCHASE_ORDER] CHECK CONSTRAINT [FK_PURCHASE_ORDER_VENDOR]
GO
ALTER TABLE [dbo].[RECEIPT_OF_ORDER]  WITH CHECK ADD  CONSTRAINT [FK_RECEIPT_OF_ORDER_ORDER_LINE] FOREIGN KEY([UPC], [OrderNum])
REFERENCES [dbo].[ORDER_LINE] ([UPC], [OrderNum])
GO
ALTER TABLE [dbo].[RECEIPT_OF_ORDER] CHECK CONSTRAINT [FK_RECEIPT_OF_ORDER_ORDER_LINE]
GO
ALTER TABLE [dbo].[RECEIPT_OF_ORDER]  WITH CHECK ADD  CONSTRAINT [FK_RECIEPT_OF_ORDER_PURCHASE_ORDER] FOREIGN KEY([OrderNum])
REFERENCES [dbo].[PURCHASE_ORDER] ([OrderNum])
GO
ALTER TABLE [dbo].[RECEIPT_OF_ORDER] CHECK CONSTRAINT [FK_RECIEPT_OF_ORDER_PURCHASE_ORDER]
GO
ALTER TABLE [dbo].[SALES_ORDER]  WITH CHECK ADD  CONSTRAINT [FK_SALES_ORDER_CASHIER] FOREIGN KEY([CashierID])
REFERENCES [dbo].[EMPLOYEE] ([EmployeeID])
GO
ALTER TABLE [dbo].[SALES_ORDER] CHECK CONSTRAINT [FK_SALES_ORDER_CASHIER]
GO
ALTER TABLE [dbo].[SALES_ORDER]  WITH CHECK ADD  CONSTRAINT [FK_SALES_ORDER_CUSTOMER] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[CUSTOMER] ([CustomerID])
GO
ALTER TABLE [dbo].[SALES_ORDER] CHECK CONSTRAINT [FK_SALES_ORDER_CUSTOMER]
GO
ALTER TABLE [dbo].[SALESORDER_DETAILS]  WITH CHECK ADD  CONSTRAINT [FK_SALESORDER_DETAILS_ITEM] FOREIGN KEY([UPC])
REFERENCES [dbo].[ITEM] ([UPC])
GO
ALTER TABLE [dbo].[SALESORDER_DETAILS] CHECK CONSTRAINT [FK_SALESORDER_DETAILS_ITEM]
GO
ALTER TABLE [dbo].[SALESORDER_DETAILS]  WITH CHECK ADD  CONSTRAINT [FK_SALESORDER_DETAILS_SALES_ORDER] FOREIGN KEY([SalesOrderID])
REFERENCES [dbo].[SALES_ORDER] ([SalesOrderNum])
GO
ALTER TABLE [dbo].[SALESORDER_DETAILS] CHECK CONSTRAINT [FK_SALESORDER_DETAILS_SALES_ORDER]
GO
ALTER TABLE [dbo].[VENDOR_PAYMENT]  WITH CHECK ADD  CONSTRAINT [FK_VENDOR_PAYMENT_PURCHASE_ORDER] FOREIGN KEY([OrderNum])
REFERENCES [dbo].[PURCHASE_ORDER] ([OrderNum])
GO
ALTER TABLE [dbo].[VENDOR_PAYMENT] CHECK CONSTRAINT [FK_VENDOR_PAYMENT_PURCHASE_ORDER]
GO
ALTER TABLE [dbo].[CUSTOMER_CREDITCARD]  WITH CHECK ADD  CONSTRAINT [CHK_CC_EXPMONTH] CHECK  (([CCExpMonth]>=(1) AND [CCExpMonth]<=(12)))
GO
ALTER TABLE [dbo].[CUSTOMER_CREDITCARD] CHECK CONSTRAINT [CHK_CC_EXPMONTH]
GO
ALTER TABLE [dbo].[CUSTOMER_CREDITCARD]  WITH CHECK ADD  CONSTRAINT [CHK_CC_EXPYEAR] CHECK  (([CCExpYear]>=datepart(year,getdate())))
GO
ALTER TABLE [dbo].[CUSTOMER_CREDITCARD] CHECK CONSTRAINT [CHK_CC_EXPYEAR]
GO
ALTER TABLE [dbo].[CUSTOMER_RETURN]  WITH CHECK ADD  CONSTRAINT [CHK_QTY_RETURNED] CHECK  (([QtYReturned]>(0)))
GO
ALTER TABLE [dbo].[CUSTOMER_RETURN] CHECK CONSTRAINT [CHK_QTY_RETURNED]
GO
ALTER TABLE [dbo].[CUSTOMER_RETURN]  WITH CHECK ADD  CONSTRAINT [CHK_REFUND_AMOUNT] CHECK  (([RefundAmount]>=(0)))
GO
ALTER TABLE [dbo].[CUSTOMER_RETURN] CHECK CONSTRAINT [CHK_REFUND_AMOUNT]
GO
ALTER TABLE [dbo].[EMPLOYEE]  WITH CHECK ADD  CONSTRAINT [CHK_EmployeeHireDate] CHECK  (([EmployeeHireDate]<=getdate()))
GO
ALTER TABLE [dbo].[EMPLOYEE] CHECK CONSTRAINT [CHK_EmployeeHireDate]
GO
ALTER TABLE [dbo].[ITEM]  WITH CHECK ADD  CONSTRAINT [CHK_FoodItem] CHECK  (([FoodItem]='n' OR [FoodItem]='N' OR [FoodItem]='y' OR [FoodItem]='Y'))
GO
ALTER TABLE [dbo].[ITEM] CHECK CONSTRAINT [CHK_FoodItem]
GO
ALTER TABLE [dbo].[ITEM]  WITH CHECK ADD  CONSTRAINT [CHK_ItemPrice] CHECK  (([ItemPrice]>(0)))
GO
ALTER TABLE [dbo].[ITEM] CHECK CONSTRAINT [CHK_ItemPrice]
GO
ALTER TABLE [dbo].[ITEM]  WITH CHECK ADD  CONSTRAINT [CHK_Taxable] CHECK  (([Taxable]='n' OR [Taxable]='N' OR [Taxable]='y' OR [Taxable]='Y'))
GO
ALTER TABLE [dbo].[ITEM] CHECK CONSTRAINT [CHK_Taxable]
GO
ALTER TABLE [dbo].[ORDER_LINE]  WITH CHECK ADD  CONSTRAINT [CHK_QtyOrdered] CHECK  (([QtyOrdered]>(0)))
GO
ALTER TABLE [dbo].[ORDER_LINE] CHECK CONSTRAINT [CHK_QtyOrdered]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [CHK_PAYMENT_AMOUNT] CHECK  (([paymentAmount]>(0)))
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [CHK_PAYMENT_AMOUNT]
GO
ALTER TABLE [dbo].[RECEIPT_OF_ORDER]  WITH CHECK ADD  CONSTRAINT [CHK_QtyReceived] CHECK  (([QtyRecieved]>=(0)))
GO
ALTER TABLE [dbo].[RECEIPT_OF_ORDER] CHECK CONSTRAINT [CHK_QtyReceived]
GO
ALTER TABLE [dbo].[SALESORDER_DETAILS]  WITH CHECK ADD  CONSTRAINT [CHK_QtySold] CHECK  (([QtySold]>=(0)))
GO
ALTER TABLE [dbo].[SALESORDER_DETAILS] CHECK CONSTRAINT [CHK_QtySold]
GO
ALTER TABLE [dbo].[SALESORDER_DETAILS]  WITH CHECK ADD  CONSTRAINT [CHK_SALESORDER_DETAILS] CHECK  (([Sale]='n' OR [Sale]='N' OR [Sale]='y' OR [Sale]='Y'))
GO
ALTER TABLE [dbo].[SALESORDER_DETAILS] CHECK CONSTRAINT [CHK_SALESORDER_DETAILS]
GO
ALTER TABLE [dbo].[SALESORDER_DETAILS]  WITH CHECK ADD  CONSTRAINT [CHK_UnitPrice] CHECK  (([UnitPrice]>(0)))
GO
ALTER TABLE [dbo].[SALESORDER_DETAILS] CHECK CONSTRAINT [CHK_UnitPrice]
GO
ALTER TABLE [dbo].[VENDOR_PAYMENT]  WITH CHECK ADD  CONSTRAINT [CHK_VendorPayment] CHECK  (([PaymentAmount]>(0)))
GO
ALTER TABLE [dbo].[VENDOR_PAYMENT] CHECK CONSTRAINT [CHK_VendorPayment]
GO
/****** Object:  StoredProcedure [dbo].[usp_AcceptCustomerCCFilePayment]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_AcceptCustomerCCFilePayment]
@salesOrderID int,
@paymentID int,
@paymentAmount decimal(10,2),
@customerPhoneNum char(10)
as
begin
	begin transaction
		begin try
		insert into Payment(PaymentID,SalesOrderID,PaymentAmount,PaymentMethodID,CustomerPhoneNum)
		values(@paymentID,@salesOrderID,@paymentAmount,1,@customerPhoneNum)

			if (@customerPhoneNum) is null
				begin;
				throw 60090,'Customer does not exist',1
				end

			--check if this phone number exists in your system
			if not exists(select CustomerID
			from CUSTOMER
			where CustomerPhoneNumber = @customerPhoneNum)
				begin;
				throw 60090,'Customer does not exist',1
				end
				
			--check if this customer has a cc on file
			declare @custID int
			set @custID = 
			(select Customer.CustomerID
			from CUSTOMER_CREDITCARD
			inner join CUSTOMER on customer.CustomerID = CUSTOMER_CREDITCARD.CustomerID
			where CustomerPhoneNumber = @customerPhoneNum )
				if @custID is null
					begin;
					throw 60091,'No credit card found',1
					end
				else
					begin
					if (select CCExpYear from CUSTOMER_CREDITCARD where CustomerID = @custID) < year(getdate())
						begin;
						throw 60092,'CC Expired',1
						end
					else if (select CCExpMonth from CUSTOMER_CREDITCARD where CustomerID = @custID) < month(getdate())
						begin;
						throw 60092,'CC Expired',1
						end
					end

		if (select OrderBalance from SALES_ORDER where SalesOrderNum = @salesOrderID) < @paymentAmount
			begin;
			throw 60093,'Invalid amount',1
			end

		--if all is well, then finally subtract the amount from the order balance
		update SALES_ORDER
		set OrderBalance = OrderBalance - @paymentAmount
		where SalesOrderNum = @salesOrderID
		commit transaction
	end try

	begin catch
	rollback;
	throw;
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[usp_AcceptCustomerPaymentEBTFile]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[usp_AcceptCustomerPaymentEBTFile]
@salesOrderID int,
@paymentID int,
@paymentAmount decimal(8,2),
@customerPhoneNum char(10)
as
begin
	begin transaction
		begin try
		--if the ebt method was used already for this order throw an exception
		if exists (select paymentID from Payment where SalesOrderID = @salesOrderID
					and PaymentMethodID = 2)
			begin;
			throw 60095,'EBT has already been used for this order',1
			end

		insert into Payment(PaymentID,SalesOrderID,PaymentAmount,PaymentMethodID,CustomerPhoneNum)
		values(@paymentID,@salesOrderID,@paymentAmount,2,@customerPhoneNum)

		if (@customerPhoneNum) is null
			begin;
			throw 60090,'Customer does not exist',1
			end
		else
			--check if this phone number exists in your system checking if this customer placed the order
			if not exists(select *from CUSTOMER
			inner join SALES_ORDER on SALES_ORDER.CustomerID = CUSTOMER.CustomerID
			where SALES_ORDER.SalesOrderNum = @salesOrderID and CustomerPhoneNumber = @customerPhoneNum )
				begin;
				throw 60092,'Invalid customer',1
				end	
			-- else check if this customer has a ebt on file
			else
			begin
				declare @custID int
				set @custID = 
				(select CUSTOMER_EBT.CustomerID
				from CUSTOMER_EBT
				inner join CUSTOMER on customer.CustomerID = CUSTOMER_EBT.CustomerID
				where CustomerPhoneNumber = @customerPhoneNum)

				if @custID is null
					begin;
					throw 60093,'No EBT card found',1
					end
				else
					begin
					--check if the payment amount is less than total food and orderBalance
					if (select TotalFood from SALES_ORDER where SalesOrderNum = @salesOrderID) < @paymentAmount
						or (select OrderBalance from SALES_ORDER where SalesOrderNum = @salesOrderID) < @paymentAmount
						or (select EBT_Balance - @paymentAmount from CUSTOMER_EBT where CustomerID = @custID)<0
						begin;
						throw 60094,'Invalid amount for EBT',1
						end
					end
				end

		--if all is well, then finally subtract the amount from the order balance
		update CUSTOMER_EBT
		set EBT_Balance = EBT_Balance - @paymentAmount
		where CustomerID = @custID

		update SALES_ORDER
		set OrderBalance = OrderBalance - @paymentAmount
		where SalesOrderNum = @salesOrderID

		commit transaction
	end try

	begin catch
	rollback;
	throw;
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[usp_AcceptPaymentNotOnFile]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_AcceptPaymentNotOnFile]
@orderNum int,
@paymentID int,
@PaymentMethodID int,
@paymentAmount decimal(10,2)


as begin
  begin try 
    begin transaction
	insert into payment(paymentID, paymentMethodID, paymentAmount, SalesOrderID)
	values(@paymentID,@PaymentMethodID,@paymentAmount,@orderNum)

	if(select orderBalance
	from SALES_ORDER
	where SalesOrderNum = @orderNum) < @paymentAmount
	begin;
	   throw 61000,'Invalid payment amount',1
	end

	if(@PaymentMethodID = 5)
	begin
		if @paymentAmount > (select TotalFood from SALES_ORDER where SalesOrderNum = @orderNum)
		begin;
			throw 6100,'Invalid EBT amount',1
		end
	end
	update SALES_ORDER
	set orderBalance = orderBalance - @paymentAmount
	where SalesOrderNum = @orderNum






    commit transaction

   end try

   begin catch
   rollback;
   throw;
   end catch
end

GO
/****** Object:  StoredProcedure [dbo].[usp_CustomerReturn]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_CustomerReturn]
@returnID int,
@salesOrderID int,
@UPC varchar(15),
@qtyReturned int,
@managerID int,
@refundAmount int
as 
begin
   begin try
       begin transaction
	   insert into CUSTOMER_RETURN(returnID,UPC,SalesOrderNum, QtyReturned,ManagerID,RefundAmount)
	   values(@returnID,@UPC,@salesOrderID,@qtyReturned,@managerID,0.0)

	   --check if the manager is a manager
	   if (select TypeDescription
	   from EMPLOYEE 
	   inner join EMP_TYPE on EMPLOYEE.EmployeeType = EMP_TYPE.TypeID
	   where Employee.EmployeeID = @managerID) != 'MANAGER'
	   begin;
	      throw 60030,'Invalid Manager',1
	   end

	   --check to see if the qty returned is not greater than qty ordered 
	   if (select qtySold
	   from SALESORDER_DETAILS
	   where upc = @upc and salesOrderID = @salesOrderID) < @qtyReturned

	   begin; 
	      throw 60080,'Quantity returned is greater than quantity purchased',1
	   end

	   --add inventory back into the item table and subtract from qty sold in sales orderDetail
	   update item
	   set itemQty = itemQty + @qtyReturned
	   where upc = @UPC

	   update SALESORDER_DETAILS
	   set QtySold = QtySold - @qtyReturned
	   where upc = @UPC and SalesOrderID = @salesOrderID


	   --refund the customer, get the price they paid
	   
	   set @refundAmount = (
	   select unitPrice
	   from SALESORDER_DETAILS
	   where UPC = @UPC and SalesOrderID = @salesOrderID) *@qtyReturned
	 

	   --subtract refund amount from the correct columns
	   --find out if it's a food item
	   if (select FoodItem
	   from ITEM
	   inner join SALESORDER_DETAILS on SALESORDER_DETAILS.UPC = ITEM.UPC
	   where SALESORDER_DETAILS.SalesOrderID = @salesOrderID and SALESORDER_DETAILS.UPC = @UPC) = 'Y'
			begin
			update SALES_ORDER
			set TotalFood = TotalFood-@refundAmount
			where SalesOrderNum = @salesOrderID
			end
		else
			begin
			update SALES_ORDER
			set TotalNonFood = TotalNonFood-@refundAmount
			where SalesOrderNum = @salesOrderID
			end

	   --find out if it was on sale
	   if(select sale 
	   from SALESORDER_DETAILS
	   where upc = @UPC and SalesOrderID = @salesOrderID) = 'Y'
	   begin
	      update SALES_ORDER
		  set TotalSale = totalSale - @refundAmount
		  where salesOrderNum = @salesOrderID
	   end
	   else
	     begin
		   update SALES_ORDER
		   set TotalNonSale = TotalNonSale - @refundAmount
		   where salesOrderNum = @salesOrderID
		 end
		 commit transaction
	end try
	begin catch
		rollback;
		throw;
	end catch
	end

GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteOrderLineVendor]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[usp_DeleteOrderLineVendor]
@orderNum int,
@upc varchar(15)
as
begin
	begin try
		begin transaction

		--subtract this orderline from total due in purchase order
		update PURCHASE_ORDER
		set TotalDue = TotalDue -
		(select subtotal from order_line
		where upc = @upc and orderNum = @orderNum)

		--delete this order_line
		delete from order_line
		where upc = @upc and orderNum = @orderNum
		commit transaction
		end try 
   begin catch
   if(@@TRANCOUNT > 0)
		begin
		rollback;
		throw;
		end
		rollback;
		throw;
   end catch
end
	

GO
/****** Object:  StoredProcedure [dbo].[usp_DeletePurchaseOrder]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[usp_DeletePurchaseOrder]
@orderNum int
as
begin
	begin try
		begin transaction

		if not exists(select * from order_line where OrderNum = @orderNum)
		   begin;    
		       throw 60060,'Invalid Order Number',1

		   end

		 delete from ORDER_LINE
		 where OrderNum = @orderNum
		
		delete from PURCHASE_ORDER
		where OrderNum = @orderNum
	commit transaction
	end try
	begin catch
		rollback;
		throw;
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertCustomerOrder]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[usp_InsertCustomerOrder]
@custNum int,
@cashierID int,
@registerNum int,
@salesOrderNum int,
@salesDate date,
@orderDetails SalesOrderDetailTableType READONLY

as 
begin
	begin try
		begin transaction
		--insert an order for a customer
		insert into SALES_ORDER(SalesOrderNum,SaleDate,CustomerID,CashierID,RegisterNum,TotalFood,TotalNonFood,Subtotal)
		values(@salesOrderNum, @salesDate, @custNum, @cashierID, @registerNum,0.0,0.0,0.0)

		--insert the related sales order details
		insert into SALESORDER_DETAILS(UPC,SalesOrderID,QtySold)
		select UPC, salesOrderID, qtySold
		from @orderDetails
	
		if (select TypeDescription
		from EMPLOYEE 
		inner join EMP_TYPE on EMPLOYEE.EmployeeType = EMP_TYPE.TypeID
		where Employee.EmployeeID = @cashierID) != 'CASHIER'
		begin;
	      throw 60030,'Invalid Cashier',1
		end
		--create a trigger that doesn't let qty be negative
		--set all qty's to reflect the sale
		merge Item as targetTable
		using @orderDetails as Source
		on (targetTable.upc = Source.upc)
		when matched
		then update set targetTable.ItemQty = 
		targetTable.ItemQty - Source.QtySold;

		if exists (select ItemQty from Item
		where ItemQty < 0)
		begin;
			throw 60031,'Insufficient Inventory',1
		end

		--set all of the item's prices to their unit price in the item table 
		merge SALESORDER_DETAILS as targetTable
		using ITEM as Source
		on (targetTable.upc = Source.upc)
		when matched and targetTable.SalesOrderID = @salesOrderNum 
		then update set UnitPrice = Source.ItemPrice;

		--if item is taxable re-update unit price
		--update SALESORDER_DETAILS
		--set UnitPrice = UnitPrice*(1+
		--(select taxAmount from ITEM_SALESTAX
		--where TaxDate = (select max(taxDate) from ITEM_SALESTAX)))
		--where UPC in (select UPC from ITEM where Taxable = 'Y') 
		--and SalesOrderID = @salesOrderNum
		
		--set whether or not the item is on sale
		declare @maxSaleID int
		select @maxSaleID = (select max(saleDateID) from SALE_DATE
		where beginDate <= getdate() and endDate >= getdate())

		update SALESORDER_DETAILS
		set Sale = 
		case
		when (UPC in (select UPC from DISCOUNT_ITEM where SaleDateID = @maxSaleID))
		then 'Y'
		else 'N'
		end
		where SalesOrderID = @salesOrderNum
		 
		--set the sales order totalFood/totalNonFood to reflect 
		--the new sale details
		update SALES_ORDER
		set TotalFood = (select sum(qtySold * unitPrice) from SALESORDER_DETAILS
						inner join ITEM on ITEM.UPC = SALESORDER_DETAILS.UPC
						where ITEM.FoodItem = 'Y' and
						 SALESORDER_DETAILS.SalesOrderID = @salesOrderNum)
						 where SalesOrderNum = @salesOrderNum

		update SALES_ORDER
		set TotalNonFood = (select sum(qtySold * unitPrice) from SALESORDER_DETAILS
						inner join ITEM on ITEM.UPC = SALESORDER_DETAILS.UPC
						where ITEM.FoodItem = 'N'  and
						 SALESORDER_DETAILS.SalesOrderID = @salesOrderNum)
						 where SalesOrderNum = @salesOrderNum

		update SALES_ORDER
		set TotalSale = (select sum(qtySold * unitPrice) from SALESORDER_DETAILS
						where SALESORDER_DETAILS.Sale = 'Y' 
						and SalesOrderID = @salesOrderNum)
						where SalesOrderNum = @salesOrderNum

		update SALES_ORDER
		set TotalNonSale = (select sum(qtySold * unitPrice) from SALESORDER_DETAILS
						where SALESORDER_DETAILS.Sale = 'N'
						and  SalesOrderID = @salesOrderNum )
						where salesOrderNum = @salesOrderNum
		
	commit transaction
	end try

	begin catch
	if(@@TRANCOUNT > 0)
	begin
		rollback;
		throw;
	end
		rollback;
		throw;
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertVendorOrder]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[usp_InsertVendorOrder]
@orderNum int,
@orderDate date,
@vendorID int,
@orderDetails ORDERLINETABLETYPE READONLY

as
begin
	begin try
		begin transaction
		insert into PURCHASE_ORDER(orderNum, OrderDate, VendorID)
		values(@orderNum, @orderDate, @vendorID)

		insert into ORDER_LINE(OrderNum, upc, QtyOrdered, UnitCost)
		select orderNum, upc, qtyOrdered, unitCost
		from @orderDetails

		merge PURCHASE_ORDER as TargetTable
		using (select sum(qtyOrdered*unitcost) as result,orderNum
		from @orderDetails
		group by orderNum)as Source
		on (TargetTable.orderNum = Source.orderNum)
		when matched
		then update 
		set TargetTable.TotalDue = TargetTable.TotalDue + Source.result;

		commit transaction
		end try 
	
   begin catch
   if(@@TRANCOUNT > 0)
		begin
		rollback;
		throw;
		end
		rollback;
		throw;
   end catch
end
	

GO
/****** Object:  StoredProcedure [dbo].[usp_InsertVendorPayment]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_InsertVendorPayment]
@orderNum int,
@paymentAmount decimal(10,2)
as
begin
	begin try
		begin transaction
		--the entire order must be paid at one time
		insert into VENDOR_PAYMENT(OrderNum,PaymentAmount)
		values(@orderNum,@paymentAmount)
		if not exists(select orderNum from PURCHASE_ORDER
		where OrderNum = @orderNum)
		begin;
			throw 60005,'Order num is not found',1;
		end
		else
		begin
		if(@paymentAmount > (select TotalDue from PURCHASE_ORDER
		where orderNum = @orderNum) or @paymentAmount < (select TotalDue from PURCHASE_ORDER
		where orderNum = @orderNum))
			begin;
			throw 60005,'Invalid payment amount',1;
			end
		end
		commit transaction
	end try
	begin catch
		rollback;
		throw;
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[usp_ReceiveVendorOrder]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_ReceiveVendorOrder]
@vendorDetails ReceivedVendorOrderTableType READONLY
as begin
  begin try
     begin transaction
	 insert into RECEIPT_OF_ORDER(OrderNum,UPC,QtyRecieved)
	 select orderNum, upc, QtyReceived
	 from @vendorDetails

	merge Item as TargetTable
	using @vendorDetails as Source
	on(TargetTable.upc = Source.upc)
	when matched
	then update 
	set TargetTable.itemQty = TargetTable.itemQty +  Source.qtyReceived;
	
	 commit transaction
	end try
	begin catch
	rollback;
	throw;
	end catch;
	end
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateSalesOrderTotal]    Script Date: 1/17/2020 1:12:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[usp_UpdateSalesOrderTotal]
@orderNum int 

as
begin
	begin try
		begin transaction
		declare @currTax decimal(4,2)
		declare @totalTaxable decimal(10,2)
		declare @minPurchase int
		
		
		set @minPurchase= (select MinPurchase from Sale_date where saleDateID = (select max(SaleDateID) from SALE_DATE
							where getDate() between BeginDate and EndDate))
							

		--get the current sale to see the minimum purchase for that sale 
		if isnull((select (TotalNonSale) from SALES_ORDER where SalesOrderNum = @orderNum),0.0)  >= @minPurchase
		--they qualify for the sale
		--but only set it for the qtyLimit
			begin
			update SALESORDER_DETAILS
			set UnitPrice = 
			SalePrice from DISCOUNT_ITEM 
			inner join SALESORDER_DETAILS 
			on (SALESORDER_DETAILS.UPC = DISCOUNT_ITEM.UPC)
			where SALESORDER_DETAILS.SalesOrderID = @orderNum
			and Sale = 'Y'

			update SALES_ORDER
			set TotalFood = isnull((select sum(UnitPrice *
			case when QtySold>QtyLimit
			then QtyLimit
			else QtySold
			end) from SALESORDER_DETAILS
			inner join DISCOUNT_ITEM on DISCOUNT_ITEM.UPC = SALESORDER_DETAILS.UPC
			inner join ITEM on ITEM.UPC = SALESORDER_DETAILS.UPC 
			where ITEM.FoodItem = 'Y' and SALESORDER_DETAILS.Sale = 'Y' and SalesOrderID = @orderNum),0.0) +
			isnull((select sum (ItemPrice * (QtySold - QtyLimit)) from SalesOrder_Details inner join discount_item
			on discount_item.UPC = SALESORDER_DETAILS.UPC
			inner join ITEM on ITEM.UPC = SALESORDER_DETAILS.UPC
			where Sale = 'Y' and Item.FoodItem = 'Y'
			and QtySold> QtyLimit and SalesOrderID = @orderNum),0.0)
			+
			isnull((select sum(UnitPrice * qtySold) from SALESORDER_DETAILS
			inner join ITEM on ITEM.UPC = SALESORDER_DETAILS.UPC
			where ITEM.FoodItem = 'Y' and Sale = 'N'
			and SalesOrderID = @orderNum),0.0)
			where SalesOrderNum = @orderNum

			update SALES_ORDER
			set TotalNonFood = isnull((select sum(UnitPrice *
			case when QtySold>QtyLimit
			then QtyLimit
			else QtySold
			end) from SALESORDER_DETAILS
			inner join DISCOUNT_ITEM on DISCOUNT_ITEM.UPC = SALESORDER_DETAILS.UPC
			inner join ITEM on ITEM.UPC = SALESORDER_DETAILS.UPC 
			where ITEM.FoodItem = 'N' and SALESORDER_DETAILS.Sale = 'Y' and SalesOrderID = @orderNum),0.0) +
			isnull((select sum (ItemPrice * (QtySold - QtyLimit)) from SalesOrder_Details inner join discount_item
			on discount_item.UPC = SALESORDER_DETAILS.UPC
			inner join ITEM on ITEM.UPC = SALESORDER_DETAILS.UPC
			where Sale = 'Y' and Item.FoodItem = 'N'
			and QtySold> QtyLimit and SalesOrderID = @orderNum),0.0)
			+
			isnull((select sum(UnitPrice * qtySold) from SALESORDER_DETAILS
			inner join ITEM on ITEM.UPC = SALESORDER_DETAILS.UPC
			where ITEM.FoodItem = 'N' and Sale = 'N'
			and SalesOrderID = @orderNum),0.0)
			where SalesOrderNum = @orderNum


			--calculate the amnt that requires tax
			set @totalTaxable = isnull((select sum(UnitPrice *
			case when QtySold>QtyLimit
			then QtyLimit
			else QtySold
			end) from SALESORDER_DETAILS
			inner join DISCOUNT_ITEM on DISCOUNT_ITEM.UPC = SALESORDER_DETAILS.UPC
			inner join ITEM on ITEM.UPC = SALESORDER_DETAILS.UPC 
			where ITEM.Taxable = 'Y' and SALESORDER_DETAILS.Sale = 'Y' and SalesOrderID = @orderNum),0.0) +
			isnull((select sum (ItemPrice * (QtySold - QtyLimit)) from SalesOrder_Details inner join discount_item
			on discount_item.UPC = SALESORDER_DETAILS.UPC
			inner join ITEM on ITEM.UPC = SALESORDER_DETAILS.UPC
			where Sale = 'Y' and Item.Taxable = 'Y'
			and QtySold> QtyLimit and SalesOrderID = @orderNum),0.0)
			+
			isnull((select sum(UnitPrice * qtySold) from SALESORDER_DETAILS
			inner join ITEM on ITEM.UPC = SALESORDER_DETAILS.UPC
			where ITEM.Taxable = 'Y' and Sale = 'N'
			and SalesOrderID = @orderNum),0.0)



			update SALES_ORDER set TotalSale = isnull((select sum(UnitPrice *
			case when qtySold<QtyLimit
			then QtySold
			else QtyLimit
			end) from SALESORDER_DETAILS
			inner join DISCOUNT_ITEM on DISCOUNT_ITEM.UPC = SALESORDER_DETAILS.UPC
			inner join ITEM on ITEM.UPC = SALESORDER_DETAILS.UPC 
			where SALESORDER_DETAILS.Sale = 'Y'
			and SalesOrderID = @orderNum),0.0) 
			where SalesOrderNum = @orderNum

			declare @subtotalPretax decimal(10,2)
			set @subtotalPretax = (select TotalFood +TotalNonFood from SALES_ORDER where SalesOrderNum = @orderNum)

			update SALES_ORDER
			set TotalNonSale = @subtotalPretax - TotalSale
			where SalesOrderNum = @orderNum
			end
		
		select @currTax = (select TaxAmount from ITEM_SALESTAX where TaxDate = (select max(TaxDAte) from ITEM_SALESTAX))
		update SALES_ORDER set Subtotal = isnull(@currTax*@totalTaxable,0.0) +TotalFood +TotalNonFood
		where SalesOrderNum = @orderNum
		
		update SALES_ORDER
		set OrderBalance = Subtotal
		where SalesOrderNum = @orderNum

		commit transaction
	end try
	begin catch
	if(@@TRANCOUNT > 0)
	begin
		rollback;
		throw;
	end
		rollback;
		throw;
	end catch

end
GO
USE [master]
GO
ALTER DATABASE [DatabaseProject] SET  READ_WRITE 
GO

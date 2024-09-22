USE [master]
GO
/****** Object:  Database [POSWEBDB]    Script Date: 22-Sep-24 06:17:15 AM ******/
CREATE DATABASE [POSWEBDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'POSWEBDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.DESHERP\MSSQL\DATA\POSWEBDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'POSWEBDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.DESHERP\MSSQL\DATA\POSWEBDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [POSWEBDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [POSWEBDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [POSWEBDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [POSWEBDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [POSWEBDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [POSWEBDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [POSWEBDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [POSWEBDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [POSWEBDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [POSWEBDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [POSWEBDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [POSWEBDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [POSWEBDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [POSWEBDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [POSWEBDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [POSWEBDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [POSWEBDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [POSWEBDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [POSWEBDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [POSWEBDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [POSWEBDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [POSWEBDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [POSWEBDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [POSWEBDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [POSWEBDB] SET RECOVERY FULL 
GO
ALTER DATABASE [POSWEBDB] SET  MULTI_USER 
GO
ALTER DATABASE [POSWEBDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [POSWEBDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [POSWEBDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [POSWEBDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [POSWEBDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [POSWEBDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'POSWEBDB', N'ON'
GO
ALTER DATABASE [POSWEBDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [POSWEBDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [POSWEBDB]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 22-Sep-24 06:17:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[idCustomer] [int] IDENTITY(1,1) NOT NULL,
	[customerName] [nvarchar](100) NOT NULL,
	[email] [nvarchar](100) NOT NULL,
	[phone] [nvarchar](20) NULL,
	[createdAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idCustomer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoices]    Script Date: 22-Sep-24 06:17:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoices](
	[idInvoice] [int] IDENTITY(1,1) NOT NULL,
	[fk_saleID] [int] NULL,
	[invoiceDate] [datetime] NULL,
	[fk_customerID] [int] NULL,
	[totalAmt] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[idInvoice] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 22-Sep-24 06:17:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[idProduct] [int] IDENTITY(1,1) NOT NULL,
	[productName] [nvarchar](100) NOT NULL,
	[price] [decimal](18, 2) NOT NULL,
	[stockQty] [int] NOT NULL,
	[createdAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sales]    Script Date: 22-Sep-24 06:17:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sales](
	[idSale] [int] IDENTITY(1,1) NOT NULL,
	[fk_productID] [int] NULL,
	[fk_customerID] [int] NULL,
	[qtySold] [int] NOT NULL,
	[totalAmt] [decimal](18, 2) NOT NULL,
	[saleDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idSale] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([idCustomer], [customerName], [email], [phone], [createdAt]) VALUES (1, N'Michael Scofield', N'mscofield@email.com', N'01234567890', CAST(N'2024-09-20T07:22:17.667' AS DateTime))
INSERT [dbo].[Customers] ([idCustomer], [customerName], [email], [phone], [createdAt]) VALUES (2, N'Dr. Sara Tancredi', N'dstancredi@email.com', N'01234567891', CAST(N'2024-09-20T07:23:14.037' AS DateTime))
INSERT [dbo].[Customers] ([idCustomer], [customerName], [email], [phone], [createdAt]) VALUES (3, N'Theodore Bagwell', N'tbag@email.com', N'01234567892', CAST(N'2024-09-20T07:23:56.830' AS DateTime))
INSERT [dbo].[Customers] ([idCustomer], [customerName], [email], [phone], [createdAt]) VALUES (4, N'John Snow', N'jsnow@email.com', N'01234567894', CAST(N'2024-09-20T07:25:51.080' AS DateTime))
INSERT [dbo].[Customers] ([idCustomer], [customerName], [email], [phone], [createdAt]) VALUES (5, N'Tom Cruise', N'abcd@email.com', N'01234567890', CAST(N'2024-09-22T05:50:21.213' AS DateTime))
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[Invoices] ON 

INSERT [dbo].[Invoices] ([idInvoice], [fk_saleID], [invoiceDate], [fk_customerID], [totalAmt]) VALUES (1, 24, CAST(N'2024-09-21T22:57:15.130' AS DateTime), 2, CAST(100000.00 AS Decimal(18, 2)))
INSERT [dbo].[Invoices] ([idInvoice], [fk_saleID], [invoiceDate], [fk_customerID], [totalAmt]) VALUES (2, 25, CAST(N'2024-09-21T22:57:15.157' AS DateTime), 2, CAST(60000.00 AS Decimal(18, 2)))
INSERT [dbo].[Invoices] ([idInvoice], [fk_saleID], [invoiceDate], [fk_customerID], [totalAmt]) VALUES (4, 27, CAST(N'2024-09-21T23:36:25.923' AS DateTime), 3, CAST(60000.00 AS Decimal(18, 2)))
INSERT [dbo].[Invoices] ([idInvoice], [fk_saleID], [invoiceDate], [fk_customerID], [totalAmt]) VALUES (5, 28, CAST(N'2024-09-22T00:36:54.723' AS DateTime), 2, CAST(50000.00 AS Decimal(18, 2)))
INSERT [dbo].[Invoices] ([idInvoice], [fk_saleID], [invoiceDate], [fk_customerID], [totalAmt]) VALUES (6, 29, CAST(N'2024-09-22T00:49:05.950' AS DateTime), 3, CAST(50000.00 AS Decimal(18, 2)))
INSERT [dbo].[Invoices] ([idInvoice], [fk_saleID], [invoiceDate], [fk_customerID], [totalAmt]) VALUES (7, 30, CAST(N'2024-09-22T00:50:20.020' AS DateTime), 4, CAST(50000.00 AS Decimal(18, 2)))
INSERT [dbo].[Invoices] ([idInvoice], [fk_saleID], [invoiceDate], [fk_customerID], [totalAmt]) VALUES (10, 33, CAST(N'2024-09-22T06:04:48.357' AS DateTime), 1, CAST(160000.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Invoices] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([idProduct], [productName], [price], [stockQty], [createdAt]) VALUES (8, N'Samsung S21', CAST(50000.00 AS Decimal(18, 2)), 7, CAST(N'2024-09-20T06:16:11.980' AS DateTime))
INSERT [dbo].[Products] ([idProduct], [productName], [price], [stockQty], [createdAt]) VALUES (10, N'Samsung S22', CAST(55000.00 AS Decimal(18, 2)), 7, CAST(N'2024-09-20T07:19:39.767' AS DateTime))
INSERT [dbo].[Products] ([idProduct], [productName], [price], [stockQty], [createdAt]) VALUES (11, N'Samsung S23', CAST(70000.00 AS Decimal(18, 2)), 6, CAST(N'2024-09-20T07:19:52.000' AS DateTime))
INSERT [dbo].[Products] ([idProduct], [productName], [price], [stockQty], [createdAt]) VALUES (12, N'Samsung S24', CAST(80000.00 AS Decimal(18, 2)), 8, CAST(N'2024-09-20T07:20:05.500' AS DateTime))
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Sales] ON 

INSERT [dbo].[Sales] ([idSale], [fk_productID], [fk_customerID], [qtySold], [totalAmt], [saleDate]) VALUES (24, 8, 2, 2, CAST(100000.00 AS Decimal(18, 2)), CAST(N'2024-09-21T22:57:15.130' AS DateTime))
INSERT [dbo].[Sales] ([idSale], [fk_productID], [fk_customerID], [qtySold], [totalAmt], [saleDate]) VALUES (25, 10, 2, 1, CAST(60000.00 AS Decimal(18, 2)), CAST(N'2024-09-21T22:57:15.157' AS DateTime))
INSERT [dbo].[Sales] ([idSale], [fk_productID], [fk_customerID], [qtySold], [totalAmt], [saleDate]) VALUES (27, 10, 3, 1, CAST(60000.00 AS Decimal(18, 2)), CAST(N'2024-09-21T23:36:25.923' AS DateTime))
INSERT [dbo].[Sales] ([idSale], [fk_productID], [fk_customerID], [qtySold], [totalAmt], [saleDate]) VALUES (28, 8, 2, 1, CAST(50000.00 AS Decimal(18, 2)), CAST(N'2024-09-22T00:36:54.720' AS DateTime))
INSERT [dbo].[Sales] ([idSale], [fk_productID], [fk_customerID], [qtySold], [totalAmt], [saleDate]) VALUES (29, 8, 3, 1, CAST(50000.00 AS Decimal(18, 2)), CAST(N'2024-09-22T00:49:05.947' AS DateTime))
INSERT [dbo].[Sales] ([idSale], [fk_productID], [fk_customerID], [qtySold], [totalAmt], [saleDate]) VALUES (30, 8, 4, 1, CAST(50000.00 AS Decimal(18, 2)), CAST(N'2024-09-22T00:50:20.020' AS DateTime))
INSERT [dbo].[Sales] ([idSale], [fk_productID], [fk_customerID], [qtySold], [totalAmt], [saleDate]) VALUES (33, 12, 1, 2, CAST(160000.00 AS Decimal(18, 2)), CAST(N'2024-09-22T06:04:48.353' AS DateTime))
SET IDENTITY_INSERT [dbo].[Sales] OFF
GO
ALTER TABLE [dbo].[Customers] ADD  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT (getdate()) FOR [invoiceDate]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[Sales] ADD  DEFAULT (getdate()) FOR [saleDate]
GO
ALTER TABLE [dbo].[Invoices]  WITH CHECK ADD FOREIGN KEY([fk_customerID])
REFERENCES [dbo].[Customers] ([idCustomer])
GO
ALTER TABLE [dbo].[Invoices]  WITH CHECK ADD FOREIGN KEY([fk_saleID])
REFERENCES [dbo].[Sales] ([idSale])
GO
ALTER TABLE [dbo].[Sales]  WITH CHECK ADD FOREIGN KEY([fk_customerID])
REFERENCES [dbo].[Customers] ([idCustomer])
GO
ALTER TABLE [dbo].[Sales]  WITH CHECK ADD FOREIGN KEY([fk_productID])
REFERENCES [dbo].[Products] ([idProduct])
GO
/****** Object:  StoredProcedure [dbo].[sp_sale_and_stock_update]    Script Date: 22-Sep-24 06:17:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sale_and_stock_update]
(
    @ProductId int,
    @CustomerId int,
    @Quantity int,
    @TotalPrice decimal(18, 2),
    @NewSaleId int OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @CurrentStock int;

    SELECT @CurrentStock = stockQty FROM Products WHERE idProduct = @ProductId;

    IF @CurrentStock >= @Quantity
    BEGIN
        -- Insert a new sale
        INSERT INTO Sales (fk_productID, fk_customerID, qtySold, totalAmt, saleDate)
			VALUES (@ProductId, @CustomerId, @Quantity, @TotalPrice, GETDATE());

        -- Get the newly created Sale ID
        SET @NewSaleId = SCOPE_IDENTITY();

        -- Update product stock
        UPDATE Products 
        SET stockQty = (stockQty-@Quantity) WHERE idProduct = @ProductId;

        -- Insert into the Invoices table
        INSERT INTO Invoices (fk_saleID, fk_customerID, totalAmt)
			VALUES (@NewSaleId, @CustomerId, @TotalPrice);
    END
    ELSE
    BEGIN
        RAISERROR('Insufficient stock available', 16, 1);
    END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sale_invoice_info]    Script Date: 22-Sep-24 06:17:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sale_invoice_info]
(
    @InvoiceId INT
)
AS

    SELECT i.idInvoice, i.invoiceDate, i.totalAmt, c.customerName, c.phone, s.idSale, p.productName, p.price, s.qtySold FROM Invoices i
    LEFT JOIN Sales s ON s.idSale = i.fk_saleID
	LEFT JOIN Customers c ON c.idCustomer = i.fk_customerID
    LEFT JOIN Products p ON p.idProduct = s.fk_productID 
		WHERE i.idInvoice = @InvoiceId
GO
USE [master]
GO
ALTER DATABASE [POSWEBDB] SET  READ_WRITE 
GO

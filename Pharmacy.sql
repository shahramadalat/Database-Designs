USE [master]
GO
/****** Object:  Database [Pharmacy]    Script Date: 12/3/2022 3:30:10 PM ******/
CREATE DATABASE [Pharmacy]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Pharmacy', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Pharmacy.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Pharmacy_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Pharmacy_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Pharmacy] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Pharmacy].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Pharmacy] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Pharmacy] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Pharmacy] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Pharmacy] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Pharmacy] SET ARITHABORT OFF 
GO
ALTER DATABASE [Pharmacy] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Pharmacy] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Pharmacy] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Pharmacy] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Pharmacy] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Pharmacy] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Pharmacy] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Pharmacy] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Pharmacy] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Pharmacy] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Pharmacy] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Pharmacy] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Pharmacy] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Pharmacy] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Pharmacy] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Pharmacy] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Pharmacy] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Pharmacy] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Pharmacy] SET  MULTI_USER 
GO
ALTER DATABASE [Pharmacy] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Pharmacy] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Pharmacy] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Pharmacy] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Pharmacy] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Pharmacy] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Pharmacy] SET QUERY_STORE = OFF
GO
USE [Pharmacy]
GO
/****** Object:  UserDefinedFunction [dbo].[isEmailValid]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[isEmailValid](@EMAIL nvarchar(80))
RETURNS bit as
BEGIN     
  DECLARE @returnValue as Bit
  IF (@EMAIL <> '' AND @EMAIL NOT LIKE '_%@__%.__%')
     SET @returnValue = 0  -- Invalid
  ELSE 
    SET @returnValue = 1   -- Valid
  RETURN @returnValue
END 
GO
/****** Object:  Table [dbo].[items]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[items](
	[id] [bigint] NOT NULL,
	[name] [nvarchar](55) NULL,
	[categoriesId] [int] NULL,
 CONSTRAINT [PK__items__3213E83FEF80DC8C] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[buyRecieptItems]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[buyRecieptItems](
	[id] [int] NOT NULL,
	[itemId] [bigint] NULL,
	[buyRecieptId] [int] NULL,
	[buyPrice] [money] NULL,
	[quantity] [int] NULL,
 CONSTRAINT [PK__buyRecie__3213E83FB9417A51] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[categories]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categories](
	[id] [int] NOT NULL,
	[name] [nvarchar](55) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vendors]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vendors](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
	[phone] [nvarchar](40) NULL,
	[address] [nvarchar](80) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[buyReciepts]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[buyReciepts](
	[id] [int] NOT NULL,
	[checkoutDate] [date] NULL,
	[vendorId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_buyReciept]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_buyReciept]
AS
SELECT        dbo.categories.name AS categoreyName, dbo.items.name AS itemName, dbo.buyRecieptItems.buyPrice, dbo.buyRecieptItems.quantity, dbo.buyRecieptItems.quantity * dbo.buyRecieptItems.buyPrice AS total, 
                         dbo.buyReciepts.checkoutDate, dbo.vendors.name, dbo.buyRecieptItems.itemId, dbo.buyReciepts.vendorId, dbo.buyRecieptItems.buyRecieptId, dbo.buyRecieptItems.id
FROM            dbo.items INNER JOIN
                         dbo.buyRecieptItems ON dbo.items.id = dbo.buyRecieptItems.itemId INNER JOIN
                         dbo.categories ON dbo.items.categoriesId = dbo.categories.id INNER JOIN
                         dbo.buyReciepts ON dbo.buyRecieptItems.buyRecieptId = dbo.buyReciepts.id INNER JOIN
                         dbo.vendors ON dbo.buyReciepts.vendorId = dbo.vendors.id
GO
/****** Object:  Table [dbo].[tempBuyRecieptItems]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tempBuyRecieptItems](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[itemId] [bigint] NULL,
	[buyRecieptId] [int] NULL,
	[buyPrice] [money] NULL,
	[sellPrice] [money] NULL,
	[quantity] [int] NULL,
	[productionDate] [date] NULL,
	[expireDate] [date] NULL,
 CONSTRAINT [PK__tempBuyR__3213E83F384778E4] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_tempBuyReciept]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_tempBuyReciept]
AS
SELECT        dbo.categories.name AS categoreyName, dbo.items.name AS itemName, dbo.tempBuyRecieptItems.buyPrice, dbo.tempBuyRecieptItems.sellPrice, dbo.tempBuyRecieptItems.quantity, 
                         dbo.tempBuyRecieptItems.quantity * dbo.tempBuyRecieptItems.buyPrice AS total, dbo.tempBuyRecieptItems.productionDate, dbo.tempBuyRecieptItems.expireDate, dbo.tempBuyRecieptItems.itemId
FROM            dbo.items INNER JOIN
                         dbo.tempBuyRecieptItems ON dbo.items.id = dbo.tempBuyRecieptItems.itemId INNER JOIN
                         dbo.categories ON dbo.items.categoriesId = dbo.categories.id
GO
/****** Object:  View [dbo].[View_1]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_1]
AS
SELECT        dbo.categories.name AS categoreyName, dbo.items.name AS itemName, dbo.buyRecieptItems.buyPrice, dbo.buyRecieptItems.sellPrice, dbo.buyRecieptItems.quantity, 
                         dbo.buyRecieptItems.quantity * dbo.buyRecieptItems.buyPrice AS total, dbo.buyRecieptItems.itemId, dbo.buyRecieptItems.buyRecieptId, dbo.buyReciepts.vendorId, dbo.buyReciepts.checkoutDate, dbo.vendors.name
FROM            dbo.items INNER JOIN
                         dbo.buyRecieptItems ON dbo.items.id = dbo.buyRecieptItems.itemId INNER JOIN
                         dbo.categories ON dbo.items.categoriesId = dbo.categories.id INNER JOIN
                         dbo.buyReciepts ON dbo.buyRecieptItems.buyRecieptId = dbo.buyReciepts.id INNER JOIN
                         dbo.vendors ON dbo.buyReciepts.vendorId = dbo.vendors.id
GO
/****** Object:  Table [dbo].[accounts]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[accounts](
	[id] [bigint] NOT NULL,
	[name] [nvarchar](55) NOT NULL,
	[email] [nvarchar](80) NOT NULL,
	[password] [nvarchar](255) NOT NULL,
	[privilage] [int] NULL,
	[phone] [nvarchar](50) NULL,
	[address] [nvarchar](100) NULL,
	[deleted_at] [date] NULL,
 CONSTRAINT [PK__accounts__3213E83F25AF72F1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customers]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customers](
	[id] [int] NOT NULL,
	[name] [nvarchar](60) NULL,
	[phone] [nvarchar](40) NULL,
	[address] [nvarchar](80) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[itemBatchs]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[itemBatchs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[itemId] [bigint] NOT NULL,
	[productionDate] [date] NULL,
	[expireDate] [date] NULL,
	[sellPrice] [money] NULL,
	[quantity] [int] NULL,
 CONSTRAINT [PK_itemBatchs] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sellRecieptItems]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sellRecieptItems](
	[id] [int] NOT NULL,
	[itemId] [bigint] NULL,
	[sellRecieptId] [int] NULL,
	[sellPrice] [money] NULL,
	[quantity] [int] NULL,
 CONSTRAINT [PK__sellReci__3213E83F177F92B4] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sellReciepts]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sellReciepts](
	[id] [int] NOT NULL,
	[checkoutDate] [date] NULL,
	[customerId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[services]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[services](
	[id] [int] NOT NULL,
	[type] [nvarchar](60) NULL,
	[price] [money] NULL,
	[checkoutDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tempSellRecieptItems]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tempSellRecieptItems](
	[id] [int] NOT NULL,
	[itemId] [int] NULL,
	[sellRecieptId] [int] NULL,
	[sellPrice] [money] NULL,
	[quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[test]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[test](
	[a] [int] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[accounts] ([id], [name], [email], [password], [privilage], [phone], [address], [deleted_at]) VALUES (1, N'shahram adalat', N'shahramadalat@gmail.com', N'123', NULL, N'07511262122', N'slemani-tavga', NULL)
INSERT [dbo].[accounts] ([id], [name], [email], [password], [privilage], [phone], [address], [deleted_at]) VALUES (2, N'aland ibrahim', N'alandibrahim@gmail.com', N'123', NULL, N'000 000 0000', N'slemani-raparin', NULL)
INSERT [dbo].[accounts] ([id], [name], [email], [password], [privilage], [phone], [address], [deleted_at]) VALUES (3, N'shsh', N'asjh', N'asd', NULL, NULL, NULL, NULL)
INSERT [dbo].[accounts] ([id], [name], [email], [password], [privilage], [phone], [address], [deleted_at]) VALUES (4, N'abc', N'abc@gmail.com', N'123', NULL, N'0770 124 4455', N'slemani', CAST(N'2022-12-03' AS Date))
INSERT [dbo].[accounts] ([id], [name], [email], [password], [privilage], [phone], [address], [deleted_at]) VALUES (5, N'aland ibrahum', N'-----@----.---', N'123', 10110001, N'12123231', N'slemani', NULL)
GO
INSERT [dbo].[buyRecieptItems] ([id], [itemId], [buyRecieptId], [buyPrice], [quantity]) VALUES (1, 1, 1, 400.0000, 100)
INSERT [dbo].[buyRecieptItems] ([id], [itemId], [buyRecieptId], [buyPrice], [quantity]) VALUES (2, 2, 1, 790.0000, 20)
INSERT [dbo].[buyRecieptItems] ([id], [itemId], [buyRecieptId], [buyPrice], [quantity]) VALUES (3, 3, 2, 2000.0000, 35)
INSERT [dbo].[buyRecieptItems] ([id], [itemId], [buyRecieptId], [buyPrice], [quantity]) VALUES (4, 4, 2, 6000.0000, 40)
INSERT [dbo].[buyRecieptItems] ([id], [itemId], [buyRecieptId], [buyPrice], [quantity]) VALUES (5, 5, 2, 9500.0000, 15)
GO
INSERT [dbo].[buyReciepts] ([id], [checkoutDate], [vendorId]) VALUES (1, CAST(N'2022-11-01' AS Date), 1)
INSERT [dbo].[buyReciepts] ([id], [checkoutDate], [vendorId]) VALUES (2, CAST(N'2022-11-05' AS Date), 3)
INSERT [dbo].[buyReciepts] ([id], [checkoutDate], [vendorId]) VALUES (3, CAST(N'2022-11-06' AS Date), 2)
INSERT [dbo].[buyReciepts] ([id], [checkoutDate], [vendorId]) VALUES (4, CAST(N'2022-11-22' AS Date), 1)
INSERT [dbo].[buyReciepts] ([id], [checkoutDate], [vendorId]) VALUES (5, CAST(N'2022-10-01' AS Date), 2)
GO
INSERT [dbo].[categories] ([id], [name]) VALUES (1, N'7api saresha')
INSERT [dbo].[categories] ([id], [name]) VALUES (2, N'7api azar')
INSERT [dbo].[categories] ([id], [name]) VALUES (3, N'shrwbi saresha')
INSERT [dbo].[categories] ([id], [name]) VALUES (4, N'shrwbi qachesha')
INSERT [dbo].[categories] ([id], [name]) VALUES (5, N'bandj')
INSERT [dbo].[categories] ([id], [name]) VALUES (6, N'lafaf')
GO
SET IDENTITY_INSERT [dbo].[itemBatchs] ON 

INSERT [dbo].[itemBatchs] ([id], [itemId], [productionDate], [expireDate], [sellPrice], [quantity]) VALUES (1, 1, CAST(N'2022-01-01' AS Date), CAST(N'2023-01-01' AS Date), 5000.0000, 177)
INSERT [dbo].[itemBatchs] ([id], [itemId], [productionDate], [expireDate], [sellPrice], [quantity]) VALUES (2, 2, CAST(N'2020-01-01' AS Date), CAST(N'2024-01-01' AS Date), 5000.0000, 97)
INSERT [dbo].[itemBatchs] ([id], [itemId], [productionDate], [expireDate], [sellPrice], [quantity]) VALUES (3, 3, CAST(N'2022-01-01' AS Date), CAST(N'2023-02-01' AS Date), 5000.0000, 112)
INSERT [dbo].[itemBatchs] ([id], [itemId], [productionDate], [expireDate], [sellPrice], [quantity]) VALUES (4, 4, CAST(N'2022-01-01' AS Date), CAST(N'2022-04-01' AS Date), 5000.0000, 117)
INSERT [dbo].[itemBatchs] ([id], [itemId], [productionDate], [expireDate], [sellPrice], [quantity]) VALUES (5, 5, CAST(N'2022-01-01' AS Date), CAST(N'2022-11-01' AS Date), 5000.0000, 92)
INSERT [dbo].[itemBatchs] ([id], [itemId], [productionDate], [expireDate], [sellPrice], [quantity]) VALUES (6, 6, CAST(N'2022-01-01' AS Date), CAST(N'2022-12-01' AS Date), 14000.0000, 60)
INSERT [dbo].[itemBatchs] ([id], [itemId], [productionDate], [expireDate], [sellPrice], [quantity]) VALUES (7, 7, CAST(N'2022-01-01' AS Date), CAST(N'2026-07-01' AS Date), 20000.0000, 71)
INSERT [dbo].[itemBatchs] ([id], [itemId], [productionDate], [expireDate], [sellPrice], [quantity]) VALUES (8, 8, CAST(N'2022-01-01' AS Date), CAST(N'2025-10-01' AS Date), 5000.0000, 66)
INSERT [dbo].[itemBatchs] ([id], [itemId], [productionDate], [expireDate], [sellPrice], [quantity]) VALUES (15, 9, CAST(N'2021-01-02' AS Date), CAST(N'2022-11-02' AS Date), 23000.0000, 5)
SET IDENTITY_INSERT [dbo].[itemBatchs] OFF
GO
INSERT [dbo].[items] ([id], [name], [categoriesId]) VALUES (1, N'afsolani', 1)
INSERT [dbo].[items] ([id], [name], [categoriesId]) VALUES (2, N'tafsolanix', 1)
INSERT [dbo].[items] ([id], [name], [categoriesId]) VALUES (3, N'proniod', 1)
INSERT [dbo].[items] ([id], [name], [categoriesId]) VALUES (4, N'panadol', 2)
INSERT [dbo].[items] ([id], [name], [categoriesId]) VALUES (5, N'madolin', 2)
INSERT [dbo].[items] ([id], [name], [categoriesId]) VALUES (6, N'kadolin', 2)
INSERT [dbo].[items] ([id], [name], [categoriesId]) VALUES (7, N'masolin', 3)
INSERT [dbo].[items] ([id], [name], [categoriesId]) VALUES (8, N'katroli', 3)
INSERT [dbo].[items] ([id], [name], [categoriesId]) VALUES (9, N'bandolin', 3)
INSERT [dbo].[items] ([id], [name], [categoriesId]) VALUES (10, N'kfdn', 3)
INSERT [dbo].[items] ([id], [name], [categoriesId]) VALUES (11, N'ansloin', 3)
INSERT [dbo].[items] ([id], [name], [categoriesId]) VALUES (12, N'brodi', 4)
INSERT [dbo].[items] ([id], [name], [categoriesId]) VALUES (13, N'kroniroll', 4)
INSERT [dbo].[items] ([id], [name], [categoriesId]) VALUES (14, N'hamafi', 5)
INSERT [dbo].[items] ([id], [name], [categoriesId]) VALUES (15, N'brownli', 5)
INSERT [dbo].[items] ([id], [name], [categoriesId]) VALUES (16, N'hm', 6)
INSERT [dbo].[items] ([id], [name], [categoriesId]) VALUES (17, N'lo', 6)
GO
INSERT [dbo].[vendors] ([id], [name], [phone], [address]) VALUES (1, N'shamal', N'0750 124 2122', N'mawlawi')
INSERT [dbo].[vendors] ([id], [name], [phone], [address]) VALUES (2, N'Phar Medic', N'0770 144 4888', N'mamostayan')
INSERT [dbo].[vendors] ([id], [name], [phone], [address]) VALUES (3, N'qwradawe', N'0770 155 5455', N'ashti')
GO
ALTER TABLE [dbo].[buyRecieptItems]  WITH CHECK ADD  CONSTRAINT [FK__buyReciep__buyRe__59FA5E80] FOREIGN KEY([buyRecieptId])
REFERENCES [dbo].[buyReciepts] ([id])
GO
ALTER TABLE [dbo].[buyRecieptItems] CHECK CONSTRAINT [FK__buyReciep__buyRe__59FA5E80]
GO
ALTER TABLE [dbo].[buyRecieptItems]  WITH CHECK ADD  CONSTRAINT [FK__buyReciep__itemI__59063A47] FOREIGN KEY([itemId])
REFERENCES [dbo].[items] ([id])
GO
ALTER TABLE [dbo].[buyRecieptItems] CHECK CONSTRAINT [FK__buyReciep__itemI__59063A47]
GO
ALTER TABLE [dbo].[buyReciepts]  WITH CHECK ADD FOREIGN KEY([vendorId])
REFERENCES [dbo].[vendors] ([id])
GO
ALTER TABLE [dbo].[itemBatchs]  WITH CHECK ADD  CONSTRAINT [FK_itemBatchs_items] FOREIGN KEY([itemId])
REFERENCES [dbo].[items] ([id])
GO
ALTER TABLE [dbo].[itemBatchs] CHECK CONSTRAINT [FK_itemBatchs_items]
GO
ALTER TABLE [dbo].[items]  WITH CHECK ADD  CONSTRAINT [FK__items__categorie__3A81B327] FOREIGN KEY([categoriesId])
REFERENCES [dbo].[categories] ([id])
GO
ALTER TABLE [dbo].[items] CHECK CONSTRAINT [FK__items__categorie__3A81B327]
GO
ALTER TABLE [dbo].[sellRecieptItems]  WITH CHECK ADD  CONSTRAINT [FK__sellRecie__itemI__656C112C] FOREIGN KEY([itemId])
REFERENCES [dbo].[items] ([id])
GO
ALTER TABLE [dbo].[sellRecieptItems] CHECK CONSTRAINT [FK__sellRecie__itemI__656C112C]
GO
ALTER TABLE [dbo].[sellRecieptItems]  WITH CHECK ADD  CONSTRAINT [FK__sellRecie__sellR__66603565] FOREIGN KEY([sellRecieptId])
REFERENCES [dbo].[sellReciepts] ([id])
GO
ALTER TABLE [dbo].[sellRecieptItems] CHECK CONSTRAINT [FK__sellRecie__sellR__66603565]
GO
ALTER TABLE [dbo].[sellReciepts]  WITH CHECK ADD FOREIGN KEY([customerId])
REFERENCES [dbo].[customers] ([id])
GO
/****** Object:  StoredProcedure [dbo].[sp_accountsDelete]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_accountsDelete]
@id bigint
AS
BEGIN
	update accounts set deleted_at = FORMAT (getdate(), 'yyyy-MM-dd') where id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_accountsInsert]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_accountsInsert] 
	@name nvarchar(55),
	@email nvarchar(80),
	@password nvarchar(255),
	@privilage int,
	@phone nvarchar(50),
	@address nvarchar(100)
	
	
AS
BEGIN
	if @email like  '%_@__%.__%'  and PATINDEX('%[^a-z,0-9,@,.,_]%', REPLACE(@email, '-', 'a')) =0
		begin
		insert into accounts(id,name,email,password,privilage,phone,address) values(
			(select top 1 (isnull(id,0)+1) from accounts order by id desc),
			@name,@email,@password,@privilage,@phone,@address
		);
		end
	else
		begin
		THROW 51000, 'InvalidEmailException', 1;  
		end
	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_accountsReadAvailables]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_accountsReadAvailables]
	@name nvarchar(55) = null,
	@phone nvarchar(50) = null
AS
BEGIN
	if @name is not null and @phone is null
		select * from accounts where deleted_at is NULL and (name like '%'+@name+'%')
	else if @phone is not null and @name is null
		select * from accounts where deleted_at is NULL and (phone like '%'+@phone+'%')
	else if @name is not null and @phone is not null
		select * from accounts where deleted_at is NULL and (name like '%'+@name+'%' and phone like '%'+@phone+'%')
	else
		select * from accounts where deleted_at is NULL ;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_accountsReadDeleted]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_accountsReadDeleted]
	@name nvarchar(55) =null,
	@phone nvarchar(50)=null 
AS
BEGIN
	if @name is not null and @phone is null
		select * from accounts where deleted_at is not NULL and (name like '%'+@name+'%')
	else if @phone is not null and @name is null
		select * from accounts where deleted_at is not NULL and (phone like '%'+@phone+'%')
	else if @name is not null and @phone is not null
		select * from accounts where deleted_at is not NULL and (name like '%'+@name+'%' and phone like '%'+@phone+'%')
	else
		select * from accounts where deleted_at is not NULL ;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_accountsUpdate]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_accountsUpdate] 
	@id bigint,
	@name nvarchar(55),
	@privilage int,
	@phone nvarchar(50),
	@address nvarchar(100)
AS
BEGIN
	update accounts set name=@name, privilage=@privilage, phone=@phone ,address=@address where id=@id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_categoriesDelete]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_categoriesDelete]
@id bigint
AS
begin
	SET NOCOUNT ON;
	delete from categories where id=@id
end
GO
/****** Object:  StoredProcedure [dbo].[sp_categoriesInsert]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_categoriesInsert]
@name nvarchar(55)
AS
begin
	SET NOCOUNT ON;
	insert into categories 
	values(
		(select top 1 (isnull(id,0)+1) as lastid from categories order by id desc),
		@name
	);
end
GO
/****** Object:  StoredProcedure [dbo].[sp_categoriesRead]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_categoriesRead]
@name nvarchar(55) = null
AS
begin
	SET NOCOUNT ON;
	
	if @name = null
		begin
		select * from categories;
		end
	else
		begin
		select * from categories where name like '%'+@name+'%';
		end

end
GO
/****** Object:  StoredProcedure [dbo].[sp_categoriesUpdate]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_categoriesUpdate]
@id bigint,
@name nvarchar(55)
AS
begin
	SET NOCOUNT ON;
	update categories set name=@name where id =@id
end
GO
/****** Object:  StoredProcedure [dbo].[sp_tempInsert]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_tempInsert]
@itemId bigint,
@buyPrice money,
@sellPrice money,
@quantity int,
@productionDate date,
@expireDate date

AS
BEGIN
	SET NOCOUNT ON;
	insert into tempBuyRecieptItems(itemId,buyRecieptId,buyPrice,sellPrice,quantity,productionDate,expireDate) 
	values(
		@itemId,
		(select top 1 (isnull(id,0)+1) as lastid from buyReciepts order by id desc),
		@buyPrice,
		@sellPrice,
		@quantity,
		@productionDate,
		@expireDate
	);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_tempToPermenant]    Script Date: 12/3/2022 3:30:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_tempToPermenant] 
AS
BEGIN
	BEGIN TRANSACTION  
		DECLARE @rowCount int = 0;
		DECLARE @itemid int = 0;
		SELECT @rowCount = COUNT(*)-1 FROM tempBuyRecieptItems;
		-- item batches section
		WHILE @rowCount >= 0
		BEGIN
			select @itemid=itemId FROM tempBuyRecieptItems ORDER BY id DESC offset @rowCount rows fetch next 1 rows only;
		
			IF exists (select 1 FROM itemBatchs where itemId=@itemid)
				update itemBatchs set quantity = quantity + (select quantity from tempBuyRecieptItems where itemId=@itemid), sellPrice =(select sellPrice from tempBuyRecieptItems where itemId=@itemid) where itemId = @itemid
			ELSE
				insert into itemBatchs select itemId,productionDate,expireDate,sellPrice,quantity FROM tempBuyRecieptItems where itemId = @itemid;
		
				--insert into itemBatchs values select itemId,productionDate,expireDate,sellPrice,quantity FROM tempBuyRecieptItems ORDER BY id DESC offset @rowCount rows fetch next 1 rows only;
			SET @rowCount = @rowCount-1;
		END
		select * from itemBatchs
		select * from buyRecieptItems
		insert into buyRecieptItems(itemId,buyRecieptId,buyPrice,quantity) select itemId,buyRecieptId,buyPrice,quantity from tempBuyRecieptItems;
		delete from tempBuyRecieptItems

		COMMIT TRANSACTION ;
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[45] 4[16] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "items"
            Begin Extent = 
               Top = 2
               Left = 729
               Bottom = 199
               Right = 899
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "buyRecieptItems"
            Begin Extent = 
               Top = 144
               Left = 377
               Bottom = 337
               Right = 547
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "categories"
            Begin Extent = 
               Top = 144
               Left = 988
               Bottom = 302
               Right = 1230
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "buyReciepts"
            Begin Extent = 
               Top = 192
               Left = 58
               Bottom = 327
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vendors"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1230
         Alias = 810
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'      Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[45] 4[16] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "categories"
            Begin Extent = 
               Top = 79
               Left = 1014
               Bottom = 237
               Right = 1256
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "buyReciepts"
            Begin Extent = 
               Top = 77
               Left = 290
               Bottom = 212
               Right = 460
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vendors"
            Begin Extent = 
               Top = 90
               Left = 72
               Bottom = 220
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "items"
            Begin Extent = 
               Top = 29
               Left = 772
               Bottom = 226
               Right = 942
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "buyRecieptItems"
            Begin Extent = 
               Top = 25
               Left = 516
               Bottom = 218
               Right = 686
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2235
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_buyReciept'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'       Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_buyReciept'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_buyReciept'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "items"
            Begin Extent = 
               Top = 34
               Left = 33
               Bottom = 243
               Right = 203
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "categories"
            Begin Extent = 
               Top = 161
               Left = 275
               Bottom = 257
               Right = 445
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tempBuyRecieptItems"
            Begin Extent = 
               Top = 3
               Left = 523
               Bottom = 229
               Right = 777
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 6870
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_tempBuyReciept'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_tempBuyReciept'
GO
USE [master]
GO
ALTER DATABASE [Pharmacy] SET  READ_WRITE 
GO

/****** Object:  Database WWImportersDW    Script Date: 5/15/2024 1:12:03 PM ******/
/*
Kimball Group, The Microsoft Data Warehouse Toolkit
Generate a database from the datamodel worksheet, version: 4

You can use this Excel workbook as a data modeling tool during the logical design phase of your project.
As discussed in the book, it is in some ways preferable to a real data modeling tool during the inital design.
We expect you to move away from this spreadsheet and into a real modeling tool during the physical design phase.
The authors provide this macro so that the spreadsheet isn't a dead-end. You can 'import' into your
data modeling tool by generating a database using this script, then reverse-engineering that database into
your tool.

Uncomment the next lines if you want to drop and create the database
*/
/*
DROP DATABASE WWImportersDW
GO */
CREATE DATABASE WWImportersDW
GO
ALTER DATABASE WWImportersDW
SET RECOVERY SIMPLE
GO

USE WWImportersDW
;
IF EXISTS (SELECT Name from sys.extended_properties where Name = 'Description')
    EXEC sys.sp_dropextendedproperty @name = 'Description'
EXEC sys.sp_addextendedproperty @name = 'Description', @value = 'Default description - you should change this.'
;





-- Create a schema to hold user views (set schema name on home page of workbook).
-- It would be good to do this only if the schema doesn't exist already.
GO
CREATE SCHEMA MDWT
GO






/* Drop table dbo.DimSupplier */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimSupplier') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimSupplier 
;

/* Create table dbo.DimSupplier */
CREATE TABLE dbo.DimSupplier (
   [SupplierKey]  int IDENTITY  NOT NULL
,  [SupplierID]  int   NOT NULL
,  [Supplier]  nvarchar(100)   NOT NULL
,  [Category]  nvarchar(50)   NOT NULL
,  [PrimaryContact]  nvarchar(50)   NOT NULL
,  [PaymentDays]  int   NOT NULL
,  [PostalCode]  nvarchar(10)   NOT NULL
, CONSTRAINT [PK_dbo.DimSupplier] PRIMARY KEY CLUSTERED 
( [SupplierKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimSupplier
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DimSupplier', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimSupplier
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimSupplier
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Supplier Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimSupplier
;

SET IDENTITY_INSERT dbo.DimSupplier ON
;
INSERT INTO dbo.DimSupplier (SupplierKey, SupplierID, Supplier, Category, PrimaryContact, PaymentDays, PostalCode)
VALUES (-1, -1, '', '', '', -1, '')
;
SET IDENTITY_INSERT dbo.DimSupplier OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[DimSupplier]'))
DROP VIEW [MDWT].[DimSupplier]
GO
CREATE VIEW [MDWT].[DimSupplier] AS 
SELECT [SupplierKey] AS [SupplierKey]
, [SupplierID] AS [SupplieID]
, [Supplier] AS [Supplier]
, [Category] AS [Category]
, [PrimaryContact] AS [PrimaryContact]
, [PaymentDays] AS [PaymentDays]
, [PostalCode] AS [PostalCode]
FROM dbo.DimSupplier
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'SupplierKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'SupplierKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'SupplieID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'SupplierID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Supplier', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'Supplier'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Category', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PrimaryContact', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PrimaryContact'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PaymentDays', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PaymentDays'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PostalCode', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'A unique identifier for each supplier in the table', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'SupplierKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'ID of each supplier', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'SupplierID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Name of each supplier', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'Supplier'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Category of each supplier', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Contact of each supplier', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PrimaryContact'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Payment days', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PaymentDays'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Postal code of each supplier', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'SupplierKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3,,,', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'SupplierID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'A Daturn Corporation', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'Supplier'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Novelty Goods Supplier', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Reio Kabin', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PrimaryContact'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'14', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PaymentDays'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'46077', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'SupplierKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'SupplierID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'Supplier'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PrimaryContact'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PaymentDays'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'SupplierKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'SupplierID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'Supplier'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PrimaryContact'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PaymentDays'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'SupplierID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'Supplier'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PrimaryContact'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PaymentDays'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Purchashing.Suppliers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'SupplierID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Purchashing.Suppliers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'Supplier'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Purchasing.SupplierCategories', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Application.People', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PrimaryContact'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Purchashing.Suppliers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PaymentDays'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Purchashing.Suppliers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'SupplierID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'SupplierID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'SupplierName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'Supplier'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'SupplierCategoryName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Fullname', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PrimaryContact'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'PaymentDays', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PaymentDays'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'PostalPostalCode', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'SupplierID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar(100)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'Supplier'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar(50)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar(50)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PrimaryContact'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PaymentDays'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar(10)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimSupplier', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
;





/* Drop table dbo.DimCustomer */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimCustomer') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimCustomer 
;

/* Create table dbo.DimCustomer */
CREATE TABLE dbo.DimCustomer (
   [CustomerKey]  int IDENTITY  NOT NULL
,  [CustomerID]  int   NOT NULL
,  [Customer]  nvarchar(100)   NOT NULL
,  [BillToCustomer]  nvarchar(100)   NOT NULL
,  [Category]  nvarchar(50)   NOT NULL
,  [BuyingGroup]  nvarchar(50)   NOT NULL
,  [PrimaryContact]  nvarchar(50)   NOT NULL
,  [PostalCode]  nvarchar(10)   NOT NULL
, CONSTRAINT [PK_dbo.DimCustomer] PRIMARY KEY CLUSTERED 
( [CustomerKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimCustomer
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DimCustomer', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimCustomer
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimCustomer
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Customer Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimCustomer
;

SET IDENTITY_INSERT dbo.DimCustomer ON
;
INSERT INTO dbo.DimCustomer (CustomerKey, CustomerID, Customer, BillToCustomer, Category, BuyingGroup, PrimaryContact, PostalCode)
VALUES (-1, -1, '', '', '', '', '', '')
;
SET IDENTITY_INSERT dbo.DimCustomer OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[DimCustomer]'))
DROP VIEW [MDWT].[DimCustomer]
GO
CREATE VIEW [MDWT].[DimCustomer] AS 
SELECT [CustomerKey] AS [CustomerKey]
, [CustomerID] AS [CustomerID]
, [Customer] AS [Customer]
, [BillToCustomer] AS [BillToCustomer]
, [Category] AS [Category]
, [BuyingGroup] AS [BuyingGroup]
, [PrimaryContact] AS [PrimaryContact]
, [PostalCode] AS [PostalCode]
FROM dbo.DimCustomer
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Customer', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Customer'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'BillToCustomer', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'BillToCustomer'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Category', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'BuyingGroup', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'BuyingGroup'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PrimaryContact', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PrimaryContact'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PostalCode', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'A unique identifier for each customer in the table', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'ID of each customer by WWI', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The name and address of each customer', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Customer'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Customer name to be billed', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'BillToCustomer'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Category name of each customer', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The names of group of each customers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'BuyingGroup'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The name of the customer''s primary contact', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PrimaryContact'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Postal code of the customer''s address', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3,,,', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Tailspin Toys (Sylvanite MT)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Customer'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Tailspin Toys (Head Office)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'BillToCustomer'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Novelty Shop', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Tailspin Toys', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'BuyingGroup'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Lorena Cindric', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PrimaryContact'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'90216', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Customer'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'BillToCustomer'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'BuyingGroup'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PrimaryContact'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Customer'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'BillToCustomer'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'BuyingGroup'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PrimaryContact'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Customer'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'BillToCustomer'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'BuyingGroup'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PrimaryContact'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Sales.Customers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Sales.Customers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Customer'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Sales.Customers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'BillToCustomer'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Sales.CustomerCategories', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Sales.BuyingGroups', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'BuyingGroup'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Application.People', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PrimaryContact'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Sales.Customers', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'CustomerID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'CustomerName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Customer'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'CustomerName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'BillToCustomer'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'CustomerCategoryName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'BuyingGroupName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'BuyingGroup'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'FullName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PrimaryContact'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'DeliveryPostalCode', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar(100)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Customer'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar(100)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'BillToCustomer'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar(50)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'Category'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar(50)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'BuyingGroup'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar(50)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PrimaryContact'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar(10)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'PostalCode'; 
;





/* Drop table dbo.DimEmployee */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimEmployee') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimEmployee 
;

/* Create table dbo.DimEmployee */
CREATE TABLE dbo.DimEmployee (
   [EmployeeKey]  int IDENTITY  NOT NULL
,  [EmployeeID]  int   NOT NULL
,  [Employee]  nvarchar(50)   NOT NULL
,  [IsSalesperson]  varchar(30)   NOT NULL
, CONSTRAINT [PK_dbo.DimEmployee] PRIMARY KEY CLUSTERED 
( [EmployeeKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimEmployee
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DimEmployee', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimEmployee
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimEmployee
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Employee Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimEmployee
;

SET IDENTITY_INSERT dbo.DimEmployee ON
;
INSERT INTO dbo.DimEmployee (EmployeeKey, EmployeeID, Employee, IsSalesperson)
VALUES (-1, -1, '', '0')
;
SET IDENTITY_INSERT dbo.DimEmployee OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[DimEmployee]'))
DROP VIEW [MDWT].[DimEmployee]
GO
CREATE VIEW [MDWT].[DimEmployee] AS 
SELECT [EmployeeKey] AS [EmployeeKey]
, [EmployeeID] AS [EmployeeID]
, [Employee] AS [Employee]
, [IsSalesperson] AS [IsSalesperson]
FROM dbo.DimEmployee
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'EmployeeKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'EmployeeID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Employee', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Employee'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'IsSalesperson', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'IsSalesperson'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'A unique identifier for each Employee in the table', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'ID of each employee by WWI', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The name of each employee', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Employee'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Are they salespeople?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'IsSalesperson'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3,,,', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'LiLy Code', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Employee'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'IsSalesperson'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Employee'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'IsSalesperson'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Employee'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'IsSalesperson'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Employee'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'IsSalesperson'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Application.People', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Application.People', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Employee'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Application.People', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'IsSalesperson'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'PersonID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'FullName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Employee'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'IsSalesperson', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'IsSalesperson'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'EmployeeID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar(50)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'Employee'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'bit', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployee', @level2type=N'COLUMN', @level2name=N'IsSalesperson'; 
;





/* Drop table dbo.DimCity */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimCity') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimCity 
;

/* Create table dbo.DimCity */
CREATE TABLE dbo.DimCity (
   [CityKey]  int IDENTITY  NOT NULL
,  [CityID]  int   NOT NULL
,  [CityName]  nvarchar(50)   NOT NULL
,  [StateProvice]  nvarchar(50)   NOT NULL
,  [Country]  nvarchar(60)   NOT NULL
,  [Continent]  nvarchar(30)   NOT NULL
,  [SalesTerritory]  nvarchar(50)   NOT NULL
,  [Region]  nvarchar(30)   NOT NULL
,  [Subregion]  nvarchar(30)   NOT NULL
,  [LatestRecord]  bigint   NOT NULL
, CONSTRAINT [PK_dbo.DimCity] PRIMARY KEY CLUSTERED 
( [CityKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimCity
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DimCity', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimCity
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimCity
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'City Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimCity
;

SET IDENTITY_INSERT dbo.DimCity ON
;
INSERT INTO dbo.DimCity (CityKey, CityID, CityName, StateProvice, Country, Continent, SalesTerritory, Region, Subregion, LatestRecord)
VALUES (-1, -1, '', '', '', '', '', '', '', -1)
;
SET IDENTITY_INSERT dbo.DimCity OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[DimCity]'))
DROP VIEW [MDWT].[DimCity]
GO
CREATE VIEW [MDWT].[DimCity] AS 
SELECT [CityKey] AS [CityKey]
, [CityID] AS [CityID]
, [CityName] AS [CityName]
, [StateProvice] AS [StateProvice]
, [Country] AS [Country]
, [Continent] AS [Continent]
, [SalesTerritory] AS [SalesTerritory]
, [Region] AS [Region]
, [Subregion] AS [Subregion]
, [LatestRecord] AS [LatestRecord]
FROM dbo.DimCity
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CityKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'CityKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CityID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'CityID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CityName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'CityName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'StateProvice', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'StateProvice'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Country', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Continent', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Continent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'SalesTerritory', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'SalesTerritory'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Region', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Subregion', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Subregion'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'LatestRecord', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'LatestRecord'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'A unique identifier for each city in the table', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'CityKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The ID of each city', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'CityID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Formal name of the city', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'CityName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'State or province for this city', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'StateProvice'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Name of the country', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Name of the continent', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Continent'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Sales territory for this StateProvince', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'SalesTerritory'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Name of the region', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Name of the subregion', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Subregion'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Latest available population for the City', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'LatestRecord'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'CityKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'5450', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'CityID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'New York', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'CityName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'New York', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'StateProvice'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'United States', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'North America', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Continent'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Mideast', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'SalesTerritory'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Americas', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Northern America', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Subregion'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'4574', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'LatestRecord'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'CityKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'CityID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'CityName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'StateProvice'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Continent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'SalesTerritory'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Subregion'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'LatestRecord'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'CityKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'CityID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'CityName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'StateProvice'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Continent'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'SalesTerritory'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Subregion'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'LatestRecord'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'CityID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'CityName'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'StateProvice'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Continent'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'SalesTerritory'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Subregion'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'LatestRecord'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Application.Cities', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'CityID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Application.Cities', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'CityName'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Application.StateProvinces', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'StateProvice'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Application.Countries', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Application.Countries', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Continent'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Application.StateProvinces', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'SalesTerritory'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Application.Countries', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Application.Countries', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Subregion'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Application.Cities', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'LatestRecord'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'CityID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'CityID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'CityName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'CityName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'StateProvinceName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'StateProvice'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'CountryName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Continent', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Continent'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'SalesTerritory', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'SalesTerritory'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Region', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Subregion', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Subregion'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'LastestRecordedPopulation', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'LatestRecord'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'CityKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'CityID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'CityName'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'StateProvice'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Country'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Continent'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'SalesTerritory'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Region'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'Subregion'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'bigint', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimCity', @level2type=N'COLUMN', @level2name=N'LatestRecord'; 
;





/* Drop table dbo.DimStockItem */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimStockItem') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimStockItem 
;

/* Create table dbo.DimStockItem */
CREATE TABLE dbo.DimStockItem (
   [StockItemKey]  int IDENTITY  NOT NULL
,  [StockItemID]  int   NOT NULL
,  [StockItem]  nvarchar(100)   NOT NULL
,  [SellingPackage]  nvarchar(50)   NOT NULL
,  [BuyingPackage]  nvarchar(50)   NOT NULL
,  [Brand]  nvarchar(50)   NULL
,  [LeadTimeDays]  int   NOT NULL
,  [QuantityPerOuter]  int   NOT NULL
,  [TaxRate]  decimal(18,2)   NOT NULL
,  [UnitPrice]  decimal(18,3)   NOT NULL
,  [RecommendedRetailPrice]  decimal(18,2)   NULL
,  [TypicalWeightPerUnit]  decimal(18,3)   NOT NULL
,  [StockGroupName]  nvarchar(50)   NULL
, CONSTRAINT [PK_dbo.DimStockItem] PRIMARY KEY CLUSTERED 
( [StockItemKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimStockItem
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'StockItem', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimStockItem
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimStockItem
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'DimStockItem', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimStockItem
;

SET IDENTITY_INSERT dbo.DimStockItem ON
;
INSERT INTO dbo.DimStockItem (StockItemKey, StockItemID, StockItem, SellingPackage, BuyingPackage, Brand, LeadTimeDays, QuantityPerOuter, TaxRate, UnitPrice, RecommendedRetailPrice, TypicalWeightPerUnit, StockGroupName)
VALUES (-1, -1, '', '', '', '', -1, -1, -1, -1, -1, -1, '')
;
SET IDENTITY_INSERT dbo.DimStockItem OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[StockItem]'))
DROP VIEW [MDWT].[StockItem]
GO
CREATE VIEW [MDWT].[StockItem] AS 
SELECT [StockItemKey] AS [StockItemKey]
, [StockItemID] AS [StockItemID]
, [StockItem] AS [StockItem]
, [SellingPackage] AS [SellingPackage]
, [BuyingPackage] AS [BuyingPackage]
, [Brand] AS [Brand]
, [LeadTimeDays] AS [LeadTimeDays]
, [QuantityPerOuter] AS [QuantityPerOuter]
, [TaxRate] AS [TaxRate]
, [UnitPrice] AS [UnitPrice]
, [RecommendedRetailPrice] AS [RecommendedRetailPrice]
, [TypicalWeightPerUnit] AS [TypicalWeightPerUnit]
, [StockGroupName] AS [StockGroupName]
FROM dbo.DimStockItem
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'StockItemKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockItemKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'StockItemID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockItemID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'StockItem', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockItem'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'SellingPackage', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'SellingPackage'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'BuyingPackage', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'BuyingPackage'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Brand', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'Brand'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'LeadTimeDays', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'LeadTimeDays'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'QuantityPerOuter', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'QuantityPerOuter'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TaxRate', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'TaxRate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'UnitPrice', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'UnitPrice'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'RecommendedRetailPrice', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'RecommendedRetailPrice'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TypicalWeightPerUnit', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'TypicalWeightPerUnit'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'StockGroupName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockGroupName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'A unique identifier for each Stock in the table', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockItemKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Numeric ID used for reference to a stock item within the database', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockItemID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Name of Item', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockItem'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Selling package', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'SellingPackage'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Buying package', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'BuyingPackage'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Brand of each item', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'Brand'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The number of days it takes to deliver after placing an order', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'LeadTimeDays'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Quantity per outer packag', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'QuantityPerOuter'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The rate of tax applied to each item', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'TaxRate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Price of each unit', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'UnitPrice'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Recommended retail price', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'RecommendedRetailPrice'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The typical weight of each unit of the item', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'TypicalWeightPerUnit'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Name of stock group item', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockGroupName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'70', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockItemKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'150', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockItemID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Ride on toy sedan car (Green) 1/12 scale', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockItem'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Each', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'SellingPackage'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Each', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'BuyingPackage'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Northwind', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'Brand'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'14', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'LeadTimeDays'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'QuantityPerOuter'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'14', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'TaxRate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'230', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'UnitPrice'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'343.85', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'RecommendedRetailPrice'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'15', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'TypicalWeightPerUnit'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Clothing', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockGroupName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockItemKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockItemID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockItem'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'SellingPackage'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'BuyingPackage'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'Brand'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'LeadTimeDays'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'QuantityPerOuter'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'TaxRate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'UnitPrice'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'RecommendedRetailPrice'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'TypicalWeightPerUnit'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockGroupName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockItemKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockItemID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockItem'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'SellingPackage'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'BuyingPackage'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'Brand'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'LeadTimeDays'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'QuantityPerOuter'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'TaxRate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'UnitPrice'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'RecommendedRetailPrice'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'TypicalWeightPerUnit'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockGroupName'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockItemID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockItem'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'SellingPackage'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'BuyingPackage'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'Brand'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'LeadTimeDays'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'QuantityPerOuter'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'TaxRate'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'UnitPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'RecommendedRetailPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'TypicalWeightPerUnit'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockGroupName'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Warehouse.StockItems', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockItemID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Warehouse.StockItems', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockItem'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Warehouse.PackageTypes', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'SellingPackage'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Warehouse.PackageTypes', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'BuyingPackage'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Warehouse.StockItems', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'Brand'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Warehouse.StockItems', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'LeadTimeDays'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Warehouse.StockItems', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'QuantityPerOuter'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Warehouse.StockItems', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'TaxRate'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Warehouse.StockItems', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'UnitPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Warehouse.StockItems', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'RecommendedRetailPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Warehouse.StockItems', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'TypicalWeightPerUnit'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Warehouse.StockGroups', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockGroupName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'StockItemID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockItemID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'StockItemName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockItem'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'PackageTypeName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'SellingPackage'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'PackageTypeName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'BuyingPackage'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Brand', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'Brand'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'LeadTimeDays', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'LeadTimeDays'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'QuantityPerOuter', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'QuantityPerOuter'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'TaxRate', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'TaxRate'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'UnitPrice', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'UnitPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'RecommendedRetailPrice', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'RecommendedRetailPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'TypicalWeightPerUnit', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'TypicalWeightPerUnit'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'StockGroupName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockGroupName'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockItemID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar(100)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'StockItem'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar(50)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'SellingPackage'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar(50)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'BuyingPackage'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar(50)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'Brand'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'LeadTimeDays'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'QuantityPerOuter'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'decimal(18, 3)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'TaxRate'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'decimal(18, 2)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'UnitPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'decimal(18, 2)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'RecommendedRetailPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'decimal(18, 3)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimStockItem', @level2type=N'COLUMN', @level2name=N'TypicalWeightPerUnit'; 
;





/* Drop table dbo.DimDate */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimDate') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimDate 
;

/* Create table dbo.DimDate */
CREATE TABLE dbo.DimDate (
   [DateKey]  int   NOT NULL
,  [Date]  datetime   NULL
,  [DayOfWeek]  tinyint   NOT NULL
,  [DayName]  nchar(10)   NOT NULL
,  [DayOfMonth]  tinyint   NOT NULL
,  [DayOfYear]  smallint   NOT NULL
,  [WeekOfYear]  tinyint   NOT NULL
,  [MonthName]  nchar(10)   NOT NULL
,  [MonthOfYear]  tinyint   NOT NULL
,  [Quarter]  tinyint   NOT NULL
,  [Year]  smallint   NOT NULL
,  [IsWeekDay]  varchar(20)  DEFAULT 'N' NOT NULL
, CONSTRAINT [PK_dbo.DimDate] PRIMARY KEY CLUSTERED 
( [DateKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DimDate', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Date Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimDate
;

INSERT INTO dbo.DimDate (DateKey, Date, DayOfWeek, DayName, DayOfMonth, DayOfYear, WeekOfYear, MonthName, MonthOfYear, Quarter, Year, IsWeekDay)
VALUES (-1, '12/31/9999', 0, 'Unk date', 0, 0, 0, 'Unk month', 0, 0, 0, '0')
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[DimDate]'))
DROP VIEW [MDWT].[DimDate]
GO
CREATE VIEW [MDWT].[DimDate] AS 
SELECT [DateKey] AS [DateKey]
, [Date] AS [Date]
, [DayOfWeek] AS [DayOfWeek]
, [DayName] AS [DayName]
, [DayOfMonth] AS [DayOfMonth]
, [DayOfYear] AS [DayOfYear]
, [WeekOfYear] AS [WeekOfYear]
, [MonthName] AS [MonthName]
, [MonthOfYear] AS [MonthOfYear]
, [Quarter] AS [Quarter]
, [Year] AS [Year]
, [IsWeekDay] AS [IsWeekDay]
FROM dbo.DimDate
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfWeek', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfMonth', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfYear', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'WeekOfYear', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'MonthName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'MonthOfYear', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Quarter', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Year', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'IsWeekDay', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekDay'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Full date as a SQL date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Number of the day of week, Sunday = 1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Day name of week, eg Monday', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Number of the day in the month', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Number of the day in the year', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Week of year, 1..53', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Month name, eg January', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Month of year, 1..12', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Calendar quarter, 1..4', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Calendar year, eg 2010', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is today a weekday', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekDay'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20041123', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'38314', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1..7', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Sunday', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1..31', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1.365', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1..52 or 53', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'November', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, .., 12', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3, 4', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'2004', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 0', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekDay'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekDay'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekDay'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'in the from: yyyymmdd', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekDay'; 
;





/* Drop table dbo.FactOrder */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.FactOrder') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.FactOrder 
;

/* Create table dbo.FactOrder */
CREATE TABLE dbo.FactOrder (
   [CustomerKey]  int   NOT NULL
,  [CityKey]  int   NOT NULL
,  [StockItemKey]  int   NOT NULL
,  [OrderDateKey]  int   NOT NULL
,  [PickedDateKey]  int   NOT NULL
,  [DeliveryDateKey]  int   NOT NULL
,  [SalespersonKey]  int   NOT NULL
,  [WWIOrderID]  int   NOT NULL
,  [WWIBackorderID]  int   NOT NULL
,  [Description]  nvarchar(100)   NOT NULL
,  [Package]  nvarchar(50)   NOT NULL
,  [Quantity]  int   NOT NULL
,  [UnitPrice]  decimal(18,2)   NOT NULL
,  [OrderTime]  int   NOT NULL
,  [PickingTime]  int   NOT NULL
, CONSTRAINT [PK_dbo.FactOrder] PRIMARY KEY NONCLUSTERED 
( [StockItemKey], [OrderDateKey], [WWIOrderID] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Fact', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactOrder
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Order_Fulfillment_Delivery', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactOrder
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactOrder
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Always create a table description, which becomes a table extended property.', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactOrder
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[Order_Fulfillment_Delivery]'))
DROP VIEW [MDWT].[Order_Fulfillment_Delivery]
GO
CREATE VIEW [MDWT].[Order_Fulfillment_Delivery] AS 
SELECT [CustomerKey] AS [CustomerKey]
, [CityKey] AS [CityKey]
, [StockItemKey] AS [StockItemKey]
, [OrderDateKey] AS [OrderDateKey]
, [PickedDateKey] AS [PickedDateKey]
, [DeliveryDateKey] AS [DeliveryDateKey]
, [SalespersonKey] AS [SalespersonKey]
, [WWIOrderID] AS [WWIOrderID]
, [WWIBackorderID] AS [WWIBackorderID]
, [Description] AS [Description]
, [Package] AS [Package]
, [Quantity] AS [Quantity]
, [UnitPrice] AS [UnitPrice]
, [OrderTime] AS [OrderTime]
, [PickingTime] AS [PickingTime]
FROM dbo.FactOrder
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CityKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'CityKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'StockItemKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'StockItemKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'OrderDateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PickedDateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'PickedDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DeliveryDateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'DeliveryDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'SalespersonKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'SalespersonKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'WWIOrderID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'WWIOrderID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'WWIBackorderID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'WWIBackorderID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Description', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'Description'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Package', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'Package'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Quantity', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'UnitPrice', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'UnitPrice'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'OrderTime', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'OrderTime'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PickingTime', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'PickingTime'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'ForeignKey to DimCustomer (CustomerKey)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'ForeignKey to DimCity (CityKey)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'CityKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'ForeignKey to DimStockItem (StockItemKey)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'StockItemKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'ForeignKey to DimDate (DateKey)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'ForeignKey to DimDate (DateKey)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'PickedDateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'ForeignKey to DimDate (DateKey)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'DeliveryDateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'ForeignKey to DimEmployee (EmployeeKey)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'SalespersonKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The ID of each order', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'WWIOrderID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The ID of each backorder', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'WWIBackorderID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Description of each product', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'Description'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Package of each product', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'Package'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Quantity of each product', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Unit Price of each product', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'UnitPrice'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Time to order of each product', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'OrderTime'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Time to pinking of each order', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'PickingTime'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'322', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'83290', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'CityKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'186', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'StockItemKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20130711', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20130711', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'PickedDateKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20130711', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'DeliveryDateKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'39', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'SalespersonKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'10387', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'WWIOrderID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'10417', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'WWIBackorderID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Developer joke mug - fun was unexpected at this time (White)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'Description'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'each', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'Package'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'10', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'13', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'UnitPrice'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'OrderTime'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'PickingTime'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'CityKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'StockItemKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'PickedDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'DeliveryDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'SalespersonKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lockup forn DimCustomer.CustomerKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lockup forn DimCity.CityKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'CityKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lockup forn DimStockItem.StockItemKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'StockItemKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lockup forn DimDate.DateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lockup forn DimDate.DateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'PickedDateKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lockup forn DimDate.DateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'DeliveryDateKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lockup forn DimEmployee.EmployeeKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'SalespersonKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'WWIOrderID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'WWIBackorderID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'Description'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'Package'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'UnitPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'WWIOrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'WWIBackorderID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'Description'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'Package'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'UnitPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Sales.Order', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'WWIOrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Sales.Order', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'WWIBackorderID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Sales.OrderLine', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'Description'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Warehouse.PackageTypes', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'Package'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Sales.InvoiceLines', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Sales.InvoiceLines', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'UnitPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'OrderID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'WWIOrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'BackorderIOrderID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'WWIBackorderID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Description', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'Description'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Package', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'Package'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'WWIOrderID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'WWIBackorderID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar(100)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'Description'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar(50)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'Package'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'decimal(18,2)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactOrder', @level2type=N'COLUMN', @level2name=N'UnitPrice'; 
;





/* Drop table dbo.FactPurchase */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.FactPurchase') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.FactPurchase 
;

/* Create table dbo.FactPurchase */
CREATE TABLE dbo.FactPurchase (
   [DateKey]  int   NOT NULL
,  [SupplierKey]  int   NOT NULL
,  [StockItemKey]  int   NOT NULL
,  [WWIPurchaseOrderKey]  int   NULL
,  [OrderedOuters]  int   NOT NULL
,  [OrderedQuantity]  int   NOT NULL
,  [ReceivedOuters]  int   NOT NULL
,  [Package]  nvarchar(50)   NOT NULL
,  [IsOrderFinalized]  bit   NOT NULL
, CONSTRAINT [PK_dbo.FactPurchase] PRIMARY KEY NONCLUSTERED 
( [DateKey], [StockItemKey], [OrderedQuantity] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Fact', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactPurchase
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Purchases_Reporting', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactPurchase
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactPurchase
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Always create a table description, which becomes a table extended property.', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactPurchase
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[Purchases_Reporting]'))
DROP VIEW [MDWT].[Purchases_Reporting]
GO
CREATE VIEW [MDWT].[Purchases_Reporting] AS 
SELECT [DateKey] AS [DateKey]
, [SupplierKey] AS [SupplierKey]
, [StockItemKey] AS [StockItemKey]
, [WWIPurchaseOrderKey] AS [WWIPurchaseOrder Key]
, [OrderedOuters] AS [OrderedOuters]
, [OrderedQuantity] AS [OrderedQuantity]
, [ReceivedOuters] AS [ReceivedOuters]
, [Package] AS [Package]
, [IsOrderFinalized] AS [IsOrderFinalized]
FROM dbo.FactPurchase
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'SupplierKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'SupplierKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'StockItemKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'StockItemKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'WWIPurchaseOrder Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'WWIPurchaseOrderKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'OrderedOuters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'OrderedOuters'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'OrderedQuantity', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'OrderedQuantity'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ReceivedOuters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'ReceivedOuters'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Package', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'Package'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'IsOrderFinalized', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'IsOrderFinalized'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'ForeignKey to DimDate (DateKey)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'ForeignKey to DimSupplier (SupplierKey)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'SupplierKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'ForeignKey to DimStockItem (StockItemKey)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'StockItemKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'ID used for reference to a purchase order', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'WWIPurchaseOrderKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Quantity of the stock item that is ordered', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'OrderedOuters'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Number of stocks ordered', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'OrderedQuantity'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Total quantity of the stock item that has been received so far', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'ReceivedOuters'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Full name of package types of that stock items', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'Package'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this purchase order now considered finalized?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'IsOrderFinalized'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/1/2013', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'17', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'SupplierKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'143', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'StockItemKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'WWIPurchaseOrderKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'OrderedOuters'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'12', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'OrderedQuantity'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'ReceivedOuters'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Carton', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'Package'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'IsOrderFinalized'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lockup forn DimDate.DateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lockup forn DimSupplier.SupplierKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'SupplierKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lockup forn DimStockItem.StockItemKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'StockItemKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'WWIPurchaseOrderKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'OrderedOuters'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'OrderedQuantity'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'ReceivedOuters'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'Package'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'IsOrderFinalized'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'WWIPurchaseOrderKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'OrderedOuters'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'OrderedQuantity'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'ReceivedOuters'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'Package'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'IsOrderFinalized'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Purchasing.PurchaseOrders', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'WWIPurchaseOrderKey'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Purchasing.PurchaseOrderLines', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'OrderedOuters'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Purchasing.PurchaseOrderLines, Warehouse.StockItems', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'OrderedQuantity'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Purchasing.PurchaseOrderLines', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'ReceivedOuters'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Warehouse.PackageTypes', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'Package'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Purchasing.PurchaseOrderLines', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'IsOrderFinalized'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'PurchaseOrderID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'WWIPurchaseOrderKey'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'OrderedOuters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'OrderedOuters'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'Purchasing.PurchaseOrderLines.OrderedOuters * Warehouse.StockItems.QuantityPerOuter', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'OrderedQuantity'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'ReceivedOuters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'ReceivedOuters'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'PackageTypeName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'Package'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'IsOrderLineFinalized', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'IsOrderFinalized'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'WWIPurchaseOrderKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'OrderedOuters'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'OrderedQuantity'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'ReceivedOuters'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar(50)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'Package'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'bit', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPurchase', @level2type=N'COLUMN', @level2name=N'IsOrderFinalized'; 
;





/* Drop table dbo.FactSales */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.FactSales') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.FactSales 
;

/* Create table dbo.FactSales */
CREATE TABLE dbo.FactSales (
   [CityKey]  int   NOT NULL
,  [CustomerKey]  int   NOT NULL
,  [BillToCustomerKey]  int   NOT NULL
,  [StockItemKey]  int   NOT NULL
,  [InvoiceDateKey]  int   NOT NULL
,  [DeliveryDateKey]  int   NULL
,  [SalespersonKey]  int   NOT NULL
,  [WWIInvoiceID]  int   NOT NULL
,  [Description]  nvarchar(100)   NOT NULL
,  [Quantity]  int   NOT NULL
,  [UnitPrice]  decimal(18,2)   NOT NULL
,  [TaxRate]  decimal(18,3)   NOT NULL
,  [TotalExcludingTax]  decimal(18,2)   NOT NULL
,  [TaxAmount]  decimal(18,2)   NOT NULL
,  [Profit]  decimal(18,2)   NOT NULL
,  [TotalIncludingTax]  decimal(18,2)   NOT NULL
,  [TotalDryItems]  int   NOT NULL
,  [TotalChillerItems]  int   NOT NULL
,  [RecommendRetailPrice]  decimal(18,2)   NOT NULL
, CONSTRAINT [PK_dbo.FactSales] PRIMARY KEY NONCLUSTERED 
( [CustomerKey], [BillToCustomerKey], [StockItemKey], [InvoiceDateKey], [SalespersonKey], [WWIInvoiceID] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Fact', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactSales
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Sale_Reporting', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactSales
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactSales
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Always create a table description, which becomes a table extended property.', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactSales
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[Sale_Reporting]'))
DROP VIEW [MDWT].[Sale_Reporting]
GO
CREATE VIEW [MDWT].[Sale_Reporting] AS 
SELECT [CityKey] AS [CityKey]
, [CustomerKey] AS [CustomerKey]
, [BillToCustomerKey] AS [BillToCustomerKey]
, [StockItemKey] AS [StockItemKey]
, [InvoiceDateKey] AS [InvoiceDateKey]
, [DeliveryDateKey] AS [DeliveryDateKey]
, [SalespersonKey] AS [SalespersonKey]
, [WWIInvoiceID] AS [WWIInvoiceID]
, [Description] AS [Description]
, [Quantity] AS [Quantity]
, [UnitPrice] AS [UnitPrice]
, [TaxRate] AS [TaxRate]
, [TotalExcludingTax] AS [TotalExcludingTax]
, [TaxAmount] AS [TaxAmount]
, [Profit] AS [Profit]
, [TotalIncludingTax] AS [TotalIncludingTax]
, [TotalDryItems] AS [TotalDryItems]
, [TotalChillerItems] AS [TotalChillerItems]
, [RecommendRetailPrice] AS [RecommendRetailPrice]
FROM dbo.FactSales
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CityKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'CityKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'BillToCustomerKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BillToCustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'StockItemKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'StockItemKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'InvoiceDateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'InvoiceDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DeliveryDateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'DeliveryDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'SalespersonKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'SalespersonKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'WWIInvoiceID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'WWIInvoiceID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Description', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Description'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Quantity', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'UnitPrice', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'UnitPrice'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TaxRate', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TaxRate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TotalExcludingTax', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalExcludingTax'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TaxAmount', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TaxAmount'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Profit', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Profit'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TotalIncludingTax', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalIncludingTax'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TotalDryItems', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalDryItems'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TotalChillerItems', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalChillerItems'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'RecommendRetailPrice', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RecommendRetailPrice'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to City dimension', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'CityKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Customer dimension', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Customer dimension', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BillToCustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Stock Item dimension', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'StockItemKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Date dimension', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'InvoiceDateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Date dimension', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'DeliveryDateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Employee dimension', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'SalespersonKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The ID of each invoice', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'WWIInvoiceID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Description of the item supplied', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Description'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Quantity supplied', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Unit price charged', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'UnitPrice'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Tax rate to be applied', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TaxRate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'total price of the items before tax is applied', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalExcludingTax'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Tax amount calculated', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TaxAmount'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Profit at current cost price', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Profit'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'total price of the items after tax is applied', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalIncludingTax'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Total number of dry packages', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalDryItems'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Total number of chiller packages', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalChillerItems'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Recommended retail price for this stock item', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RecommendRetailPrice'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'41568', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'CityKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'289', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'202', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BillToCustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'31', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'StockItemKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20130711', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'InvoiceDateKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20130711', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'DeliveryDateKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'118', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'SalespersonKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'187', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'WWIInvoiceID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Developer', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Description'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'13', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'UnitPrice'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'15', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TaxRate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'29', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalExcludingTax'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'5.85', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TaxAmount'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'45437', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Profit'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'44.85', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalIncludingTax'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalDryItems'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'0', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalChillerItems'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'45426', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RecommendRetailPrice'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'CityKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BillToCustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'StockItemKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'InvoiceDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'DeliveryDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'SalespersonKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'WWIInvoiceID'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup from DimCity.CityKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'CityKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup from DimCustomer.CustomerKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup from DimCustomer.CustomerKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BillToCustomerKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup from DimStockItem.StokItemKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'StockItemKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup from DimDate.DateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'InvoiceDateKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup from DimDate.DateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'DeliveryDateKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Key lookup from DimEmployee.EmployeeKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'SalespersonKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'WWIInvoiceID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Description'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'UnitPrice'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TaxRate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalExcludingTax'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TaxAmount'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Profit'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalIncludingTax'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalDryItems'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalChillerItems'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'WideWorldImporters', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RecommendRetailPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'WWIInvoiceID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Description'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'UnitPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TaxRate'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalExcludingTax'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TaxAmount'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Profit'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalIncludingTax'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalDryItems'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalChillerItems'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RecommendRetailPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Sales.Invoices', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'WWIInvoiceID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Sales.InvoiceLines', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Description'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Sales.InvoiceLines', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Sales.InvoiceLines', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'UnitPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Sales.InvoiceLines', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TaxRate'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Sales.InvoiceLines', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalExcludingTax'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Sales.InvoiceLines', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TaxAmount'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Sales.InvoiceLines', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Profit'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Sales.InvoiceLines', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalIncludingTax'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Warehouse.StockItems', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalDryItems'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Warehouse.StockItems', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalChillerItems'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'Warehouse.StockItems', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RecommendRetailPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'ExtendedPrice - TaxAmount', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TaxRate'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'CityKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'BillToCustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'StockItemKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'datetime', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'InvoiceDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'datetime', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'DeliveryDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'SalespersonKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'WWIInvoiceID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'nvarchar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Description'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Quantity'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'decimal(18,2)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'UnitPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'decimal(18,3)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TaxRate'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'decimal(18,2)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalExcludingTax'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'decimal(18,2)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TaxAmount'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'decimal(18,2)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'Profit'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'decimal(18,2)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalIncludingTax'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalDryItems'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'TotalChillerItems'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'decimal(18,2)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactSales', @level2type=N'COLUMN', @level2name=N'RecommendRetailPrice'; 
;
ALTER TABLE dbo.FactOrder ADD CONSTRAINT
   FK_dbo_FactOrder_CustomerKey FOREIGN KEY
   (
   CustomerKey
   ) REFERENCES DimCustomer
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactOrder ADD CONSTRAINT
   FK_dbo_FactOrder_CityKey FOREIGN KEY
   (
   CityKey
   ) REFERENCES DimCity
   ( CityKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactOrder ADD CONSTRAINT
   FK_dbo_FactOrder_StockItemKey FOREIGN KEY
   (
   StockItemKey
   ) REFERENCES DimStockItem
   ( StockItemKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactOrder ADD CONSTRAINT
   FK_dbo_FactOrder_OrderDateKey FOREIGN KEY
   (
   OrderDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactOrder ADD CONSTRAINT
   FK_dbo_FactOrder_PickedDateKey FOREIGN KEY
   (
   PickedDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactOrder ADD CONSTRAINT
   FK_dbo_FactOrder_DeliveryDateKey FOREIGN KEY
   (
   DeliveryDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactOrder ADD CONSTRAINT
   FK_dbo_FactOrder_SalespersonKey FOREIGN KEY
   (
   SalespersonKey
   ) REFERENCES DimEmployee
   ( EmployeeKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactPurchase ADD CONSTRAINT
   FK_dbo_FactPurchase_DateKey FOREIGN KEY
   (
   DateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactPurchase ADD CONSTRAINT
   FK_dbo_FactPurchase_SupplierKey FOREIGN KEY
   (
   SupplierKey
   ) REFERENCES DimSupplier
   ( SupplierKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactPurchase ADD CONSTRAINT
   FK_dbo_FactPurchase_StockItemKey FOREIGN KEY
   (
   StockItemKey
   ) REFERENCES DimStockItem
   ( StockItemKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSales ADD CONSTRAINT
   FK_dbo_FactSales_CityKey FOREIGN KEY
   (
   CityKey
   ) REFERENCES DimCity
   ( CityKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSales ADD CONSTRAINT
   FK_dbo_FactSales_CustomerKey FOREIGN KEY
   (
   CustomerKey
   ) REFERENCES DimCustomer
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSales ADD CONSTRAINT
   FK_dbo_FactSales_BillToCustomerKey FOREIGN KEY
   (
   BillToCustomerKey
   ) REFERENCES DimCustomer
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSales ADD CONSTRAINT
   FK_dbo_FactSales_StockItemKey FOREIGN KEY
   (
   StockItemKey
   ) REFERENCES DimStockItem
   ( StockItemKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSales ADD CONSTRAINT
   FK_dbo_FactSales_InvoiceDateKey FOREIGN KEY
   (
   InvoiceDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSales ADD CONSTRAINT
   FK_dbo_FactSales_DeliveryDateKey FOREIGN KEY
   (
   DeliveryDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactSales ADD CONSTRAINT
   FK_dbo_FactSales_SalespersonKey FOREIGN KEY
   (
   SalespersonKey
   ) REFERENCES DimEmployee
   ( EmployeeKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 

----------------------------------------------------------------------------
SELECT        date_key, full_date, day_of_week, day_num_in_month, day_num_overall, day_name, day_abbrev, weekday_flag, week_num_in_year, week_num_overall, week_begin_date, week_begin_date_key, [month], month_num_overall, 
                         month_name, month_abbrev, quarter, [year], yearmo, fiscal_month, fiscal_quarter, fiscal_year, last_day_in_month_flag, same_day_year_ago_date
FROM            [Temp].dbo.Date_Dimension
WHERE        ([year] BETWEEN 2013 AND 2017)

-- Create table StgDate
CREATE TABLE [stgDate] (
date_key int not null,
full_date datetime,    
day_of_week tinyint not null,
day_num_in_month tinyint not null,
day_num_overall smallint not null,
day_name nchar(10) not null,
day_abbrev char(3),
weekday_flag char(10),
week_num_in_year tinyint not null,
week_num_overall smallint,
week_begin_date smalldatetime,
week_begin_date_key int,
month tinyint not null,
month_num_overall smallint,
month_name nchar(10) not null,
month_abbrev char(3),
quarter tinyint not null,
year smallint not null,
yearmo int,
fiscal_month tinyint,
fiscal_quarter tinyint,
fiscal_year smallint,
last_day_in_month_flag nvarchar(20) not null,
same_day_year_ago_date smalldatetime)
;


----------------------------------------------------------------------------
-- SRC - WWI Employee
SELECT        PersonID, FullName, PreferredName,
		CASE WHEN(IsSalesperson=1) THEN 'Sales person'
		When IsSalesperson = 0 then 'Employee' END AS Role
FROM            Application.People AS p
WHERE        (PersonID = PersonID)

-- Create table stgWWImportersEmployee
CREATE TABLE [stgWWImportersEmployee](
    [EmployeeID] int,
    [Employee] nvarchar(50),
    [IsSalesperson] varchar(30),
)


----------------------------------------------------------------------------
-- SRC - WWI Customer
SELECT c.CustomerID, c.CustomerName, bt.CustomerName AS BillToCustomer, c.DeliveryPostalCode,  
               bg.BuyingGroupName, cc.CustomerCategoryName, p.FullName
        FROM Sales.Customers AS c
        INNER JOIN Sales.BuyingGroups AS bg
        ON c.BuyingGroupID = bg.BuyingGroupID
        INNER JOIN Sales.CustomerCategories AS cc
        ON c.CustomerCategoryID = cc.CustomerCategoryID
        INNER JOIN Sales.Customers AS bt
        ON c.BillToCustomerID = bt.CustomerID
        INNER JOIN [Application].People AS p
        ON c.PrimaryContactPersonID = p.PersonID
        WHERE c.BuyingGroupID = bg.BuyingGroupID;


-- Create table stgWWImportersCustomer
CREATE TABLE [stgWWImportersCustomer] (
    [CustomerID] int,
    [BillToCustomer] nvarchar(100),
    [Category] nvarchar(50),
    [BuyingGroup] nvarchar(50),
    [FullName] nvarchar(50),
    [PostalCode] nvarchar(10),
    [Customer] nvarchar(100)
)



----------------------------------------------------------------------------
-- SRC - WWI Supplier
        SELECT s.SupplierID, s.SupplierName, sc.SupplierCategoryName, p.FullName,
               s.PaymentDays, s.DeliveryPostalCode
        FROM Purchasing.Suppliers AS s
        INNER JOIN Purchasing.SupplierCategories AS sc
        ON s.SupplierCategoryID = sc.SupplierCategoryID
        INNER JOIN [Application].People AS p
        ON s.PrimaryContactPersonID = p.PersonID
        WHERE sc.SupplierCategoryID = sc.SupplierCategoryID;

-- CREATE TABLE stgWWImportersSupplier
CREATE TABLE [stgWWImportersSupplier] (
    [SupplierID] int,
    [PaymentDays] int,
    [Supplier] nvarchar(100),
    [Category] nvarchar(50),
    [PrimaryContact] nvarchar(50),
    [PostalCode] nvarchar(10)
)



----------------------------------------------------------------------------
-- SRC - WWI StockItem
SELECT        si.StockItemID, si.StockItemName, spt.PackageTypeName AS SellingPackage, bpt.PackageTypeName AS BuyingPackage, si.Brand, si.LeadTimeDays, si.QuantityPerOuter, si.TaxRate, si.UnitPrice, si.RecommendedRetailPrice, si.TypicalWeightPerUnit, test.StockGroupName
FROM            Warehouse.StockItems AS si INNER JOIN
                         Warehouse.PackageTypes AS spt ON si.UnitPackageID = spt.PackageTypeID INNER JOIN
                         Warehouse.PackageTypes AS bpt ON si.OuterPackageID = bpt.PackageTypeID LEFT OUTER JOIN
                         Warehouse.Colors AS c ON si.ColorID = c.ColorID INNER JOIN 
						 Warehouse.StockItemStockGroups AS stg ON stg.StockItemID = si.StockItemID INNER JOIN
						 Warehouse.StockGroups AS test ON test.StockGroupID = stg.StockGroupID
WHERE        (si.StockItemID = si.StockItemID)


-- CREATE TABLE stgWWImportersStockItem
CREATE TABLE [stgWWImportersStockItem] (
    [StockItem] nvarchar(100),
    [StockItemID] int,
    [SellingPackage] nvarchar(50),
    [BuyingPackage] nvarchar(50),
    [Brand] nvarchar(50),
    [LeadTimeDays] int,
    [QuantityPerOuter] int,
    [TaxRate] decimal(18,2),
    [UnitPrice] decimal(18,3),
    [RecommendedRetailPrice] decimal(18,2),
    [TypicalWeightPerUnit] decimal(18,3),
    [StockGroupName] nvarchar(50)
)



----------------------------------------------------------------------------
-- SRC - WWI City
SELECT c.CityID, c.CityName, sp.StateProvinceName, co.CountryName, co.Continent, sp.SalesTerritory, co.Region, co.Subregion,
               COALESCE(c.LatestRecordedPopulation, 0) AS LastestRecord
        FROM [Application].Cities AS c
        INNER JOIN [Application].StateProvinces AS sp
        ON c.StateProvinceID = sp.StateProvinceID
        INNER JOIN [Application].Countries AS co
        ON sp.CountryID = co.CountryID
        WHERE co.CountryID = sp.CountryID;


-- Create table stgWWImportersCity
CREATE TABLE [stgWWImportersCity](
    [CityID] int,
    [CityName] nvarchar(50),
    [StateProvince] nvarchar(50),
    [Country] nvarchar(60),
    [Continent] nvarchar(30),
    [SalesTerritory] nvarchar(50),
    [Region] nvarchar(30),
    [Subregion] nvarchar(30),
    [LatestRecord] bigint
)


--- FactPurchase
SELECT 
		Day(po.OrderDate) + MONTH(po.OrderDate)*100+YEAR(po.OrderDate)*10000 as OrderDate,
		po.SupplierID,
		pol.StockItemID,
        po.PurchaseOrderID as WWIPurchaseOrderKey,
        pol.OrderedOuters,
	si.QuantityPerOuter,
        pol.ReceivedOuters,
        pt.PackageTypeName as Package,
        pol.IsOrderLineFinalized
FROM Purchasing.PurchaseOrders AS po
INNER JOIN Purchasing.PurchaseOrderLines AS pol
ON po.PurchaseOrderID = pol.PurchaseOrderID
INNER JOIN Warehouse.StockItems AS si
ON pol.StockItemID = si.StockItemID
INNER JOIN Warehouse.PackageTypes AS pt
ON pol.PackageTypeID = pt.PackageTypeID


CREATE TABLE [stgFactPurchase] (
    [OrderedOuters] int,
    [ReceivedOuters] int,
    [SupplierID] int,
    [StockItemID] int,
    [QuantityPerOuter] int,
    [IsOrderLineFinalized] bit,
    [OrderDate] int,
    [WWIPurchaseOrderKey] int,
    [Package] nvarchar(50)
)

--- FactSales
SELECT		
    c.DeliveryCityID AS CityID,
    i.CustomerID AS CustomerID,
    i.BillToCustomerID AS BillToCustomerID,
    il.StockItemID AS StockItemID,
	Day(i.InvoiceDate) + MONTH(i.InvoiceDate)*100+YEAR(i.InvoiceDate)*10000 as InvoiceDate,
	Day(i.ConfirmedDeliveryTime) + MONTH(i.ConfirmedDeliveryTime)* 100 + YEAR(i.ConfirmedDeliveryTime) * 10000 as DeliveryDate,
    i.SalespersonPersonID AS SalepersonID,
    i.InvoiceID AS WWIInvoiceID,
    il.Description,
    pt.PackageTypeName AS Package,
    il.Quantity,
    il.UnitPrice AS UnitPrice,
    il.TaxRate AS TaxRate,
    il.ExtendedPrice AS ExtendedPrice,
    il.TaxAmount AS TaxAmount,
    il.LineProfit AS Profit,
    il.ExtendedPrice AS TotalIncludingTax,
	si.RecommendedRetailPrice AS RecommendedRetailPrice,
    CASE WHEN si.IsChillerStock = 0 THEN il.Quantity ELSE 0 END AS TotalDryItems,
    CASE WHEN si.IsChillerStock <> 0 THEN il.Quantity ELSE 0 END AS TotalChillerItems
FROM Sales.Invoices AS i
INNER JOIN Sales.InvoiceLines AS il ON i.InvoiceID = il.InvoiceID
INNER JOIN Warehouse.StockItems AS si ON il.StockItemID = si.StockItemID
INNER JOIN Warehouse.PackageTypes AS pt ON il.PackageTypeID = pt.PackageTypeID
INNER JOIN Sales.Customers AS c ON i.CustomerID = c.CustomerID
INNER JOIN Sales.Customers AS bt ON i.BillToCustomerID = bt.CustomerID
;


CREATE TABLE [stgFactSales] (
    [CityID] int,
    [CustomerID] int,
    [BillToCustomerID] int,
    [StockItemID] int,
    [InvoiceDate] int,
    [DeliveryDate] int,
    [SalepersonID] int,
    [WWIInvoiceID] int,
    [Description] nvarchar(100),
    [Package] nvarchar(50),
    [Quantity] int,
    [UnitPrice] numeric(18,2),
    [TaxRate] numeric(18,3),
    [ExtendedPrice] numeric(18,2),
    [TaxAmount] numeric(18,2),
    [Profit] numeric(18,2),
    [TotalIncludingTax] numeric(18,2),
    [RecommendedRetailPrice] numeric(18,2),
    [TotalDryItems] int,
    [TotalChillerItems] int
)

--- FactOrder
SELECT 
    c.CustomerID AS CustomerID,
    c.DeliveryCityID AS CityID,
    ol.StockItemID AS StockItemID,
    DAY(o.OrderDate) + MONTH(o.OrderDate) * 100 + YEAR(o.OrderDate) * 10000 AS OrderDateID,
    DAY(ol.PickingCompletedWhen) + MONTH(ol.PickingCompletedWhen) * 100 + YEAR(ol.PickingCompletedWhen) * 10000 AS PickedDateKey,
    COALESCE(DAY(i.ConfirmedDeliveryTime), 1) + COALESCE(MONTH(i.ConfirmedDeliveryTime), 1) * 100 + COALESCE(YEAR(i.ConfirmedDeliveryTime), 1900) * 10000 AS DeliveryDateKey,
    o.SalespersonPersonID AS SalespersonID,
    o.OrderID AS WWIOrderID,
    COALESCE(o.BackorderOrderID, 0) AS WWIBackorderID,
    COALESCE(ol.Description, '') AS Description,  -- Replace NULL with an empty string
    COALESCE(pt.PackageTypeName, '') AS Package,  -- Replace NULL with an empty string
    COALESCE(ol.Quantity, 0) AS Quantity,  -- Replace NULL with 0
    COALESCE(ol.UnitPrice, 0.0) AS UnitPrice,  -- Replace NULL with 0.0
    DATEDIFF(DAY, o.OrderDate, COALESCE(i.ConfirmedDeliveryTime, GETDATE())) AS OrderTime,
    DATEDIFF(DAY, ol.PickingCompletedWhen, COALESCE(i.ConfirmedDeliveryTime, GETDATE())) AS ShippingTime
FROM Sales.Orders AS o
INNER JOIN Sales.OrderLines AS ol ON o.OrderID = ol.OrderID
INNER JOIN Warehouse.PackageTypes AS pt ON ol.PackageTypeID = pt.PackageTypeID
INNER JOIN Sales.Customers AS c ON c.CustomerID = o.CustomerID
INNER JOIN Sales.Invoices AS i ON i.OrderID = o.OrderID;


CREATE TABLE [stgFactOrder] (
    [PickedDateKey] int,
    [DeliveryDateKey] int,
    [WWIOrderID] int,
    [WWIBackorderID] int,
    [Description] nvarchar(100),
    [Package] nvarchar(50),
    [Quantity] int,
    [UnitPrice] numeric(18,2),
    [OrderTime] int,
    [ShippingTime] int,
    [CustomerID] int,
    [CityID] int,
    [StockItemID] int,
    [OrderDateID] int,
    [SalespersonID] int
)
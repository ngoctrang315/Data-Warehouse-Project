-- Check xem Date ở database WideWorldImporters từ ngày nào đến ngày nào


select min(OrderDate) As StartOrderDate 
, max(OrderDate) As EndOrderDate 
from [WideWorldImporters].[Sales].[Orders]

select min(ConfirmedDeliveryTime) As StartShippedDate 
, max(ConfirmedDeliveryTime) As EndShippedDate 
from [WideWorldImporters].[Sales].[Invoices]
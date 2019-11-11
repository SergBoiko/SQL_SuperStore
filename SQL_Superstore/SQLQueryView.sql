CREATE VIEW SuperstoreView AS
SELECT OrderItems.Id AS [Row Id], 
OrderId AS [Order Id], 
OrderDate AS [Order Date], 
ShipDate AS [Ship Date], 
ShipMode.Name AS [Ship Mode],
Customers.Id AS [Customer Id], 
Customers.Name AS [Customer Name], 
Segments.Name AS Segment,
Country,
City,
State,
PostalCode AS [Postal Code],
Region,
Products.Id AS [Product Id],
c2.Name AS Category,
c1.Name AS [Sub-Category],
Products.Name AS [Product Name],
Sales,
Quantity,
Discount,
Profit
FROM OrderItems 
INNER JOIN Orders
ON OrderItems.OrderId = Orders.Id
INNER JOIN Products
ON OrderItems.ProductId = Products.Id
INNER JOIN ShipMode
ON ShipMode.Id = Orders.ShipMode
INNER JOIN Customers
ON Orders.CustomerId = Customers.Id
INNER JOIN Segments 
ON Customers.Segment = Segments.Id
INNER JOIN Categories c1
ON c1.Id = Products.SubCategory
INNER JOIN Addresses
ON Addresses.Id = Orders.AddressId
INNER JOIN Categories c2
ON c2.Id = c1.ParentCategoryId;

SELECT * FROM SuperstoreView;

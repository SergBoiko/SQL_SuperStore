CREATE TABLE ShipMode (
Id INT NOT NULL IDENTITY (1,1) PRIMARY KEY, 
Name varchar(255) NOT NULL)

INSERT INTO ShipMode (Name)
SELECT DISTINCT [Ship Mode] FROM DenormalizeOrderItems$

--UPDATE DenormalizeOrderItems$ 
--SET [Ship Mode] = 

CREATE TABLE Segments (
Id INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
Name varchar(255) NOT NULL)

INSERT INTO Segments (Name)
SELECT DISTINCT [Segment] FROM DenormalizeOrderItems$


CREATE TABLE Customers (
Id varchar (255) NOT NULL PRIMARY KEY, 
Name varchar(255) NOT NULL,
Segment int FOREIGN KEY REFERENCES Segments(Id))
--Country varchar (255) NOT NULL,
--City varchar (255) NOT NULL,
--State varchar (255) NOT NULL,
--PostalCode int NOT NULL,
--Region varchar (255) NOT NULL)

INSERT INTO Customers (Id,Name, Segment)
SELECT DISTINCT [Customer Id], [Customer Name], Segments.Id FROM DenormalizeOrderItems$
INNER JOIN Segments 
ON Segments.Name = DenormalizeOrderItems$.Segment

CREATE TABLE Products (
Id varchar (255) NOT NULL PRIMARY KEY,
Name varchar (255) NOT NULL,
Category varchar (255) NOT NULL,
SubCategory varchar (255) NOT NULL)
--It is possible to move Categories and Sub Categories to another table
INSERT INTO Products (Id,Name, Category, SubCategory)
SELECT DISTINCT [Product Id], [Product Name], Category, [Sub-Category] FROM DenormalizeOrderItems$

CREATE TABLE Orders (
Id varchar (255) NOT NULL PRIMARY KEY,
OrderDate datetime NOT NULL,
ShipDate datetime NOT NULL,
CustomerId varchar (255) NOT NULL FOREIGN KEY REFERENCES Customers(Id),
ShipMode int NOT NULL FOREIGN KEY REFERENCES ShipMode (Id),
Country varchar (255) NOT NULL,
City varchar (255) NOT NULL,
State varchar (255) NOT NULL,
PostalCode int NOT NULL,
Region varchar (255) NOT NULL)

INSERT INTO Orders (Id,OrderDate, ShipDate, CustomerId, ShipMode, Country, City, State, PostalCode, Region)
SELECT DISTINCT [Order Id], [Order Date], [Ship Date], Customers.Id, ShipMode.Id, Country, City, State, [Postal Code], Region FROM DenormalizeOrderItems$
INNER JOIN Customers
ON Customers.Id = DenormalizeOrderItems$.[Customer Id]
INNER JOIN ShipMode
ON ShipMode.Name = DenormalizeOrderItems$.[Ship Mode]

CREATE TABLE OrderItems (
Id int NOT NULL PRIMARY KEY,
OrderId varchar (255) NOT NULL FOREIGN KEY REFERENCES Orders (Id),
ProductId varchar (255) NOT NULL FOREIGN KEY REFERENCES Products (Id),
Sales float NOT NULL,
Quantity int NOT NULL,
Discount float NOT NULL,
Profit float NOT NULL 
)

INSERT INTO OrderItems (Id,OrderId, ProductId, Sales, Quantity, Discount, Profit)
SELECT DISTINCT [Row Id], [Order Id], [Product Id], Sales, Quantity, Discount, Profit FROM DenormalizeOrderItems$







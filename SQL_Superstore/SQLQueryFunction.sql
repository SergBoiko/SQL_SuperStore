CREATE FUNCTION dbo.Price (@OrderId VARCHAR(255))
RETURNS FLOAT
AS BEGIN
    DECLARE @price FLOAT 
	SELECT @price = Sum(Sales * Quantity)
	FROM OrderItems 
	WHERE OrderItems.OrderId = @OrderId
    RETURN @price
END
GO
SELECT * ,dbo.Price(Id) AS Price
FROM Orders;


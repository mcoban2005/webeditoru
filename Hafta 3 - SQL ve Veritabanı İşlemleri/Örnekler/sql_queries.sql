-- Temel SQL Sorguları

-- 1. SELECT Sorguları
-- Tüm ürünleri listele
SELECT * FROM Products WHERE IsActive = 1;

-- Kategoriye göre ürünleri listele
SELECT 
    p.ProductName,
    c.CategoryName,
    p.UnitPrice,
    p.UnitsInStock
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE p.IsActive = 1
ORDER BY c.CategoryName, p.ProductName;

-- 2. INSERT Sorguları
-- Yeni ürün ekleme
INSERT INTO Products (ProductName, CategoryID, UnitPrice, UnitsInStock, Description)
VALUES ('Yeni Ürün', 1, 999.99, 100, 'Yeni ürün açıklaması');

-- Çoklu kayıt ekleme
INSERT INTO Categories (CategoryName, Description)
VALUES 
    ('Kategori 1', 'Açıklama 1'),
    ('Kategori 2', 'Açıklama 2');

-- 3. UPDATE Sorguları
-- Ürün fiyatı güncelleme
UPDATE Products
SET UnitPrice = UnitPrice * 1.10
WHERE CategoryID = 1;

-- Stok güncelleme
UPDATE Products
SET UnitsInStock = UnitsInStock - 1
WHERE ProductID = 1;

-- 4. DELETE Sorguları
-- Soft delete (IsActive = 0)
UPDATE Products
SET IsActive = 0
WHERE ProductID = 1;

-- Hard delete
DELETE FROM OrderDetails WHERE OrderID = 1;
DELETE FROM Orders WHERE OrderID = 1;

-- 5. JOIN Örnekleri
-- INNER JOIN
SELECT 
    o.OrderID,
    u.Username,
    p.ProductName,
    od.Quantity,
    od.UnitPrice
FROM Orders o
INNER JOIN Users u ON o.UserID = u.UserID
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID;

-- LEFT JOIN
SELECT 
    c.CategoryName,
    COUNT(p.ProductID) as ProductCount
FROM Categories c
LEFT JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName;

-- 6. Subquery Örnekleri
-- Ortalama fiyatın üzerindeki ürünler
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products);

-- En çok satılan ürünler
SELECT 
    p.ProductName,
    (SELECT COUNT(*) FROM OrderDetails od WHERE od.ProductID = p.ProductID) as SalesCount
FROM Products p
WHERE IsActive = 1;

-- 7. Aggregate Functions
SELECT 
    CategoryID,
    COUNT(*) as ProductCount,
    AVG(UnitPrice) as AvgPrice,
    MIN(UnitPrice) as MinPrice,
    MAX(UnitPrice) as MaxPrice,
    SUM(UnitsInStock) as TotalStock
FROM Products
GROUP BY CategoryID
HAVING COUNT(*) > 1;

-- 8. Stored Procedure Örneği
CREATE PROCEDURE sp_ProcessOrder
    @OrderID INT,
    @UserID INT,
    @AddressID INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
            
        -- Sipariş başlığını oluştur
        INSERT INTO Orders (UserID, AddressID, OrderStatus)
        VALUES (@UserID, @AddressID, 'Processing');
        
        -- Sepetteki ürünleri siparişe ekle
        INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
        SELECT 
            @OrderID,
            ProductID,
            Quantity,
            UnitPrice
        FROM Cart
        WHERE UserID = @UserID;
        
        -- Stok güncelle
        UPDATE p
        SET p.UnitsInStock = p.UnitsInStock - c.Quantity
        FROM Products p
        INNER JOIN Cart c ON p.ProductID = c.ProductID
        WHERE c.UserID = @UserID;
        
        -- Sepeti temizle
        DELETE FROM Cart WHERE UserID = @UserID;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

-- 9. Trigger Örneği
CREATE TRIGGER tr_UpdateStock
ON OrderDetails
AFTER INSERT
AS
BEGIN
    UPDATE p
    SET p.UnitsInStock = p.UnitsInStock - i.Quantity
    FROM Products p
    INNER JOIN inserted i ON p.ProductID = i.ProductID;
END;
GO 
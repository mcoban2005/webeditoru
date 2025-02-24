-- E-ticaret Veritabanı Oluşturma
CREATE DATABASE ECommerceDB
GO

USE ECommerceDB
GO

-- Kategori Tablosu
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500),
    CreatedDate DATETIME DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1
)
GO

-- Ürün Tablosu
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(200) NOT NULL,
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID),
    UnitPrice DECIMAL(18,2) NOT NULL,
    UnitsInStock INT DEFAULT 0,
    Description NVARCHAR(MAX),
    ImageUrl NVARCHAR(500),
    CreatedDate DATETIME DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1
)
GO

-- Kullanıcı Tablosu
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(500) NOT NULL,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    CreatedDate DATETIME DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1
)
GO

-- Adres Tablosu
CREATE TABLE Addresses (
    AddressID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    AddressTitle NVARCHAR(50),
    Country NVARCHAR(50),
    City NVARCHAR(50),
    District NVARCHAR(50),
    PostalCode NVARCHAR(10),
    AddressText NVARCHAR(500),
    IsDefault BIT DEFAULT 0
)
GO

-- Sipariş Tablosu
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    OrderDate DATETIME DEFAULT GETDATE(),
    AddressID INT FOREIGN KEY REFERENCES Addresses(AddressID),
    TotalAmount DECIMAL(18,2),
    OrderStatus NVARCHAR(20)
)
GO

-- Sipariş Detay Tablosu
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    UnitPrice DECIMAL(18,2),
    Quantity INT,
    Discount DECIMAL(18,2) DEFAULT 0
)
GO

-- Örnek Veriler

-- Kategoriler
INSERT INTO Categories (CategoryName, Description) VALUES
('Elektronik', 'Elektronik ürünler'),
('Giyim', 'Giyim ürünleri'),
('Kitap', 'Kitaplar'),
('Ev & Yaşam', 'Ev ve yaşam ürünleri')
GO

-- Ürünler
INSERT INTO Products (ProductName, CategoryID, UnitPrice, UnitsInStock, Description) VALUES
('Laptop', 1, 15000.00, 50, 'Yüksek performanslı laptop'),
('T-Shirt', 2, 150.00, 100, 'Pamuklu t-shirt'),
('Roman', 3, 45.00, 200, 'Çok satan roman'),
('Kahve Makinesi', 4, 2500.00, 30, 'Otomatik kahve makinesi')
GO

-- Stored Procedure Örnekleri

-- Ürün Listesi
CREATE PROCEDURE sp_GetProducts
AS
BEGIN
    SELECT 
        p.ProductID,
        p.ProductName,
        c.CategoryName,
        p.UnitPrice,
        p.UnitsInStock
    FROM Products p
    INNER JOIN Categories c ON p.CategoryID = c.CategoryID
    WHERE p.IsActive = 1
END
GO

-- Kategori Bazlı Ürün Sayısı
CREATE PROCEDURE sp_GetProductCountByCategory
AS
BEGIN
    SELECT 
        c.CategoryName,
        COUNT(p.ProductID) as ProductCount
    FROM Categories c
    LEFT JOIN Products p ON c.CategoryID = p.CategoryID
    GROUP BY c.CategoryName
END
GO 
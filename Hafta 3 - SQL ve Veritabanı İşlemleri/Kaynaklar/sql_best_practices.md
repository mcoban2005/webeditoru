# SQL Best Practices ve Performans Optimizasyonu

## 1. Sorgu Yazım Kuralları

### Genel Kurallar
- Anlamlı tablo ve sütun isimleri kullanın
- Tutarlı bir yazım stili benimseyin
- Sorgularınızı düzgün girintileyin
- Yorum satırları ekleyin

### İyi Örnek:
```sql
-- Aktif müşterilerin siparişlerini getir
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    o.OrderDate,
    o.TotalAmount
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.IsActive = 1
ORDER BY o.OrderDate DESC;
```

### Kötü Örnek:
```sql
select c.customerid,c.firstname,c.lastname,o.orderdate,o.totalamount from customers c join orders o on c.customerid=o.customerid where c.isactive=1 order by o.orderdate desc;
```

## 2. Performans İyileştirme

### İndeks Kullanımı
- Sık sorgulanan sütunlara indeks ekleyin
- Birleştirme (JOIN) yapılan sütunları indeksleyin
- Çok fazla indeks kullanmaktan kaçının
- İndeksleri düzenli olarak bakımdan geçirin

```sql
-- İndeks oluşturma
CREATE INDEX IX_Products_CategoryID ON Products(CategoryID);

-- Bileşik indeks
CREATE INDEX IX_Orders_CustomerID_OrderDate 
ON Orders(CustomerID, OrderDate);
```

### Sorgu Optimizasyonu
1. SELECT * kullanmaktan kaçının
2. WHERE koşullarını optimize edin
3. JOIN işlemlerini minimize edin
4. Gereksiz subquery'lerden kaçının

```sql
-- İyi örnek
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE CategoryID = 1;

-- Kötü örnek
SELECT *
FROM Products
WHERE CategoryID IN (SELECT CategoryID FROM Categories);
```

## 3. Transaction Yönetimi

### Transaction Kuralları
- Kritik işlemleri transaction içine alın
- Transaction süresini minimum tutun
- Nested transaction'lardan kaçının
- Hata yönetimini unutmayın

```sql
BEGIN TRY
    BEGIN TRANSACTION;
        -- İşlemler
        COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    -- Hata işleme
END CATCH
```

## 4. Güvenlik Önlemleri

### SQL Injection Önleme
- Parametreli sorgular kullanın
- Kullanıcı girdilerini doğrulayın
- Stored Procedure'leri tercih edin

```sql
-- İyi örnek (Parametreli sorgu)
DECLARE @ProductName NVARCHAR(50) = @UserInput;
SELECT * FROM Products WHERE ProductName = @ProductName;

-- Kötü örnek (SQL Injection riski)
SELECT * FROM Products WHERE ProductName = '" + userInput + "'";
```

## 5. Bakım ve Dokümantasyon

### Düzenli Bakım
- İstatistikleri güncelleyin
- İndeksleri yeniden organize edin
- Log dosyalarını temizleyin
- Yedekleme planı oluşturun

```sql
-- İstatistik güncelleme
UPDATE STATISTICS Products;

-- İndeks bakımı
ALTER INDEX ALL ON Products REBUILD;
```

### Dokümantasyon
- Karmaşık sorguları açıklayın
- Stored Procedure parametrelerini belgeleyin
- Değişiklikleri kaydedin
- Performans metriklerini takip edin

## 6. Veritabanı Tasarımı

### Normalizasyon
- Uygun normalizasyon seviyesini belirleyin
- Gereksiz veri tekrarından kaçının
- İlişkileri doğru tanımlayın

### Veri Tipleri
- Uygun veri tiplerini seçin
- VARCHAR vs NVARCHAR kararını doğru verin
- Tarih/saat tiplerini standartlaştırın

## 7. Hata Yönetimi

### Try-Catch Blokları
```sql
BEGIN TRY
    -- SQL kodları
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage,
        ERROR_LINE() AS ErrorLine;
END CATCH
```

### Logging
```sql
CREATE TABLE ErrorLog (
    ErrorLogID INT IDENTITY(1,1),
    ErrorTime DATETIME DEFAULT GETDATE(),
    ErrorNumber INT,
    ErrorMessage NVARCHAR(MAX),
    ErrorLine INT
);
``` 
# Hafta 3 Ödevleri

## Pratik Ödev: SQL Sorguları

### 1. Ürün Listeleme ve Filtreleme Sorguları
Aşağıdaki sorguları yazın:
- Kategoriye göre ürün listesi
- Fiyat aralığına göre ürünler
- Stok durumuna göre ürünler
- En çok satılan ürünler
- İndirimli ürünler

### 2. Sipariş Raporlama Sorguları
Aşağıdaki raporları oluşturun:
- Günlük/Haftalık/Aylık satış raporları
- Müşteri bazlı sipariş raporları
- Kategori bazlı satış raporları
- Ödeme yöntemine göre sipariş raporları
- İade/İptal raporları

### 3. Stok Takip Sorguları
Aşağıdaki stok sorgularını yazın:
- Kritik stok seviyesindeki ürünler
- Stok hareket raporu
- Ürün bazlı stok geçmişi
- Depo bazlı stok durumu
- Stok maliyeti raporu

### 4. Müşteri Analiz Sorguları
Aşağıdaki analizleri yapın:
- En çok alışveriş yapan müşteriler
- Müşteri segmentasyonu
- Müşteri satın alma davranışları
- Müşteri sadakat analizi
- Kayıp müşteri analizi

## Küçük Proje: Stored Procedure ve Trigger'lar

### 1. Sipariş İşleme Stored Procedure'ü
```sql
CREATE PROCEDURE sp_ProcessOrder
    @UserID INT,
    @AddressID INT,
    @PaymentMethod VARCHAR(50)
AS
BEGIN
    -- Sipariş işleme adımları
    -- Stok kontrolü
    -- Sipariş oluşturma
    -- Ödeme işlemi
    -- Stok güncelleme
END
```

### 2. Stok Güncelleme Trigger'ı
```sql
CREATE TRIGGER tr_UpdateStock
ON OrderDetails
AFTER INSERT
AS
BEGIN
    -- Stok güncelleme işlemleri
    -- Kritik stok kontrolü
    -- Bildirim gönderme
END
```

### 3. Sipariş Durumu Güncelleme Procedure'ü
```sql
CREATE PROCEDURE sp_UpdateOrderStatus
    @OrderID INT,
    @NewStatus VARCHAR(50)
AS
BEGIN
    -- Durum güncelleme
    -- Log kayıtları
    -- Bildirim gönderme
END
```

### 4. Raporlama Stored Procedure'leri
```sql
-- Satış Raporu
CREATE PROCEDURE sp_SalesReport
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    -- Satış istatistikleri
    -- Ürün performansı
    -- Kategori analizi
END

-- Stok Raporu
CREATE PROCEDURE sp_StockReport
AS
BEGIN
    -- Stok durumu
    -- Kritik seviyeler
    -- Stok maliyeti
END
```

### Teslim
- SQL script dosyaları
- Test senaryoları
- Örnek çıktılar
- Performans analizi 
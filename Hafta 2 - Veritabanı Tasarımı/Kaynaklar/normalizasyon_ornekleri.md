# Veritabanı Normalizasyon Örnekleri

## Normalizasyon Nedir?
Normalizasyon, veritabanı tasarımında veri tekrarını önlemek ve veri tutarlılığını sağlamak için kullanılan bir tekniktir.

## 1NF (Birinci Normal Form)
- Atomik değerler (her hücrede tek bir değer)
- Tekrar eden gruplar olmamalı
- Primary Key tanımlanmalı

### Örnek:
**Normalize Edilmemiş Tablo:**
```
| SiparisID | Musteri      | Urunler                    |
|-----------|--------------|----------------------------|
| 1         | Ali Yılmaz   | Laptop, Mouse, Klavye     |
| 2         | Ayşe Demir   | Monitor, Laptop           |
```

**1NF Uygulanmış Hali:**
```
| SiparisID | Musteri      | Urun    |
|-----------|--------------|---------|
| 1         | Ali Yılmaz   | Laptop  |
| 1         | Ali Yılmaz   | Mouse   |
| 1         | Ali Yılmaz   | Klavye  |
| 2         | Ayşe Demir   | Monitor |
| 2         | Ayşe Demir   | Laptop  |
```

## 2NF (İkinci Normal Form)
- 1NF'de olmalı
- Kısmi bağımlılıklar olmamalı
- Non-prime öznitelikler, primary key'e tam bağımlı olmalı

### Örnek:
**1NF Tablo:**
```
| OgrenciNo | DersKodu | DersAdi      | Ogretmen     | Not |
|-----------|----------|--------------|--------------|-----|
| 101       | MAT101   | Matematik    | Ahmet Hoca   | 85  |
| 102       | MAT101   | Matematik    | Ahmet Hoca   | 90  |
```

**2NF Uygulanmış Hali:**
```
Ogrenci_Ders:
| OgrenciNo | DersKodu | Not |
|-----------|----------|-----|
| 101       | MAT101   | 85  |
| 102       | MAT101   | 90  |

Ders:
| DersKodu | DersAdi   | Ogretmen   |
|----------|-----------|------------|
| MAT101   | Matematik | Ahmet Hoca |
```

## 3NF (Üçüncü Normal Form)
- 2NF'de olmalı
- Geçişli bağımlılıklar olmamalı
- Non-prime öznitelikler birbirine bağımlı olmamalı

### Örnek:
**2NF Tablo:**
```
| SiparisID | MusteriID | MusteriAdi | MusteriSehir | SiparisTarihi |
|-----------|-----------|------------|--------------|---------------|
| 1         | 101       | Ali Yılmaz | İstanbul     | 2024-02-24   |
| 2         | 101       | Ali Yılmaz | İstanbul     | 2024-02-25   |
```

**3NF Uygulanmış Hali:**
```
Siparis:
| SiparisID | MusteriID | SiparisTarihi |
|-----------|-----------|---------------|
| 1         | 101       | 2024-02-24   |
| 2         | 101       | 2024-02-25   |

Musteri:
| MusteriID | MusteriAdi | MusteriSehir |
|-----------|------------|--------------|
| 101       | Ali Yılmaz | İstanbul     |
```

## BCNF (Boyce-Codd Normal Form)
- 3NF'nin daha sıkı bir versiyonu
- Her belirleyici aday anahtar olmalı

### Örnek:
**3NF Tablo:**
```
| OgretmenID | Ders     | Sinif |
|------------|----------|-------|
| 1          | Fizik    | 10-A  |
| 2          | Kimya    | 10-B  |
```

**BCNF Uygulanmış Hali:**
```
Ogretmen_Ders:
| OgretmenID | Ders  |
|------------|-------|
| 1          | Fizik |
| 2          | Kimya |

Ders_Sinif:
| Ders  | Sinif |
|-------|-------|
| Fizik | 10-A  |
| Kimya | 10-B  |
```

## Denormalizasyon
Bazı durumlarda performans için normalizasyon kurallarından taviz verilebilir:

### Örnek:
```sql
-- Normalize edilmiş hali
SELECT o.OrderID, o.OrderDate, c.CustomerName, p.ProductName, od.Quantity
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID

-- Denormalize edilmiş hali
SELECT OrderID, OrderDate, CustomerName, ProductName, Quantity
FROM OrdersView
```

## Best Practices
1. Önce normalize edin
2. Performans sorunlarını ölçün
3. Gerekirse denormalize edin
4. Veri tutarlılığını koruyun
5. Düzenli bakım yapın 
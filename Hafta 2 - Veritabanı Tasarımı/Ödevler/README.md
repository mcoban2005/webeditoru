# Hafta 2 Ödevleri

## Pratik Ödev: E-ticaret Veritabanı Tasarımı

### 1. ER Diyagramı
E-ticaret sistemi için ER (Entity-Relationship) diyagramı oluşturun:
- Tüm varlıkları (entities) belirleyin
- İlişkileri (relationships) tanımlayın
- Kardinaliteleri belirleyin
- Öznitelikleri (attributes) ekleyin

### 2. Tablo ve İlişki Tasarımı
Aşağıdaki tabloları ve ilişkilerini tasarlayın:
- Kullanıcılar (Users)
- Ürünler (Products)
- Kategoriler (Categories)
- Siparişler (Orders)
- Sepet (Cart)
- Adresler (Addresses)
- Ödemeler (Payments)
- Yorumlar (Reviews)
- Favoriler (Favorites)

Her tablo için:
- Primary Key
- Foreign Keys
- Sütunlar ve veri tipleri
- Kısıtlamalar (constraints)
- İndeksler

### 3. Normalizasyon
Tasarladığınız tabloları normalize edin:
- 1NF (Birinci Normal Form)
- 2NF (İkinci Normal Form)
- 3NF (Üçüncü Normal Form)
- Denormalizasyon gereken durumları belirleyin

### 4. Veritabanı Güvenlik Planı
Veritabanı güvenliği için:
- Kullanıcı yetkilendirme planı
- Veri şifreleme stratejisi
- Yedekleme planı
- Güvenlik duvarı kuralları
- Audit (denetim) planı

## Küçük Proje: E-ticaret Veritabanı Oluşturma

### Gereksinimler
1. SQL Server veya MySQL kurulumu
2. Management Studio veya Workbench kurulumu
3. Örnek veri seti

### Adımlar
1. Veritabanını oluşturun
   ```sql
   CREATE DATABASE ECommerceDB
   ```

2. Temel tabloları oluşturun
   - Users tablosu
   - Products tablosu
   - Categories tablosu
   - Orders tablosu

3. İlişkileri tanımlayın
   - Foreign key constraints
   - Cascade rules

4. Örnek veriler ekleyin
   - Her tabloya en az 5 kayıt
   - İlişkili kayıtlar

5. Temel sorguları yazın
   - Ürün listesi
   - Kategori bazlı ürünler
   - Kullanıcı siparişleri
   - Satış raporları

### Teslim
- SQL script dosyaları
- ER diyagramı
- Örnek sorgular
- Dokümantasyon 
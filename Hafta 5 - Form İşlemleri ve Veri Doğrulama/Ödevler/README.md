# Hafta 5 Ödevleri

## Pratik Ödev: E-ticaret Form Sayfaları

### 1. Kullanıcı Kayıt Formu
```csharp
public class KullaniciKayitModel
{
    // Gerekli alanlar
    [Required(ErrorMessage = "Kullanıcı adı zorunludur")]
    public string KullaniciAdi { get; set; }
    [Required(ErrorMessage = "E-posta zorunludur"), EmailAddress]
    public string Eposta { get; set; }
    [Required(ErrorMessage = "Şifre zorunludur"), MinLength(6)]
    public string Sifre { get; set; }
    // Diğer alanlar...

    // Doğrulama metodları
    public bool SifreDogrula()
    public bool EpostaKontrol()
}
```

### 2. Ürün Ekleme Formu
```csharp
public class UrunModel
{
    [Required(ErrorMessage = "Ürün adı zorunludur")]
    public string Ad { get; set; }
    [Required(ErrorMessage = "Fiyat zorunludur")]
    public decimal Fiyat { get; set; }
    [Required(ErrorMessage = "Kategori seçimi zorunludur")]
    public int KategoriId { get; set; }
    public string Aciklama { get; set; }
    public IFormFile Resim { get; set; }
    // Diğer alanlar...

    // Doğrulama metodları
    public bool ResimDogrula()
    public bool FiyatKontrol()
}
```

### 3. Sipariş Formu
```csharp
public class SiparisModel
{
    [Required(ErrorMessage = "Kullanıcı seçimi zorunludur")]
    public int KullaniciId { get; set; }
    [Required(ErrorMessage = "Adres seçimi zorunludur")]
    public int AdresId { get; set; }
    [Required(ErrorMessage = "Ödeme yöntemi seçimi zorunludur")]
    public string OdemeYontemi { get; set; }
    public List<SiparisKalem> Kalemler { get; set; }
    // Diğer alanlar...

    // Doğrulama metodları
    public bool StokKontrol()
    public bool OdemeYontemiKontrol()
}
```

### 4. İletişim Formu
```csharp
public class IletisimModel
{
    [Required(ErrorMessage = "Ad zorunludur")]
    public string Ad { get; set; }
    [Required(ErrorMessage = "E-posta zorunludur"), EmailAddress]
    public string Eposta { get; set; }
    [Required(ErrorMessage = "Konu zorunludur")]
    public string Konu { get; set; }
    [Required(ErrorMessage = "Mesaj zorunludur")]
    public string Mesaj { get; set; }

    // Doğrulama metodları
    public bool MesajDogrula()
    public bool SpamKontrol()
}
```

### 5. Profil Güncelleme Formu
```csharp
public class ProfilModel
{
    public string KullaniciAdi { get; set; }
    [EmailAddress(ErrorMessage = "Geçerli bir e-posta adresi giriniz")]
    public string Eposta { get; set; }
    public string MevcutSifre { get; set; }
    public string YeniSifre { get; set; }
    public string Adres { get; set; }
    // Diğer alanlar...

    // Doğrulama metodları
    public bool MevcutSifreDogrula()
    public bool YeniSifreDogrula()
}
```

## Küçük Proje: Form İşlemleri

### 1. Kullanıcı Yönetimi Formları
- Kayıt formu ve doğrulamaları
- Giriş formu ve güvenlik kontrolleri
- Şifre sıfırlama formu ve doğrulamaları
- Profil düzenleme formu ve kontrolleri
- Adres yönetimi formu ve doğrulamaları

### 2. Ürün Yönetimi Formları
- Ürün ekleme formu ve doğrulamaları
- Ürün düzenleme formu ve kontrolleri
- Kategori yönetimi formu ve doğrulamaları
- Stok güncelleme formu ve kontrolleri
- Toplu ürün yükleme formu ve doğrulamaları

### 3. Sipariş Yönetimi Formları
- Sipariş oluşturma formu ve doğrulamaları
- Sipariş düzenleme formu ve kontrolleri
- Sipariş durumu güncelleme formu
- İade/iptal formu ve doğrulamaları
- Kargo takip formu ve kontrolleri

### 4. Raporlama Formları
- Tarih aralığı seçim formu ve doğrulamaları
- Filtre formu ve kontrolleri
- Rapor parametreleri formu
- Excel/PDF dışa aktarma formu
- E-posta gönderim formu ve doğrulamaları

### Gereksinimler
1. İstemci Tarafı Doğrulama
   - jQuery Validation kullanımı
   - Özel doğrulama kuralları
   - Anlık doğrulama kontrolleri
   - Hata mesajları yönetimi

2. Sunucu Tarafı Doğrulama
   - Veri doğrulama özellikleri
   - Özel doğrulama özellikleri
   - Model doğrulama işlemleri
   - Hata yönetimi

3. AJAX İşlemleri
   - Form gönderimi
   - Kısmi sayfa güncellemeleri
   - Eşzamansız doğrulama
   - Dosya yükleme

4. Güvenlik
   - CSRF koruması
   - XSS önleme
   - Girdi temizleme
   - İstek sınırlama

### Teslim Edilecekler
- Form kodları ve açıklamaları
- Doğrulama sınıfları ve kontrolleri
- JavaScript dosyaları ve işlevleri
- Test senaryoları ve sonuçları
- Kullanım kılavuzu ve dokümantasyon 
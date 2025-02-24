# C# Programlama Temelleri

## 1. Temel Kavramlar

### Değişkenler ve Veri Tipleri
```csharp
// Değişken tanımlama
int sayi = 42;
string metin = "Merhaba";
bool durum = true;
double ondalik = 3.14;
decimal para = 29.99m;

// Var keyword
var isim = "Ahmet"; // string
var yas = 25;       // int
```

### Operatörler
```csharp
// Aritmetik operatörler
int a = 10 + 5;  // Toplama
int b = 10 - 5;  // Çıkarma
int c = 10 * 5;  // Çarpma
int d = 10 / 5;  // Bölme
int e = 10 % 3;  // Mod alma

// Karşılaştırma operatörleri
bool esitMi = (a == b);
bool buyukMu = (a > b);
bool kucukMu = (a < b);
```

### Kontrol Yapıları
```csharp
// If-else
if (yas >= 18)
{
    Console.WriteLine("Yetişkin");
}
else
{
    Console.WriteLine("Çocuk");
}

// Switch
switch (gun)
{
    case "Pazartesi":
        Console.WriteLine("İş günü");
        break;
    case "Cumartesi":
    case "Pazar":
        Console.WriteLine("Hafta sonu");
        break;
    default:
        Console.WriteLine("Geçersiz gün");
        break;
}
```

## 2. Diziler ve Koleksiyonlar

### Diziler
```csharp
// Dizi tanımlama
int[] sayilar = new int[5];
string[] isimler = { "Ali", "Veli", "Ayşe" };

// Dizi işlemleri
sayilar[0] = 10;
int uzunluk = sayilar.Length;
Array.Sort(sayilar);
```

### List<T>
```csharp
// Liste oluşturma
List<string> sehirler = new List<string>();
sehirler.Add("İstanbul");
sehirler.Add("Ankara");

// Liste işlemleri
sehirler.Remove("Ankara");
bool varMi = sehirler.Contains("İstanbul");
int adet = sehirler.Count;
```

### Dictionary<TKey, TValue>
```csharp
// Dictionary oluşturma
Dictionary<int, string> ogrenciler = new Dictionary<int, string>();
ogrenciler.Add(101, "Ali");
ogrenciler.Add(102, "Veli");

// Dictionary işlemleri
string ogrenci = ogrenciler[101];
bool varMi = ogrenciler.ContainsKey(101);
ogrenciler.Remove(102);
```

## 3. Nesne Yönelimli Programlama

### Sınıf Tanımlama
```csharp
public class Ogrenci
{
    // Özellikler
    public int Id { get; set; }
    public string Ad { get; set; }
    public string Soyad { get; set; }
    
    // Constructor
    public Ogrenci(int id, string ad, string soyad)
    {
        Id = id;
        Ad = ad;
        Soyad = soyad;
    }
    
    // Metod
    public string TamAd()
    {
        return $"{Ad} {Soyad}";
    }
}
```

### Kalıtım
```csharp
public class Kisi
{
    public string Ad { get; set; }
    public string Soyad { get; set; }
}

public class Ogrenci : Kisi
{
    public int OgrenciNo { get; set; }
}
```

### Interface
```csharp
public interface IRepository<T>
{
    void Ekle(T entity);
    void Sil(T entity);
    void Guncelle(T entity);
    T Getir(int id);
    List<T> TumunuGetir();
}
```

## 4. Hata Yönetimi

### Try-Catch
```csharp
try
{
    int sayi = int.Parse("abc");
}
catch (FormatException ex)
{
    Console.WriteLine("Sayı formatı hatalı!");
}
catch (Exception ex)
{
    Console.WriteLine($"Bir hata oluştu: {ex.Message}");
}
finally
{
    Console.WriteLine("İşlem tamamlandı.");
}
```

### Custom Exception
```csharp
public class YetersizBakiyeException : Exception
{
    public YetersizBakiyeException() : base("Yetersiz bakiye!")
    {
    }

    public YetersizBakiyeException(string message) : base(message)
    {
    }
}
```

## 5. LINQ

### LINQ Sorguları
```csharp
// LINQ to Objects
var sayilar = new List<int> { 1, 2, 3, 4, 5 };

// Query syntax
var ciftSayilar = from sayi in sayilar
                  where sayi % 2 == 0
                  select sayi;

// Method syntax
var tekSayilar = sayilar.Where(x => x % 2 == 1);
```

### LINQ Operatörleri
```csharp
// Filtreleme
var buyukSayilar = sayilar.Where(x => x > 3);

// Sıralama
var siraliSayilar = sayilar.OrderBy(x => x);

// Gruplama
var grupluSayilar = sayilar.GroupBy(x => x % 2);

// Toplama
var toplam = sayilar.Sum();
var ortalama = sayilar.Average();
```

## 6. Dosya İşlemleri

### Metin Dosyası
```csharp
// Dosya yazma
File.WriteAllText("dosya.txt", "Merhaba Dünya");
File.WriteAllLines("dosya.txt", new[] { "Satır 1", "Satır 2" });

// Dosya okuma
string icerik = File.ReadAllText("dosya.txt");
string[] satirlar = File.ReadAllLines("dosya.txt");
```

### Stream Kullanımı
```csharp
using (StreamWriter writer = new StreamWriter("dosya.txt"))
{
    writer.WriteLine("Merhaba");
    writer.WriteLine("Dünya");
}

using (StreamReader reader = new StreamReader("dosya.txt"))
{
    string satir;
    while ((satir = reader.ReadLine()) != null)
    {
        Console.WriteLine(satir);
    }
}
``` 
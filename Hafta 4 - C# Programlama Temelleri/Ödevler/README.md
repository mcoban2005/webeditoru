# Hafta 4 Ödevleri

## Pratik Ödev: E-ticaret Sınıfları

### 1. Product Sınıfı
```csharp
public class Product
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string Description { get; set; }
    public decimal Price { get; set; }
    public int Stock { get; set; }
    public int CategoryId { get; set; }
    public bool IsActive { get; set; }
    public DateTime CreatedDate { get; set; }
    
    // Metodlar
    public void UpdateStock(int quantity)
    public bool CheckStock(int quantity)
    public void ApplyDiscount(decimal percentage)
}
```

### 2. Category Sınıfı
```csharp
public class Category
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string Description { get; set; }
    public bool IsActive { get; set; }
    public List<Product> Products { get; set; }
    
    // Metodlar
    public void AddProduct(Product product)
    public void RemoveProduct(int productId)
    public List<Product> GetActiveProducts()
}
```

### 3. User Sınıfı
```csharp
public class User
{
    public int Id { get; set; }
    public string Username { get; set; }
    public string Email { get; set; }
    public string PasswordHash { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public List<Address> Addresses { get; set; }
    public List<Order> Orders { get; set; }
    
    // Metodlar
    public bool ValidatePassword(string password)
    public void AddAddress(Address address)
    public void UpdateProfile(UserProfile profile)
}
```

### 4. Order Sınıfı
```csharp
public class Order
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public DateTime OrderDate { get; set; }
    public string Status { get; set; }
    public decimal TotalAmount { get; set; }
    public List<OrderDetail> OrderDetails { get; set; }
    
    // Metodlar
    public void AddItem(Product product, int quantity)
    public void UpdateStatus(string status)
    public decimal CalculateTotal()
}
```

### 5. ShoppingCart Sınıfı
```csharp
public class ShoppingCart
{
    public int UserId { get; set; }
    public List<CartItem> Items { get; set; }
    public decimal TotalAmount { get; set; }
    
    // Metodlar
    public void AddItem(Product product, int quantity)
    public void RemoveItem(int productId)
    public void UpdateQuantity(int productId, int quantity)
    public void Clear()
    public Order CreateOrder()
}
```

## Küçük Proje: Konsol E-ticaret Uygulaması

### Gereksinimler
1. Yukarıdaki sınıfları implement edin
2. Exception handling ekleyin
3. LINQ sorgularını kullanın
4. Dosya işlemleri ile veri saklayın

### Özellikler
1. Ürün Yönetimi
   - Ürün listeleme
   - Ürün arama
   - Ürün filtreleme
   - Stok kontrolü

2. Sepet İşlemleri
   - Ürün ekleme/çıkarma
   - Miktar güncelleme
   - Toplam hesaplama
   - Sepeti temizleme

3. Sipariş İşlemleri
   - Sipariş oluşturma
   - Sipariş görüntüleme
   - Sipariş durumu güncelleme

4. Kullanıcı İşlemleri
   - Kayıt olma
   - Giriş yapma
   - Profil güncelleme
   - Adres yönetimi

### Teslim
- Kaynak kodlar
- UML sınıf diyagramı
- Test senaryoları
- Kullanım kılavuzu 
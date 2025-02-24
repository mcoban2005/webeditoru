using System;
using System.Collections.Generic;
using System.Linq;

namespace ECommerce
{
    // Ürün sınıfı
    public class Product
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public int Stock { get; set; }
        public int CategoryId { get; set; }

        public override string ToString()
        {
            return $"[{Id}] {Name} - {Price:C} (Stok: {Stock})";
        }
    }

    // Kategori sınıfı
    public class Category
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
    }

    // Sepet sınıfı
    public class ShoppingCart
    {
        private List<CartItem> _items = new List<CartItem>();

        public void AddItem(Product product, int quantity)
        {
            var existingItem = _items.FirstOrDefault(i => i.Product.Id == product.Id);
            if (existingItem != null)
            {
                existingItem.Quantity += quantity;
            }
            else
            {
                _items.Add(new CartItem { Product = product, Quantity = quantity });
            }
        }

        public void RemoveItem(int productId)
        {
            var item = _items.FirstOrDefault(i => i.Product.Id == productId);
            if (item != null)
            {
                _items.Remove(item);
            }
        }

        public decimal GetTotal()
        {
            return _items.Sum(item => item.Product.Price * item.Quantity);
        }

        public void Clear()
        {
            _items.Clear();
        }

        public void DisplayCart()
        {
            Console.WriteLine("\nSepetiniz:");
            Console.WriteLine("------------------");
            foreach (var item in _items)
            {
                Console.WriteLine($"{item.Product.Name} x {item.Quantity} = {item.Product.Price * item.Quantity:C}");
            }
            Console.WriteLine("------------------");
            Console.WriteLine($"Toplam: {GetTotal():C}");
        }
    }

    // Sepet öğesi sınıfı
    public class CartItem
    {
        public Product Product { get; set; }
        public int Quantity { get; set; }
    }

    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                // Örnek ürünler oluştur
                var products = new List<Product>
                {
                    new Product { Id = 1, Name = "Laptop", Price = 15000, Stock = 10, CategoryId = 1 },
                    new Product { Id = 2, Name = "Mouse", Price = 200, Stock = 50, CategoryId = 1 },
                    new Product { Id = 3, Name = "Klavye", Price = 300, Stock = 30, CategoryId = 1 }
                };

                // Sepet oluştur
                var cart = new ShoppingCart();

                while (true)
                {
                    Console.WriteLine("\nE-Ticaret Uygulaması");
                    Console.WriteLine("1. Ürünleri Listele");
                    Console.WriteLine("2. Sepete Ürün Ekle");
                    Console.WriteLine("3. Sepeti Görüntüle");
                    Console.WriteLine("4. Sepeti Temizle");
                    Console.WriteLine("5. Çıkış");
                    Console.Write("Seçiminiz: ");

                    var choice = Console.ReadLine();

                    switch (choice)
                    {
                        case "1":
                            Console.WriteLine("\nÜrün Listesi:");
                            foreach (var product in products)
                            {
                                Console.WriteLine(product);
                            }
                            break;

                        case "2":
                            Console.Write("\nÜrün ID: ");
                            if (int.TryParse(Console.ReadLine(), out int productId))
                            {
                                var product = products.FirstOrDefault(p => p.Id == productId);
                                if (product != null)
                                {
                                    Console.Write("Miktar: ");
                                    if (int.TryParse(Console.ReadLine(), out int quantity))
                                    {
                                        if (quantity <= product.Stock)
                                        {
                                            cart.AddItem(product, quantity);
                                            Console.WriteLine("Ürün sepete eklendi!");
                                        }
                                        else
                                        {
                                            Console.WriteLine("Yetersiz stok!");
                                        }
                                    }
                                }
                                else
                                {
                                    Console.WriteLine("Ürün bulunamadı!");
                                }
                            }
                            break;

                        case "3":
                            cart.DisplayCart();
                            break;

                        case "4":
                            cart.Clear();
                            Console.WriteLine("Sepet temizlendi!");
                            break;

                        case "5":
                            return;

                        default:
                            Console.WriteLine("Geçersiz seçim!");
                            break;
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Bir hata oluştu: {ex.Message}");
            }
        }
    }
} 
# Form Doğrulama ve En İyi Uygulamalar

## 1. İstemci Tarafında Doğrulama

### jQuery ile Doğrulama
```javascript
$(document).ready(function() {
    $("#kayitFormu").validate({
        rules: {
            kullaniciAdi: {
                required: true,
                minlength: 3
            },
            eposta: {
                required: true,
                email: true
            },
            sifre: {
                required: true,
                minlength: 6
            }
        },
        messages: {
            kullaniciAdi: {
                required: "Kullanıcı adı zorunludur",
                minlength: "En az 3 karakter olmalıdır"
            },
            eposta: {
                required: "E-posta adresi zorunludur",
                email: "Geçerli bir e-posta adresi giriniz"
            }
        }
    });
});
```

### Özel Doğrulama Kuralları
```javascript
$.validator.addMethod("telefonTurkiye", function(value, element) {
    return this.optional(element) || /^(\+90|0)?[0-9]{10}$/.test(value);
}, "Geçerli bir telefon numarası giriniz");

$.validator.addMethod("guvenliSifre", function(value, element) {
    return this.optional(element) || 
           /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/.test(value);
}, "Şifre en az bir büyük harf, bir küçük harf, bir rakam ve bir özel karakter içermelidir");
```

## 2. Sunucu Tarafında Doğrulama

### Veri Doğrulama Özellikleri
```csharp
public class KullaniciModel
{
    [Required(ErrorMessage = "Ad alanı zorunludur")]
    [StringLength(50, MinimumLength = 2)]
    public string Ad { get; set; }

    [Required(ErrorMessage = "Soyad alanı zorunludur")]
    [StringLength(50, MinimumLength = 2)]
    public string Soyad { get; set; }

    [Required(ErrorMessage = "E-posta alanı zorunludur")]
    [EmailAddress(ErrorMessage = "Geçerli bir e-posta adresi giriniz")]
    public string Eposta { get; set; }

    [Required(ErrorMessage = "Şifre alanı zorunludur")]
    [StringLength(100, MinimumLength = 6)]
    [DataType(DataType.Password)]
    public string Sifre { get; set; }
}
```

### Özel Doğrulama Özellikleri
```csharp
public class MinimumYasAttribute : ValidationAttribute
{
    private readonly int _minimumYas;

    public MinimumYasAttribute(int minimumYas)
    {
        _minimumYas = minimumYas;
    }

    protected override ValidationResult IsValid(object value, ValidationContext validationContext)
    {
        if (value is DateTime tarih)
        {
            if (DateTime.Today.AddYears(-_minimumYas) >= tarih)
            {
                return ValidationResult.Success;
            }
        }

        return new ValidationResult($"Minimum yaş {_minimumYas} olmalıdır");
    }
}
```

## 3. AJAX Form Gönderimi

### Form Gönderme
```javascript
$("#kayitFormu").submit(function(e) {
    e.preventDefault();
    
    if ($(this).valid()) {
        $.ajax({
            url: '/Hesap/Kayit',
            type: 'POST',
            data: $(this).serialize(),
            success: function(response) {
                if (response.basarili) {
                    basariMesajiGoster("Kayıt başarılı!");
                } else {
                    hataMesajiGoster(response.mesaj);
                }
            },
            error: function(xhr) {
                hataMesajiGoster("Bir hata oluştu!");
            }
        });
    }
});
```

### Dosya Yükleme
```javascript
function dosyaYukle() {
    var formData = new FormData();
    formData.append('dosya', $('#dosyaGirisi')[0].files[0]);

    $.ajax({
        url: '/api/yukle',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            basariMesajiGoster("Dosya yüklendi!");
        },
        error: function(xhr) {
            hataMesajiGoster("Yükleme başarısız!");
        }
    });
}
```

## 4. Hata Yönetimi

### Kontrolcü Hata Yönetimi
```csharp
[HttpPost]
public IActionResult Kayit(KullaniciKayitModel model)
{
    try
    {
        if (!ModelState.IsValid)
        {
            return View(model);
        }

        // İş mantığı...
        
        return RedirectToAction("Basarili");
    }
    catch (EpostaKullanimdaException ex)
    {
        ModelState.AddModelError("Eposta", "Bu e-posta adresi zaten kullanımda");
        return View(model);
    }
    catch (Exception ex)
    {
        _logger.LogError(ex, "Kayıt işlemi sırasında hata");
        ModelState.AddModelError("", "Bir hata oluştu. Lütfen tekrar deneyin.");
        return View(model);
    }
}
```

### Genel Hata Yönetimi
```csharp
public class HataYonetimiMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger<HataYonetimiMiddleware> _logger;

    public HataYonetimiMiddleware(RequestDelegate next, ILogger<HataYonetimiMiddleware> logger)
    {
        _next = next;
        _logger = logger;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        try
        {
            await _next(context);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Beklenmeyen hata");
            await HataYonetAsync(context, ex);
        }
    }

    private static Task HataYonetAsync(HttpContext context, Exception ex)
    {
        context.Response.ContentType = "application/json";
        context.Response.StatusCode = StatusCodes.Status500InternalServerError;

        return context.Response.WriteAsync(new HataCevap
        {
            StatusKodu = context.Response.StatusCode,
            Mesaj = "Sunucu Hatası"
        }.ToString());
    }
}
```

## 5. Güvenlik En İyi Uygulamaları

### CSRF Koruması
```csharp
public void ConfigureServices(IServiceCollection services)
{
    services.AddAntiforgery(options => 
    {
        options.Cookie.Name = "X-CSRF-TOKEN";
        options.HeaderName = "X-CSRF-TOKEN";
    });
}
```

### XSS Önleme
```csharp
public void ConfigureServices(IServiceCollection services)
{
    services.AddControllersWithViews(options =>
    {
        options.Filters.Add(new AutoValidateAntiforgeryTokenAttribute());
    });
}
```

### Girdi Temizleme
```csharp
public static string GirdiTemizle(string girdi)
{
    if (string.IsNullOrEmpty(girdi))
        return girdi;

    // HTML kodlarını temizle
    girdi = HttpUtility.HtmlEncode(girdi);

    // Tehlikeli karakterleri temizle
    girdi = Regex.Replace(girdi, @"[^\w\s-]", "");

    return girdi.Trim();
}
```

### İstek Sınırlama
```csharp
public void ConfigureServices(IServiceCollection services)
{
    services.AddRateLimiting(options =>
    {
        options.GenelKurallar = new List<RateLimitRule>
        {
            new RateLimitRule
            {
                Endpoint = "*",
                Limit = 100,
                Period = "1m"
            }
        };
    });
}
``` 
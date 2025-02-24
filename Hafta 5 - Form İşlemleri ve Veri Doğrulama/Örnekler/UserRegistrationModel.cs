using System;
using System.ComponentModel.DataAnnotations;

namespace ECommerce.Models
{
    public class UserRegistrationModel
    {
        [Required(ErrorMessage = "Kullanıcı adı zorunludur.")]
        [StringLength(50, MinimumLength = 3, ErrorMessage = "Kullanıcı adı 3-50 karakter arasında olmalıdır.")]
        [Display(Name = "Kullanıcı Adı")]
        public string Username { get; set; }

        [Required(ErrorMessage = "E-posta adresi zorunludur.")]
        [EmailAddress(ErrorMessage = "Geçerli bir e-posta adresi giriniz.")]
        [Display(Name = "E-posta")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Şifre zorunludur.")]
        [StringLength(100, MinimumLength = 6, ErrorMessage = "Şifre en az 6 karakter olmalıdır.")]
        [DataType(DataType.Password)]
        [Display(Name = "Şifre")]
        public string Password { get; set; }

        [Required(ErrorMessage = "Şifre tekrarı zorunludur.")]
        [Compare("Password", ErrorMessage = "Şifreler eşleşmiyor.")]
        [DataType(DataType.Password)]
        [Display(Name = "Şifre Tekrarı")]
        public string ConfirmPassword { get; set; }

        [Required(ErrorMessage = "Ad zorunludur.")]
        [StringLength(50, ErrorMessage = "Ad en fazla 50 karakter olabilir.")]
        [Display(Name = "Ad")]
        public string FirstName { get; set; }

        [Required(ErrorMessage = "Soyad zorunludur.")]
        [StringLength(50, ErrorMessage = "Soyad en fazla 50 karakter olabilir.")]
        [Display(Name = "Soyad")]
        public string LastName { get; set; }

        [Required(ErrorMessage = "Doğum tarihi zorunludur.")]
        [DataType(DataType.Date)]
        [Display(Name = "Doğum Tarihi")]
        [MinimumAge(18, ErrorMessage = "18 yaşından küçükler kayıt olamaz.")]
        public DateTime DateOfBirth { get; set; }

        [Phone(ErrorMessage = "Geçerli bir telefon numarası giriniz.")]
        [Display(Name = "Telefon")]
        public string PhoneNumber { get; set; }

        [Display(Name = "Haber bülteni")]
        public bool SubscribeNewsletter { get; set; }

        [Required(ErrorMessage = "Kullanım koşullarını kabul etmelisiniz.")]
        [Display(Name = "Kullanım Koşulları")]
        public bool AcceptTerms { get; set; }
    }

    // Custom validation attribute
    public class MinimumAgeAttribute : ValidationAttribute
    {
        private readonly int _minimumAge;

        public MinimumAgeAttribute(int minimumAge)
        {
            _minimumAge = minimumAge;
        }

        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            if (value is DateTime date)
            {
                var age = DateTime.Today.Year - date.Year;
                
                // Doğum günü bu yıl gelmediyse yaşı bir azalt
                if (date.Date > DateTime.Today.AddYears(-age))
                {
                    age--;
                }

                if (age >= _minimumAge)
                {
                    return ValidationResult.Success;
                }
            }

            return new ValidationResult($"Minimum yaş sınırı {_minimumAge}'dir.");
        }
    }
} 
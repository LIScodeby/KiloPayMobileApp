// lib/core/utils/validators.dart
class Validators {
  static String? phone(String? v) {
    if (v == null || v.trim().isEmpty) return 'Введите номер телефона';
    if (v.replaceAll(RegExp(r'[^0-9]'), '').length < 10) {
      return 'Некорректный номер';
    }
    return null;
  }

  static String? password(String? v) {
    if (v == null || v.length < 6) return 'Минимум 6 символов';
    return null;
  }

  static String? confirmPassword(String? v, String password) {
    if (v != password) return 'Пароли не совпадают';
    return null;
  }

  static String? email(String? v) {
    if (v == null || v.isEmpty) return null;
    if (!RegExp(r'^[\w\.\-]+@[\w\.\-]+\.\w+$').hasMatch(v)) {
      return 'Некорректный email';
    }
    return null;
  }

  static String? amount(String? v) {
    if (v == null || v.isEmpty) return 'Введите сумму';
    final num? n = num.tryParse(v.replaceAll(',', '.'));
    if (n == null || n <= 0) return 'Некорректная сумма';
    return null;
  }
}

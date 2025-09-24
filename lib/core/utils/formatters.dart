// lib/core/utils/formatters.dart
import 'package:flutter/services.dart';

class MaskedPhoneFormatter extends TextInputFormatter {
  // Простой форматтер для +7 (XXX) XXX-XX-XX
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final b = StringBuffer('+7 ');
    for (int i = 0; i < digits.length && i < 10; i++) {
      if (i == 0) b.write('(');
      b.write(digits[i]);
      if (i == 2) b.write(') ');
      if (i == 5 || i == 7) b.write('-');
    }
    return TextEditingValue(
      text: b.toString(),
      selection: TextSelection.collapsed(offset: b.length),
    );
  }
}

import 'package:flutter/services.dart';

class CpfFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var digitsOnly = newValue.text.replaceAll(RegExp(r'\D+'), '');

    if (digitsOnly.length > 11) {
      digitsOnly = digitsOnly.substring(0, 11);
    }

    if (digitsOnly.length < 4) {
      return newValue;
    } else if (digitsOnly.length < 7) {
      final firstPart = digitsOnly.substring(0, 3);
      final secondPart = digitsOnly.substring(3);
      final formatted = '$firstPart.$secondPart';
      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    } else if (digitsOnly.length < 10) {
      final firstPart = digitsOnly.substring(0, 3);
      final secondPart = digitsOnly.substring(3, 6);
      final thirdPart = digitsOnly.substring(6);
      final formatted = '$firstPart.$secondPart.$thirdPart';
      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    } else {
      final firstPart = digitsOnly.substring(0, 3);
      final secondPart = digitsOnly.substring(3, 6);
      final thirdPart = digitsOnly.substring(6, 9);
      final fourthPart = digitsOnly.substring(9);
      final formatted = '$firstPart.$secondPart.$thirdPart-$fourthPart';
      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }
}

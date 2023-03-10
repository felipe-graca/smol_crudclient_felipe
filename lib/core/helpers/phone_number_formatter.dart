import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String cleanedText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    String formattedText;

    if (cleanedText.length >= 11) {
      // Format as (XX) XXXXX-XXXX
      formattedText =
          '(${cleanedText.substring(0, 2)}) ${cleanedText.substring(2, 7)}-${cleanedText.substring(7, 11)}';
    } else if (cleanedText.length >= 7) {
      // Format as (XX) XXXX-XXXX
      formattedText =
          '(${cleanedText.substring(0, 2)}) ${cleanedText.substring(2, 6)}-${cleanedText.substring(6)}';
    } else if (cleanedText.length >= 3) {
      // Format as (XX) XXXX
      formattedText =
          '(${cleanedText.substring(0, 2)}) ${cleanedText.substring(2)}';
    } else {
      // Format as XXXX
      formattedText = cleanedText;
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String formatInitialValue(String? initialValue) {
    if (initialValue == null || initialValue.isEmpty) {
      return '';
    }

    // Remove non-digit characters from the initial value
    String cleanedValue = initialValue.replaceAll(RegExp(r'[^\d]'), '');

    // Format the cleaned value using the formatEditUpdate method
    TextEditingValue value = formatEditUpdate(
        TextEditingValue.empty, TextEditingValue(text: cleanedValue));

    return value.text;
  }
}

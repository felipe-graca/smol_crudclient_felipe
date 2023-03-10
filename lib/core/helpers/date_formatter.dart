import 'package:flutter/services.dart';

class DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String cleanedText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    String formattedText;

    if (cleanedText.length >= 8) {
      // Format as DD/MM/YYYY
      formattedText =
          '${cleanedText.substring(0, 2)}/${cleanedText.substring(2, 4)}/${cleanedText.substring(4)}';
    } else if (cleanedText.length >= 4) {
      // Format as MM/YYYY
      formattedText =
          '${cleanedText.substring(0, 2)}/${cleanedText.substring(2)}';
    } else {
      // Format as MM
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

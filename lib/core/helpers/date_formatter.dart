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

    if (formattedText.length > 10) {
      formattedText = formattedText.substring(0, 10);
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

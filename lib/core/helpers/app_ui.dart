import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smol_crudclient_felipe/ui/widgets/custom_snackbar.dart';

class AppUI {
  AppUI._();

  static String formatCurrencyPtBr(double value) {
    final formatter = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
      decimalDigits: 2,
    );
    return formatter.format(value);
  }

  static String phoneFormatter(String value) {
    // Remove todos os caracteres que não são dígitos
    final digitsOnly = value.replaceAll(RegExp(r'\D+'), '');

    // Se não houver 10 dígitos, retorna o valor original
    if (digitsOnly.length != 11) {
      return value;
    }

    // Divide o número em área, prefixo e sufixo
    final areaCode = digitsOnly.substring(0, 2);
    final prefix = digitsOnly.substring(2, 6);
    final suffix = digitsOnly.substring(6);

    // Retorna a string formatada
    return '($areaCode) $prefix-$suffix';
  }

  static String cpfFormatter(String value) {
    var digitsOnly = value.replaceAll(RegExp(r'\D+'), '');

    if (digitsOnly.length > 11) {
      digitsOnly = digitsOnly.substring(0, 11);
    }

    if (digitsOnly.length < 4) {
      return value;
    } else if (digitsOnly.length < 7) {
      final firstPart = digitsOnly.substring(0, 3);
      final secondPart = digitsOnly.substring(3);
      return '$firstPart.$secondPart';
    } else if (digitsOnly.length < 10) {
      final firstPart = digitsOnly.substring(0, 3);
      final secondPart = digitsOnly.substring(3, 6);
      final thirdPart = digitsOnly.substring(6);
      return '$firstPart.$secondPart.$thirdPart';
    } else {
      final firstPart = digitsOnly.substring(0, 3);
      final secondPart = digitsOnly.substring(3, 6);
      final thirdPart = digitsOnly.substring(6, 9);
      final fourthPart = digitsOnly.substring(9);
      return '$firstPart.$secondPart.$thirdPart-$fourthPart';
    }
  }

  static final snackbarsToDisplayWhenStart = <SnackbarToDisplayModel>[];

  static void checkSnackbarToDisplay({
    required BuildContext context,
    required String page,
  }) {
    final index = AppUI.snackbarsToDisplayWhenStart
        .indexWhere((element) => element.page == page);

    if (index != -1) {
      CustomSnackBar.show(
        text: snackbarsToDisplayWhenStart[index].text,
        status: snackbarsToDisplayWhenStart[index].status,
        context: context,
      );

      AppUI.snackbarsToDisplayWhenStart.removeAt(index);
    }
  }

  static String convertDateToUI(String? inputDate) {
    if (inputDate == null) return '';

    // Split the input date into year, month, and day components
    List<String> components = inputDate.split('-');

    // Rearrange the components into the desired format
    String outputDate = '${components[2]}/${components[1]}/${components[0]}';

    return outputDate;
  }

  static String convertDateToService(String inputDate) {
    // Split the input date into day, month, and year components
    List<String> components = inputDate.split('/');

    // Rearrange the components into the desired format
    String outputDate =
        '${components[2]}-${components[1].padLeft(2, '0')}-${components[0].padLeft(2, '0')}';

    return outputDate;
  }
}

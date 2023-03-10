import 'package:formz/formz.dart';

enum PhoneNumberValidatorError { invalid }

class PhoneNumberValidator
    extends FormzInput<String, PhoneNumberValidatorError> {
  const PhoneNumberValidator.pure([String value = '']) : super.pure(value);

  const PhoneNumberValidator.dirty({String value = ''}) : super.dirty(value);

  static final _phoneNumberRegExp = RegExp(r'^\d{10}$');

  @override
  PhoneNumberValidatorError? validator(String? value) {
    final digitsOnly = value?.replaceAll(RegExp(r'\D+'), '') ?? '';
    final hasValidLength = digitsOnly.length == 10;
    final isValid = _phoneNumberRegExp.hasMatch(digitsOnly);

    return hasValidLength && isValid ? null : PhoneNumberValidatorError.invalid;
  }

  String? formatValue(String? value) {
    final digitsOnly = value?.replaceAll(RegExp(r'\D+'), '') ?? '';

    if (digitsOnly.length != 10) {
      return value;
    }

    final areaCode = digitsOnly.substring(0, 2);
    final prefix = digitsOnly.substring(2, 6);
    final suffix = digitsOnly.substring(6);

    return '($areaCode) $prefix-$suffix';
  }
}

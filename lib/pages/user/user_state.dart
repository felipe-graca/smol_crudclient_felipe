// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_cubit.dart';

class UserState extends Equatable {
  final TextValidator name;
  final EmailValidator email;
  final PhoneNumberValidator phoneNumber;
  final NumberValidator cpf;
  final TextValidator birthDate;
  final RadioValidator gender;
  final UserModel? currentUser;

  final FormzStatus status;
  final String successesMessage;
  final String errorMessage;
  final bool wasSubmitted;

  const UserState({
    this.name = const TextValidator.pure(),
    this.email = const EmailValidator.pure(),
    this.phoneNumber = const PhoneNumberValidator.pure(),
    this.cpf = const NumberValidator.pure(),
    this.birthDate = const TextValidator.pure(),
    this.gender = const RadioValidator.pure(optional: true),
    this.currentUser = const UserModel(),
    this.status = FormzStatus.pure,
    this.successesMessage = '',
    this.errorMessage = '',
    this.wasSubmitted = false,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        phoneNumber,
        cpf,
        birthDate,
        gender,
        currentUser,
        status,
        successesMessage,
        errorMessage,
        wasSubmitted,
      ];

  UserState copyWith({
    TextValidator? name,
    EmailValidator? email,
    PhoneNumberValidator? phoneNumber,
    NumberValidator? cpf,
    TextValidator? birthDate,
    RadioValidator? gender,
    UserModel? Function()? currentUser,
    FormzStatus? status,
    String? successesMessage,
    String? errorMessage,
    bool? wasSubmitted,
  }) {
    return UserState(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      cpf: cpf ?? this.cpf,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      currentUser: currentUser != null ? currentUser() : this.currentUser,
      status: status ?? this.status,
      successesMessage: successesMessage ?? this.successesMessage,
      errorMessage: errorMessage ?? this.errorMessage,
      wasSubmitted: wasSubmitted ?? this.wasSubmitted,
    );
  }
}

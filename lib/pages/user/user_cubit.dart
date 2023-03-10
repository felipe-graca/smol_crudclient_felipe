import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:smol_crudclient_felipe/core/domain/models/form/number_validator.dart';
import 'package:smol_crudclient_felipe/core/domain/models/form/phone_validator.dart';
import 'package:smol_crudclient_felipe/core/domain/models/form/radio_validator.dart';
import 'package:smol_crudclient_felipe/core/domain/repository/user/user_repository_interface.dart';
import 'package:smol_crudclient_felipe/core/errors/crud_errors.dart';
import 'package:smol_crudclient_felipe/core/helpers/app_ui.dart';

import '../../core/domain/models/form/email_validator.dart';
import '../../core/domain/models/form/text_validator.dart';
import '../../core/domain/models/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final IUserRepository userRepository;

  UserCubit(this.userRepository) : super(const UserState());

  void init({
    UserModel? user,
  }) {
    emit(state.copyWith(
      currentUser: () => user,
      name: TextValidator.dirty(value: user?.name ?? ''),
      email: EmailValidator.dirty(value: user?.email ?? ''),
      phoneNumber: PhoneNumberValidator.dirty(value: user?.phoneNumber ?? ''),
      cpf: NumberValidator.dirty(value: user?.cpf ?? ''),
      gender: RadioValidator.dirty(value: user?.gender ?? ''),
      birthDate: TextValidator.dirty(value: user?.birthDate ?? ''),
      wasSubmitted: false,
    ));
  }

  void emailChanged(String value) {
    final email = EmailValidator.dirty(value: value.toLowerCase());
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate(
          [email],
        ),
      ),
    );
  }

  void nameChanged(String value) {
    final name = TextValidator.dirty(value: value);
    emit(
      state.copyWith(
        name: name,
        status: Formz.validate([name]),
      ),
    );
  }

  void genderChanged(String value) {
    final gender = RadioValidator.dirty(value: value);
    emit(
      state.copyWith(
        gender: gender,
        status: Formz.validate([gender]),
      ),
    );
  }

  void birthDateChanged(String value) {
    final birthDate = TextValidator.dirty(value: value);
    emit(
      state.copyWith(
        birthDate: birthDate,
        status: Formz.validate([birthDate]),
      ),
    );
  }

  void cpfChanged(String value) {
    final cpf = NumberValidator.dirty(value: value);
    emit(
      state.copyWith(
        cpf: cpf,
        status: Formz.validate([cpf]),
      ),
    );
  }

  void phoneNumberChanged(String value) {
    final phoneNumber = PhoneNumberValidator.dirty(value: value);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        status: Formz.validate([phoneNumber]),
      ),
    );
  }

  Future<bool> submit() async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      final user = UserModel(
        name: state.name.value,
        email: state.email.value,
        cpf: state.cpf.value.replaceAll(RegExp(r'\D+'), ''),
        phoneNumber: state.phoneNumber.value.replaceAll(RegExp(r'\D+'), ''),
        birthDate: AppUI.convertDateToService(state.birthDate.value),
        gender: state.gender.value,
        id: state.currentUser?.id,
      );

      if (state.currentUser == null) {
        await userRepository.createUser(user);
      } else {
        await userRepository.updateUser(user);

        emit(
          state.copyWith(successesMessage: 'Usuário atualizado com sucesso!'),
        );
      }

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
      return true;
    } on UpdateUserFailure catch (e) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        errorMessage: e.message,
      ));
      return false;
    } on CreateAccountFailure catch (e) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        errorMessage: e.message,
      ));
      return false;
    }
  }

  Future<bool> deleteUser({required UserModel user}) async {
    try {
      await userRepository.deleteUser(user.id!);
      return true;
    } catch (_) {
      return false;
    }
  }

  bool get formIsValid => state.status.isValid;

  bool get submissionSuccess => state.status == FormzStatus.submissionSuccess;

  bool get isLoading => state.status == FormzStatus.submissionInProgress;

  String get errorMessage => state.errorMessage;

  String get successesMessage => state.successesMessage;
}

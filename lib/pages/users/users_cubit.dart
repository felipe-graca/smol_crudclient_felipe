import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smol_crudclient_felipe/core/domain/models/user_model.dart';
import 'package:smol_crudclient_felipe/core/domain/repository/user/user_repository_interface.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final IUserRepository _userRepository;
  UsersCubit(this._userRepository) : super(const UsersState());

  void init() async {
    emit(const UsersState());
    await getUsers();
  }

  Future<void> getUsers() async {
    try {
      final users = await _userRepository.getUsers();
      emit(state.copyWith(users: users));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Erro ao obter lista de usuarios'));
    }
  }
}

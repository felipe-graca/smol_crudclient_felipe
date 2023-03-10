// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'users_cubit.dart';

class UsersState extends Equatable {
  final List<UserModel> users;
  final String errorMessage;
  const UsersState({
    this.users = const [],
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [
        users,
        errorMessage,
      ];

  UsersState copyWith({
    List<UserModel>? users,
    String? errorMessage,
  }) {
    return UsersState(
      users: users ?? this.users,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

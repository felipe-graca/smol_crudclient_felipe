import 'package:smol_crudclient_felipe/core/domain/models/user_model.dart';

abstract class IUserRepository {
  Future<List<UserModel>> getUsers();
  Future<void> createUser(UserModel user);
  Future<void> updateUser(UserModel user);
  Future<void> deleteUser(int id);
}

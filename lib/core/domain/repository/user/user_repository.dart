import 'package:dio/dio.dart';
import 'package:smol_crudclient_felipe/core/domain/models/user_model.dart';
import 'package:smol_crudclient_felipe/core/domain/repository/user/user_repository_interface.dart';
import 'package:smol_crudclient_felipe/core/errors/crud_errors.dart';
import 'package:smol_crudclient_felipe/core/helpers/service_helper.dart';
import 'package:smol_crudclient_felipe/core/services/http/http_service_interface.dart';

class UserRepository implements IUserRepository {
  final IHttpService httpService;
  UserRepository(this.httpService);

  @override
  Future<bool> createUser(user) async {
    try {
      await httpService.post(
        ServiceHelper.urlServer,
        data: user.toJson(isNewUser: true),
      );

      return true;
    } on DioError catch (e) {
      throw CreateAccountFailure.fromCode(
        e.response!.data.keys.first.toString(),
      );
    }
  }

  @override
  Future<void> deleteUser(int id) async {
    try {
      final response =
          await httpService.delete('${ServiceHelper.urlServer}$id/');
    } catch (e) {}
  }

  @override
  Future<UserModel> getUser(int id) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await httpService.get(ServiceHelper.urlServer);

      return response.data
          .map<UserModel>((user) => UserModel.fromJson(user))
          .toList();
    } catch (e) {
      throw Exception('Erro ao obter list de usuarios');
    }
  }

  @override
  Future<bool> updateUser(user) async {
    try {
      await httpService.put(
        '${ServiceHelper.urlServer}${user.id}/',
        data: user.toJson(),
      );

      return true;
    } on DioError catch (e) {
      throw UpdateUserFailure.fromCode(e.response!.data.keys.first.toString());
    }
  }
}

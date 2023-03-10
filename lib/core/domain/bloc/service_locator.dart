import 'package:get_it/get_it.dart';
import 'package:smol_crudclient_felipe/core/domain/repository/user/user_repository.dart';
import 'package:smol_crudclient_felipe/core/domain/repository/user/user_repository_interface.dart';
import 'package:smol_crudclient_felipe/core/services/http/http_service.dart';
import 'package:smol_crudclient_felipe/core/services/http/http_service_interface.dart';
import 'package:smol_crudclient_felipe/pages/user/user_cubit.dart';
import 'package:smol_crudclient_felipe/pages/users/users_cubit.dart';

class ServiceLocator {
  static Future<void> setup() async {
    final i = GetIt.instance;

    //services
    i.registerLazySingleton<IHttpService>(() => HttpService());

    //reposotris
    i.registerLazySingleton<IUserRepository>(() => UserRepository(i.get()));

    //pages
    i.registerLazySingleton(() => UsersCubit(i.get()));
    i.registerLazySingleton(() => UserCubit(i.get()));
  }
}

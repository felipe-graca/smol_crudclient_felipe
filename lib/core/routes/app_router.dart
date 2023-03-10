import 'package:flutter/material.dart';
import 'package:smol_crudclient_felipe/core/domain/models/user_model.dart';
import 'package:smol_crudclient_felipe/pages/splash/splash_page.dart';
import 'package:smol_crudclient_felipe/pages/user/user_page.dart';
import 'package:smol_crudclient_felipe/pages/users/users_page.dart';

class AppRoutes {
  static const splash = '/splash';
  static const users = '/Users';
  static const user = '/user';

  static MaterialPageRoute<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments as Map<String, dynamic>?;
    late final Widget page;

    switch (routeSettings.name) {
      case '/':
      case splash:
        page = const SplashPage();
        break;
      case users:
        page = const UsersPage();
        break;
      case user:
        page = UserPage(user: args?['user'] as UserModel?);
        break;
      default:
        page = Container();
    }

    return MaterialPageRoute(
      builder: (_) => page,
      settings: routeSettings,
    );
  }
}

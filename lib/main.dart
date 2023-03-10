import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smol_crudclient_felipe/core/domain/bloc/service_locator.dart';
import 'package:smol_crudclient_felipe/core/routes/app_router.dart';

void main() {
  runApp(
    FutureBuilder(
      future: initializeServices(),
      builder: (_, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Container(),
          );
        }
        return const MyApp();
      },
    ),
  );
}

Future<void> initializeServices() async {
  //initialize service injection
  await ServiceLocator.setup();

  //initialize getIt
  await GetIt.I.allReady();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smol Crud Client',
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}

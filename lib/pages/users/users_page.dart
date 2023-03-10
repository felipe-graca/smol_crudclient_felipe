import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:smol_crudclient_felipe/core/helpers/app_ui.dart';
import 'package:smol_crudclient_felipe/core/routes/app_router.dart';
import 'package:smol_crudclient_felipe/pages/users/components/user_item_component.dart';
import 'package:smol_crudclient_felipe/pages/users/users_cubit.dart';
import 'package:smol_crudclient_felipe/ui/icons/custom_icons.dart';
import 'package:smol_crudclient_felipe/ui/styles/custom_typography.dart';
import 'package:smol_crudclient_felipe/ui/widgets/custom_header.dart';
import 'package:smol_crudclient_felipe/ui/widgets/custom_snackbar.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final usersCubit = GetIt.I.get<UsersCubit>();
  late final StreamSubscription snackbarSubscription;

  @override
  void initState() {
    usersCubit.init();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppUI.checkSnackbarToDisplay(context: context, page: AppRoutes.users);
    });

    super.initState();
  }

  Future<bool> futureDelayd() async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: width,
        child: Column(
          children: [
            CustomHeader(
                title: 'Usuários',
                icon: CustomIcons.plusCircle,
                onBackTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.splash,
                      (Route<dynamic> route) => false,
                    ),
                onTap: () async {
                  final result =
                      await Navigator.of(context).pushNamed(AppRoutes.user);

                  if (result == true) {
                    await usersCubit.getUsers();
                    if (!mounted) return;
                    CustomSnackBar.show(
                      text: 'Usuário criado com sucesso',
                      status: CustomSnackbarStatus.success,
                      context: context,
                    );
                  }
                }),
            BlocBuilder<UsersCubit, UsersState>(
              bloc: usersCubit,
              builder: (context, state) => Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    if (state.users.isEmpty)
                      FutureBuilder(
                        future: futureDelayd(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Center(
                              child: SizedBox(
                                width: width,
                                height: height,
                                child: Center(
                                  child: const Text('Nenhum usuário encontrado')
                                      .regularMedium(),
                                ),
                              ),
                            );
                          } else {
                            return SizedBox(
                              width: width,
                              height: height,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        },
                      )
                    else
                      ...state.users.map(
                        (user) => Column(
                          children: [
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: UserItemComponent(
                                name: user.name!,
                                email: user.email!,
                                phoneNumber: user.phoneNumber!,
                                onTap: () => Navigator.of(context).pushNamed(
                                  AppRoutes.user,
                                  arguments: {
                                    'user': user,
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: width,
                              height: 1,
                              color: const Color(0xFF30FC6F),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

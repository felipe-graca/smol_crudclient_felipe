import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smol_crudclient_felipe/core/domain/models/user_model.dart';
import 'package:smol_crudclient_felipe/core/helpers/app_ui.dart';
import 'package:smol_crudclient_felipe/core/routes/app_router.dart';
import 'package:smol_crudclient_felipe/pages/user/user_cubit.dart';
import 'package:smol_crudclient_felipe/ui/styles/custom_typography.dart';
import 'package:smol_crudclient_felipe/ui/widgets/custom_snackbar.dart';

class CustomDialog {
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    String? description,
    String buttonLabel = '',
    bool? isNegativeAction,
  }) async {
    return _baseDialog(
      context: context,
      child: Builder(builder: (context) {
        return Stack(
          children: [
            Positioned(
              top: 100,
              right: 0,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                radius: 100,
                child: const Icon(
                  Icons.close,
                  size: 24,
                  color: Colors.grey,
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Center(
                    child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: FittedBox(
                    child: Text(
                      title,
                      maxLines: 1,
                    ).regularExtraBold(),
                  ),
                )),
                if (isNegativeAction == true)
                  ElevatedButton(
                    child: Text(buttonLabel),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  )
                else
                  ElevatedButton(
                    child: Text(buttonLabel),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        );
      }),
    );
  }

  static Future<T?> _baseDialog<T>({
    required BuildContext context,
    required Widget child,
    EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 10),
    bool hasRedBorder = false,
  }) async {
    return showDialog<T>(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, -2),
                      blurRadius: 80,
                      spreadRadius: 15,
                      color: Colors.black.withOpacity(0.25),
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  border: hasRedBorder
                      ? Border.all(color: Colors.deepPurple)
                      : null,
                ),
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> deleteUser(
      {required BuildContext context, required UserModel user}) async {
    final width = MediaQuery.of(context).size.width;

    final userCubit = GetIt.I.get<UserCubit>();

    return _baseDialog(
      context: context,
      child: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    'Deletar usuário',
                    textAlign: TextAlign.center,
                  ).extraBold(const Color.fromARGB(255, 255, 0, 0)),
                  const SizedBox(height: 5),
                  const Text(
                    'Você tem certeza que deseja deletar esse usuário?',
                    textAlign: TextAlign.center,
                  ).smallRegular(const Color(0xFF8D8B8B)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xFF28D45E)),
                    ),
                    child: const Text('Voltar'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xFFFF0000)),
                    ),
                    child: const Text('Deletar'),
                    onPressed: () async {
                      await userCubit.deleteUser(user: user).then((value) {
                        if (value) {
                          AppUI.snackbarsToDisplayWhenStart.add(
                            SnackbarToDisplayModel(
                              page: AppRoutes.users,
                              status: CustomSnackbarStatus.success,
                              text: 'Usuário deletado com sucesso!',
                            ),
                          );
                          Navigator.of(context).pushNamed(AppRoutes.users);
                        } else {
                          Navigator.of(context).pop();
                        }
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

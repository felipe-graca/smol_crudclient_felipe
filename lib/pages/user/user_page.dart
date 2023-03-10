import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:smol_crudclient_felipe/core/domain/models/user_model.dart';
import 'package:smol_crudclient_felipe/core/helpers/app_ui.dart';
import 'package:smol_crudclient_felipe/core/helpers/cpf_formatter.dart';
import 'package:smol_crudclient_felipe/core/helpers/date_formatter.dart';
import 'package:smol_crudclient_felipe/core/helpers/phone_number_formatter.dart';
import 'package:smol_crudclient_felipe/pages/user/user_cubit.dart';
import 'package:smol_crudclient_felipe/ui/styles/custom_typography.dart';
import 'package:smol_crudclient_felipe/ui/widgets/custom_buttons.dart';
import 'package:smol_crudclient_felipe/ui/widgets/custom_dialogs.dart';
import 'package:smol_crudclient_felipe/ui/widgets/custom_header.dart';
import 'package:smol_crudclient_felipe/ui/widgets/custom_radio.dart';
import 'package:smol_crudclient_felipe/ui/widgets/custom_snackbar.dart';
import 'package:smol_crudclient_felipe/ui/widgets/custom_text_form_field.dart';

class UserPage extends StatefulWidget {
  final UserModel? user;
  const UserPage({super.key, this.user});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final userCubit = GetIt.I.get<UserCubit>();

  @override
  void initState() {
    userCubit.init(
      user: widget.user,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final navigator = Navigator.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocBuilder<UserCubit, UserState>(
        bloc: userCubit,
        builder: (context, state) {
          return SizedBox(
            width: width,
            child: Column(
              children: [
                CustomHeader(
                  title: 'Usuários',
                  icon: Icons.delete,
                  onTap: () async {
                    if (state.currentUser != null) {
                      await CustomDialog.deleteUser(
                        context: context,
                        user: state.currentUser!,
                      );
                      return;
                    }
                    CustomSnackBar.show(
                      text: 'Não é possivel deletar um usuario não cadastrado',
                      status: CustomSnackbarStatus.error,
                      context: context,
                    );
                  },
                  onBackTap: () =>
                      navigator.pop(widget.user != null ? true : false),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('NOME').regularMedium(),
                            const SizedBox(height: 5),
                            CustomTextFormField(
                              initialValue: widget.user?.name,
                              onChanged: (value) {
                                userCubit.nameChanged(value);
                              },
                              label: 'Nome',
                              hasError: !state.name.valid,
                              errorMessage: 'nome inválido',
                              wasSubmitted: state.wasSubmitted,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('E-MAIL').regularMedium(),
                            const SizedBox(height: 5),
                            CustomTextFormField(
                              initialValue: widget.user?.email,
                              onChanged: (value) {
                                userCubit.emailChanged(value);
                              },
                              label: 'E-mail',
                              hasError: !state.email.valid,
                              errorMessage: 'E-mail inválido',
                              wasSubmitted: state.wasSubmitted,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('TELEFONE').regularMedium(),
                            const SizedBox(height: 5),
                            CustomTextFormField(
                              initialValue: AppUI.phoneFormatter(
                                widget.user?.phoneNumber ?? '',
                              ),
                              onChanged: (value) {
                                userCubit.phoneNumberChanged(value);
                              },
                              inputFormatters: [PhoneNumberFormatter()],
                              label: '(00) 00000-0000',
                              keyboardType: TextInputType.phone,
                              hasError: !state.phoneNumber.valid,
                              errorMessage: 'Telefone inválido',
                              wasSubmitted: state.wasSubmitted,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('DATA NASCIMENTO').regularMedium(),
                            const SizedBox(height: 5),
                            CustomTextFormField(
                              initialValue:
                                  AppUI.convertDateToUI(widget.user?.birthDate),
                              onChanged: (value) {
                                userCubit.birthDateChanged(value);
                              },
                              label: 'DD/MM/AAAA',
                              keyboardType: TextInputType.number,
                              hasError: !state.birthDate.valid,
                              inputFormatters: [DateFormatter()],
                              errorMessage: 'Data nascimento inválido',
                              wasSubmitted: state.wasSubmitted,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('CPF').regularMedium(),
                            const SizedBox(height: 5),
                            CustomTextFormField(
                              keyboardType: TextInputType.number,
                              initialValue: AppUI.cpfFormatter(
                                widget.user?.cpf ?? '',
                              ),
                              onChanged: (value) {
                                userCubit.cpfChanged(value);
                              },
                              label: 'XXX.XXX.XXX-XX',
                              hasError: !state.cpf.valid,
                              inputFormatters: [CpfFormatter()],
                              errorMessage: 'Cpf inválido',
                              wasSubmitted: state.wasSubmitted,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Sexo').regularMedium(),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                CustomRadio(
                                  label: 'Feminino',
                                  value: 'Feminino',
                                  groupValue: state.gender.value,
                                  onChanged: userCubit.genderChanged,
                                  hasError: state.gender.invalid,
                                  wasSubmitted: state.wasSubmitted,
                                ),
                                const SizedBox(width: 5),
                                CustomRadio(
                                  label: 'Masculino',
                                  value: 'Masculino',
                                  groupValue: state.gender.value,
                                  onChanged: userCubit.genderChanged,
                                  hasError: state.gender.invalid,
                                  wasSubmitted: state.wasSubmitted,
                                ),
                                const SizedBox(width: 5),
                                CustomRadio(
                                  label: 'Outro',
                                  value: 'Outro',
                                  groupValue: state.gender.value,
                                  onChanged: userCubit.genderChanged,
                                  hasError: state.gender.invalid,
                                  wasSubmitted: state.wasSubmitted,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomPrimaryButton(
                          label: 'SALVAR',
                          onTap: () async {
                            if (await userCubit.submit()) {
                              if (state.currentUser == null) {
                                navigator.pop(true);
                                return;
                              }
                              if (!mounted) return;
                              CustomSnackBar.show(
                                text: userCubit.successesMessage,
                                status: CustomSnackbarStatus.success,
                                context: context,
                              );
                              return;
                            }
                            if (!mounted) return;
                            CustomSnackBar.show(
                              text: userCubit.errorMessage,
                              status: CustomSnackbarStatus.error,
                              context: context,
                            );
                          },
                          fullWidth: true,
                          isLoading: userCubit.isLoading,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

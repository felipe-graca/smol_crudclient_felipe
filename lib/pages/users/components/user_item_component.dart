import 'package:flutter/material.dart';
import 'package:smol_crudclient_felipe/core/helpers/app_ui.dart';
import 'package:smol_crudclient_felipe/ui/styles/custom_colors.dart';
import 'package:smol_crudclient_felipe/ui/styles/custom_typography.dart';

class UserItemComponent extends StatelessWidget {
  final String name;
  final String email;
  final String phoneNumber;
  final Function()? onTap;

  const UserItemComponent({
    super.key,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2DC9E),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Icon(
                    Icons.person_outline_sharp,
                    size: 30,
                    color: Color(0xFF672525),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name).regularBold(const Color.fromARGB(200, 28, 27, 27)),
                  Text(email).regularMedium(),
                  Text(AppUI.phoneFormatter(phoneNumber)).semiRegular(
                    const Color.fromARGB(200, 28, 27, 27),
                  ),
                ],
              ),
            ],
          ),
          const Icon(
            Icons.edit,
            color: CustomColors.green2,
          ),
        ],
      ),
    );
  }
}

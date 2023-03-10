import 'package:flutter/material.dart';
import 'package:smol_crudclient_felipe/ui/icons/custom_icons.dart';
import 'package:smol_crudclient_felipe/ui/styles/custom_colors.dart';
import 'package:smol_crudclient_felipe/ui/styles/custom_typography.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? onTap;
  final Function()? onBackTap;
  const CustomHeader({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.onBackTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(color: CustomColors.yellow4),
      height: 70,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: onBackTap,
              child: const Icon(
                CustomIcons.arrowBack,
                size: 20,
                color: CustomColors.green2,
              ),
            ),
            const Text('Usuarios').regularExtraBold(
              CustomColors.green2,
            ),
            InkWell(
              onTap: onTap,
              child: Icon(
                icon,
                color: CustomColors.green2,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}

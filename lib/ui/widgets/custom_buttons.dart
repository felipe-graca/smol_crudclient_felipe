import 'package:flutter/material.dart';
import 'package:smol_crudclient_felipe/ui/styles/custom_colors.dart';
import 'package:smol_crudclient_felipe/ui/styles/custom_typography.dart';
import 'package:smol_crudclient_felipe/ui/styles/inner_shadow.dart';
import 'package:smol_crudclient_felipe/ui/styles/touch_wrapper.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String label;
  final void Function()? onTap;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final bool fullWidth;
  final bool isLoading;

  const CustomPrimaryButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.leftIcon,
    this.rightIcon,
    this.fullWidth = false,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchWrapper(
      onTap: () {
        if (onTap != null && !isLoading) {
          onTap!();
        }
      },
      builder: (value) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: TouchWrapper.interpolateOuterShadow([
              BoxShadow(
                color: const Color(0xFF424C73).withOpacity(0.65),
                offset: const Offset(4, 4),
                blurRadius: 4,
              )
            ], value),
            borderRadius: BorderRadius.circular(9),
          ),
          child: InnerShadow(
            shadows: TouchWrapper.interpolateInnerShadow([
              BoxShadow(
                color: Colors.black.withOpacity(0.65),
                blurRadius: 6,
                spreadRadius: 0,
                offset: const Offset(2.5, 2.5),
              ),
            ], value),
            child: Container(
              width: fullWidth ? null : 150,
              height: 54.55,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: CustomColors.yellow1,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leftIcon != null && !isLoading)
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Icon(leftIcon, size: 20),
                    ),
                  if (isLoading)
                    const Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else
                    Text(
                      label,
                    ).regularBold(CustomColors.green2),
                  if (rightIcon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Icon(rightIcon, size: 20),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

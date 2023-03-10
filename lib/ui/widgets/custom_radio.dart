import 'package:flutter/material.dart';
import 'package:smol_crudclient_felipe/ui/styles/custom_colors.dart';
import 'package:smol_crudclient_felipe/ui/styles/custom_typography.dart';
import 'package:smol_crudclient_felipe/ui/styles/inner_shadow.dart';

class CustomRadio<T> extends StatelessWidget {
  final String label;
  final T value;
  final T groupValue;
  final void Function(T) onChanged;
  final bool hasError;
  final bool wasSubmitted;

  const CustomRadio({
    Key? key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.hasError = false,
    this.wasSubmitted = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasError = this.hasError && wasSubmitted;

    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: hasError ? CustomColors.green2 : null,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: InnerShadow(
                    shadows: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 71, 72, 79),
                        offset: Offset(2, 2),
                        blurRadius: 3,
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color.fromARGB(255, 69, 63, 63),
                        offset: Offset(-2, -2),
                        blurRadius: 0,
                        spreadRadius: 0,
                      ),
                    ],
                    child: Container(
                      width: 18.75,
                      height: 18.28,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(179, 122, 136, 127),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
                if (value == groupValue)
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 18.75,
                      height: 18.28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          const BoxShadow(
                            color: CustomColors.yellow1,
                            offset: Offset(0, 0),
                            blurRadius: 4,
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: const Color(0xFFE3CCCC).withOpacity(0.6),
                            offset: const Offset(1, -2),
                            blurRadius: 7,
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 5),
          Text(label).regularMedium(hasError ? Colors.red : Colors.black),
        ],
      ),
    );
  }
}

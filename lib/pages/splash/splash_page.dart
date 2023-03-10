import 'package:flutter/material.dart';
import 'package:smol_crudclient_felipe/core/routes/app_router.dart';
import 'package:smol_crudclient_felipe/ui/styles/custom_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      return Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.users,
        (Route<dynamic> route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: CustomColors.green1,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 220),
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: width,
              child: Image.asset(
                'assets/images/splash_image.png',
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}

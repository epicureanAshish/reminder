
import 'package:reminder/constants/app_assets.dart';
import 'package:reminder/modules/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SplashController(),
      builder: (context) {
        return Scaffold(
          body: Center(
            child: Image.asset(AppAssets.appLogo, height: 100,),
          ),
        );
      }
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app_api/shared/config/app_colors.dart';
import 'package:quiz_app_api/shared/config/app_images.dart';
import 'package:quiz_app_api/shared/constants.dart';
import 'package:quiz_app_api/view/pages/00_intro/onboarding.dart';
import 'package:quiz_app_api/view/pages/01_accounts/login.dart';
import 'package:quiz_app_api/view/pages/04_additions/face_finger_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (showOnBoard == true) {
        Get.off(() => const OnBoarding());
      } else {
        if (token != null) {
          Get.off(() => const Authenticate());
        } else {
          Get.off(() => const LoginScreen());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImages.BACKGROUND), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            AppImages.LOGO,
          )),
          const SizedBox(
            height: 50.0,
          ),
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.MAIN),
          ),
        ],
      ),
    ));
  }
}

// return Scaffold(
//   body:Stack(
//     alignment: Alignment.center,
//     children: [
//       Image.asset(AppImages.BACKGROUND),
//       Image.asset(AppImages.LOGO),
//     ],
//   ),
// );

import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:quiz_app_api/resources/cache_helper.dart';
import 'package:quiz_app_api/resources/dio_helper.dart';
import 'package:quiz_app_api/shared/config/app_colors.dart';
import 'package:quiz_app_api/shared/constants.dart';
import 'package:quiz_app_api/view/pages/00_intro/onboarding.dart';
import 'package:quiz_app_api/view/pages/01_accounts/login.dart';
import 'package:quiz_app_api/view/pages/04_additions/face_finger_page.dart';

import 'bindings/home_binding.dart';
import 'view/pages/00_intro/splash.dart';

Future<void> main() async {
//Forced to work in order.
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
//Take the values from the cache helper
  // bool? isDark = CacheHelper.getData('isDark');

  // ignore: unused_local_variable
  showOnBoard = CacheHelper.getData('ShowOnBoard');
  token = CacheHelper.getData('token');
  std_id = CacheHelper.getData('std_id');
  if (showOnBoard == false) {
    if (token != null) {
      widget = const Authenticate();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBoarding();
  }
  //disableCapture();
  runApp( MyApp( startWidget: widget,));
}

class MyApp extends StatelessWidget {
  late final Widget startWidget;
  MyApp({Key? key,  required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get.find<CourseController>().getCourseData();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz',
      initialBinding: HomeBinding(),
      home:  startWidget,
      theme: themeApp(),
    );
  }

  ThemeData themeApp() {
    return ThemeData(
      fontFamily: "Montserrat",
      buttonTheme: ButtonThemeData(
          buttonColor: AppColors.MAIN,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          textTheme: ButtonTextTheme.primary),
      //primarySwatch:Color(0xff27ae68),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.MAIN,
        secondary: AppColors.MAIN,
      ),
    );
  }
}

void disableCapture() async {
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app_api/resources/cache_helper.dart';
import 'package:quiz_app_api/shared/config/app_colors.dart';
import 'package:quiz_app_api/shared/config/app_data.dart';
import 'package:quiz_app_api/shared/config/app_styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../layouts/main_layout.dart';
import '../../widgets/main_button.dart';
import '../01_accounts/login.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
    
  }

  var currentPage = 0;
  bool isLast = false;

  onGetStarted() {
    if (currentPage == AppData.introPages.length - 1) {
      CacheHelper.saveData(key: 'ShowOnBoard', value: false).then((value) {
        if (value) Get.off(() => const LoginScreen());
      });
     // Get.off(() => const LoginScreen());
    } else {
      pageController.animateToPage(currentPage + 1,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        showSkip: true,
        showBack: false,
        skip: showSkip(),
        body: PageView.builder(
          controller: pageController,
          itemCount: AppData.introPages.length,
          itemBuilder: (context, index) {
            currentPage = index;
            return AppData.introPages[index];
          },
          // onPageChanged: (index) {
          //   currentPage = index;
          //   onGetStarted();
          // },
        ),
        smoth: SmoothPageIndicator(
          controller: pageController,
          effect: const ExpandingDotsEffect(
            dotColor: Colors.grey,
            activeDotColor: AppColors.MAIN,
            expansionFactor: 4,
            dotHeight: 10,
            dotWidth: 20,
            spacing: 10,
          ),
          count: AppData.introPages.length,
        ),
        footer: [
          MainButton(
            title: "Get Started",
            onTap: onGetStarted,
          )
        ]);
  }

  Widget showSkip() {
    return GestureDetector(
      child: const Text("Skip", style: AppStyles.paragraph1),
      onTap: () {
         CacheHelper.saveData(key: 'ShowOnBoard', value: false).then((value) {
        if (value) Get.off(() => const LoginScreen());
        });
      },
    );
  }
}

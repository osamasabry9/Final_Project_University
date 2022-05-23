import 'package:quiz_app_api/view/widgets/intro_page.dart';

import 'app_images.dart';

class AppData {
  static const List<IntroPage> introPages = [
    IntroPage(
        image: AppImages.INTRO_1,
        headline: "online exam",
        description: "Our app helps any organization to test anyone online"),
    IntroPage(
        image: AppImages.INTRO_2,
        headline: "Focus on the exam.",
        description: "Answer your question accurately"),
    IntroPage(
        image: AppImages.INTRO_3,
        headline: "Take your time ",
        description: "You have enough time to think don't hurry"),
  ];
}

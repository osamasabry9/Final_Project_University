import 'package:quiz_app_api/view/widgets/intro_page.dart';

import 'app_images.dart';

class AppData {
  static const List<IntroPage> introPages = [
    IntroPage(
        image: AppImages.INTRO_1,
        headline: "Shop your daily needs",
        description: "You won't find it cheaper anywhere else than Gronik"),
    IntroPage(
        image: AppImages.INTRO_2,
        headline: "Existing offers",
        description: "Get new offers and great deals every day every hour"),
    IntroPage(
        image: AppImages.INTRO_3,
        headline: "1000+ products",
        description: "Shop and get delivery at your convenience"),
  ];
}

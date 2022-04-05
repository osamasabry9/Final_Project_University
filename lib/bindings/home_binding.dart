import 'package:get/get.dart';
import 'package:quiz_app_api/controllers/Course_controller.dart';
import 'package:quiz_app_api/controllers/login_controller.dart';
import 'package:quiz_app_api/controllers/quiz_controller.dart';

import '../controllers/face_finger_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaceAndFingerController>(
      () => FaceAndFingerController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
      fenix: true,
    );
    Get.lazyPut<QuizController>(
      () => QuizController(),
    );
    Get.lazyPut<CourseController>(
      () => CourseController(),
      fenix: true,
    );
  }
}

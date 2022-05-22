import 'package:get/get.dart';
import 'package:quiz_app_api/models/post_examination.dart';
import 'package:quiz_app_api/models/results_model.dart';
import 'package:quiz_app_api/resources/dio_helper.dart';
import 'package:quiz_app_api/resources/end_points.dart';
import 'package:quiz_app_api/shared/config/app_colors.dart';
import 'package:quiz_app_api/shared/constants.dart';
import 'package:quiz_app_api/view/pages/03_quiz/quiz_finished.dart';

class AnswersController extends GetxController {
  late ResultsExamination results;
  RxBool isLoding = false.obs;

  void postExamData(
      int courseId, int totalQuestion, Map<int, Answers> answersMap) async {
    isLoding.value = true;
    // int totalQuestion = answersMap.length;
    //var fin = answersList.map((e) => e.toJson()).toList();
    List<Answers> answersList = [];
    answersMap.forEach((key, value) => answersList.add(value));
    DioHelper.postData(url: EXAM, token: token, data: {
      "student_id": "$std_id",
      "course_id": courseId,
      'total_num_of_questions': totalQuestion,
      "answers": answersList,
    }).then((value) async {
      results = ResultsExamination.fromJson(value.data);
      if (results.status!) {
        showSnackBar(
            title: ' Login Success',
            message: " ${results.message}",
            backgroundColor: AppColors.kGreenColor);
        Get.off(() => QuizFinishedPage(
              currentScore: results.data!.currentScore!,
              totalScore: results.data!.totalScore!,
              totalQuestion: totalQuestion,
            ));
      } else {
        showSnackBar(
            title: ' Login ERROR',
            message: " ${results.message}",
            backgroundColor: AppColors.kRedColor);
      }
      isLoding(false);
    }).catchError((error) {
      // ignore: avoid_print
      print(error.toString());
      showSnackBar(
          title: ' Login ERROR',
          message: error.toString(),
          backgroundColor: AppColors.kRedColor);
    });

    update();
  }
}

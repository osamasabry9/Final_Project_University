// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:quiz_app_api/models/exam_model.dart';
import 'package:quiz_app_api/resources/dio_helper.dart';
import 'package:quiz_app_api/resources/end_points.dart';
import 'package:quiz_app_api/shared/config/app_colors.dart';
import 'package:quiz_app_api/shared/constants.dart';

class QuizController extends GetxController {
  ExamModel? examModel;

  RxBool isLoding = false.obs;
  void getExamData(int courseId) async {
    isLoding.value = true;
    DioHelper.getData(
      url: EXAM,
      query: {
        'course_id': '$courseId',
      },
    ).then((value) async {
      examModel = ExamModel.fromJson(value.data);
      print(examModel!.questionx.toString());
      print('course_id =  $courseId  ****END****');
      isLoding.value = false;
    }).catchError((error) {
      print(error.toString());
      isLoding.value = false;
      showSnackBar(
          title: 'Get Exam Data ERROR',
          message: error.toString(),
          backgroundColor: AppColors.kRedColor);
    });
  }
}

// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:quiz_app_api/models/exam_model.dart';
import 'package:quiz_app_api/resources/dio_helper.dart';
import 'package:quiz_app_api/resources/end_points.dart';
import 'package:quiz_app_api/shared/config/app_colors.dart';
import 'package:quiz_app_api/shared/constants.dart';
import 'package:quiz_app_api/view/pages/03_quiz/quiz_list.dart';

class QuizController extends GetxController {
  ExamModel? examModel;
  // List<ExamModel> examData = [];
  RxBool isLoding = false.obs;

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   //getExamData(4);
  //   super.onInit();
  // }

  void getExamData(int courseId, String courseName) async {
    isLoding.value = true;
    DioHelper.getData(
      url: EXAM,
      query: {
        'course_id': '$courseId',
      },
    ).then((value) async {
      // examData = ExamModel.fromJson(value.data).toList();
      examModel = ExamModel.fromJson(value.data);
      //examData = await compute(parseExam, value.data);
      //examData = parseExam(value.data);
      // List<Map<String, dynamic>> questions =
      //     List<Map<String, dynamic>>.from(json.decode(value.data));
      // examData = ExamModel.fromData(questions);

      print("examData =  ${examModel!.data![1].questionx}");
      print('course_id =  $courseId  ****END****');
      isLoding.value = false;
      if (examModel!.data != null) {
        Get.to(() => QuizList(
              courseName: courseName,
            ));
      }
    }).catchError((error) {
      print(error.toString());
      isLoding.value = false;
      showSnackBar(
          title: 'Get Exam Data ERROR',
          message: error.toString(),
          backgroundColor: AppColors.kRedColor);
    });

    update();
  }

  // List<ExamModel> parseExam(responseBody) {
  //   final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  //   return parsed.map<ExamModel>((json) => ExamModel.fromJson(json)).toList();
  // }
}
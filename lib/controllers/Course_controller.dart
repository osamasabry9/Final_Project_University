// ignore_for_file: avoid_print, file_names

import 'package:get/get.dart';
import 'package:quiz_app_api/models/courses_model.dart';
import 'package:quiz_app_api/models/exam_model.dart';
import 'package:quiz_app_api/resources/dio_helper.dart';
import 'package:quiz_app_api/resources/end_points.dart';
import 'package:quiz_app_api/shared/config/app_colors.dart';
import 'package:quiz_app_api/shared/constants.dart';

class CourseController extends GetxController {
  StudentCoursesModel? courseModel;
  ExamModel? examModel;

  RxBool isLoding = false.obs;
  RxBool isLodingExam = false.obs;

  @override
  void onInit() {
    getCourseData();
    super.onInit();
  }

  void getCourseData() async {
    isLoding.value = true;
    DioHelper.getData(
      url: COURSE,
      query: {
        'student_id': '$std_id',
      },
    ).then((value) async {
      courseModel = StudentCoursesModel.fromJson(value.data);
      print(courseModel!.data![1].courseName);
      print('std_id =  $std_id  ****END****');
      isLoding.value = false;
    }).catchError((error) {
      print(error.toString());
      isLoding.value = false;
      showSnackBar(
          title: ' Student Courses ERROR',
          message: error.toString(),
          backgroundColor: AppColors.kRedColor);
    });
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quiz_app_api/controllers/Course_controller.dart';
import 'package:quiz_app_api/controllers/quiz_controller.dart';
import 'package:quiz_app_api/layouts/main_layout.dart';
import 'package:quiz_app_api/models/courses_model.dart';
import 'package:quiz_app_api/resources/cache_helper.dart';
import 'package:quiz_app_api/shared/config/app_colors.dart';
import 'package:quiz_app_api/view/pages/01_accounts/login.dart';
import 'package:quiz_app_api/view/pages/04_additions/error.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final controllerExam = Get.find<QuizController>();

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      showBack: false,
      showSkip: true,
      skip: signOut(),
      isFooter: false,
      title: "Welcome ",
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        child: GetX<CourseController>(
          builder: (controller) {
            return controller.isLoding.value
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        duration: const Duration(milliseconds: 500),
                        position: index,
                        child: SlideAnimation(
                          horizontalOffset: 300,
                          child: FadeInAnimation(
                            child: _bulidCategoryItems(
                                context, controller.courseModel!.data![index]),
                          ),
                        ),
                      );
                    },
                    itemCount: controller.courseModel!.data!.length,
                  );
          },
        ),
      ),
      footer: [
        Container(),
      ],
    );
  }

  Widget _bulidCategoryItems(BuildContext context, Data data) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).orientation == Orientation.landscape
            ? 4
            : 20,
      ),
      width: MediaQuery.of(context).orientation == Orientation.landscape
          ? size.width / 2
          : size.width,
      margin: const EdgeInsets.only(bottom: 5),
      child: GetBuilder<CourseController>(
        builder: (controller) {
          var time = DateTime.parse(data.startTime!);
          var myDate = DateFormat.yMMMd().format(time);
          var myTime = DateFormat('HH:mm').format(time);
          return GestureDetector(
            onTap: () {
              DateTime _selectedDate = DateTime.now();
              // print(
              //     "${DateFormat.yMMMd().format(DateTime.now())}, ${myDate} , *** ${DateFormat.Hm().format(_selectedDate)}");
              if (data.isExaminated == false &&
                  myDate == DateFormat.yMMMd().format(_selectedDate) &&
                  (myTime == DateFormat.Hm().format(_selectedDate) ||
                      myTime ==
                          DateFormat.Hm().format(
                              _selectedDate.add(const Duration(minutes: 5))))) {
                // print(data.courseId!);
                Get.find<QuizController>()
                    .getExamData(data.courseId!, data.courseName!);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: data.isExaminated == false
                    ? _getBGClr(2)
                    : data.currentMarks! > 60
                        ? _getBGClr(0)
                        : _getBGClr(1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.quiz),
                              const SizedBox(width: 15.0),
                              Text(
                                data.courseName.toString(),
                                style: GoogleFonts.raleway(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.date_range_outlined,
                                color: Colors.grey[200],
                                size: 18,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                'Date:  $myDate',
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[100],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                'Time:  $myTime',
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[100],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                color: Colors.grey[200],
                                size: 18,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                '${data.durationInMinutes}  Minutes',
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[100],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (data.isExaminated!)
                            const SizedBox(
                              height: 12,
                            ),
                          if (data.isExaminated!)
                            Row(
                              children: [
                                Icon(
                                  Icons.grading_sharp,
                                  color: Colors.grey[200],
                                  size: 18,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  'Total Marks:  ${data.totalMarks}',
                                  style: GoogleFonts.raleway(
                                    textStyle: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[100],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 13,
                                ),
                                Text(
                                  'Current Marks:  ${data.currentMarks}',
                                  style: GoogleFonts.raleway(
                                    textStyle: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[100],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 60,
                    width: 0.5,
                    color: Colors.grey[200]!.withOpacity(0.7),
                  ),
                  RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      data.isExaminated == false ? 'ToDo' : 'Completed',
                      style: GoogleFonts.raleway(
                        textStyle: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void startQuiz() async {
    try {} on SocketException catch (_) {
      Get.off(() => const ErrorPage(
            message:
                "Can't reach the servers, \n Please check your internet connection.",
          ));
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      Get.off(() => const ErrorPage(
            message: "Unexpected error trying to connect to the API \n ",
          ));
    }
  }

  _getBGClr(int? color) {
    switch (color) {
      case 0:
        return AppColors.kGreenColor.withOpacity(0.5);
      case 1:
        return AppColors.kRedColor.withOpacity(0.7);
      case 2:
        return AppColors.kSecondaryColor;
      default:
        return AppColors.kGrayColor;
    }
  }

  Widget signOut() {
    return GestureDetector(
      child: const Icon(
        Icons.logout_outlined,
        color: Colors.white,
      ),
      onTap: () {
        CacheHelper.removeData('token').then((value) {
          if (value) Get.offAll(() => const LoginScreen());
        });
        CacheHelper.removeData('std_id').then((value) {
          if (value) Get.offAll(() => const LoginScreen());
        });
      },
    );
  }
}

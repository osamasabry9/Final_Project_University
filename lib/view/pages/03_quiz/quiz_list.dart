import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app_api/controllers/quiz_controller.dart';
import 'package:quiz_app_api/layouts/main_layout.dart';
import 'package:quiz_app_api/models/exam_model.dart';
import 'package:quiz_app_api/shared/config/app_colors.dart';
import 'package:quiz_app_api/view/pages/03_quiz/quiz_finished.dart';
import 'package:quiz_app_api/view/widgets/main_button.dart';

class QuizList extends StatefulWidget {
  final String? courseName;
  static Map<int, dynamic> answers = {};
  const QuizList({
    Key? key,
    required this.courseName,
  }) : super(key: key);

  @override
  State<QuizList> createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  //final controller = Get.find<QuizController>();
  List<DataExam>? questions;

  @override
  void initState() {
    questions = Get.find<QuizController>().examModel!.data!;
    super.initState();
    Timer(const Duration(seconds: 5000), () {
      Get.off(() =>
          QuizFinishedPage(questions: questions!, answers: QuizList.answers));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    questions!.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      showBack: false,
      title: widget.courseName!,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              duration: const Duration(milliseconds: 500),
              position: index,
              child: SlideAnimation(
                horizontalOffset: 300,
                child: FadeInAnimation(
                  child:
                      _bulidQuestionsItems(context, index, questions![index]),
                ),
              ),
            );
          },
          itemCount: questions!.length,
        ),
      ),
      footer: [submitAnswers()],
    );
  }

  Widget submitAnswers() {
    return MainButton(
      title: " Submit",
      onTap: () => Get.off(() =>
          QuizFinishedPage(questions: questions!, answers: QuizList.answers)),
    );
  }

  Widget _bulidQuestionsItems(
      BuildContext context, int index, DataExam question) {
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
      child: GestureDetector(
        onTap: () {
          //Get.to(() => QuizPage(question: question, indexQuestion: index));
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: _getBGClr(2)),
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            (index + 1).toString() + ':',
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            question.qtype == 'W'
                                ? 'written'
                                : question.qtype == 'T'
                                    ? 'True & False'
                                    : 'Multichoice',
                            style: GoogleFonts.cousine(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      AutoSizeText(
                        question.questionx!,
                        minFontSize: 10.0,
                        textAlign: TextAlign.start,
                        maxLines: 7,
                        wrapWords: false,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getBGClr(int? color) {
    switch (color) {
      case 0:
        return AppColors.kGreenColor;
      case 1:
        return AppColors.kRedColor;
      case 2:
        return AppColors.kGrayColor;
      default:
        return AppColors.kGrayColor;
    }
  }

  // Widget progressTimer(BuildContext context) {
  //   return Obx(
  //     () {
  //       if (controller.isEnd) {
  //         Get.offAll(() => QuizFinishedPage(
  //             questions: questions!, answers: QuizList.answers));
  //       }
  //       return SizedBox(
  //         height: 50,
  //         width: 50,
  //         child: Stack(
  //           alignment: Alignment.center,
  //           fit: StackFit.expand,
  //           children: [
  //             CircularProgressIndicator(
  //               value: 1 - (controller.sec.value / 15),
  //               color: AppColors.MAIN,
  //               backgroundColor: Colors.grey,
  //               strokeWidth: 8,
  //             ),
  //             Center(
  //               child: Text(
  //                 '${controller.sec.value}',
  //                 style: Theme.of(context)
  //                     .textTheme
  //                     .headline6!
  //                     .copyWith(color: AppColors.MAIN),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}

import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app_api/controllers/quiz_controller.dart';
import 'package:quiz_app_api/layouts/main_layout.dart';
import 'package:quiz_app_api/models/question.dart';
import 'package:quiz_app_api/shared/config/app_colors.dart';
import 'package:quiz_app_api/view/pages/03_quiz/quiz_finished.dart';
import 'package:quiz_app_api/view/pages/03_quiz/quiz_page.dart';
import 'package:quiz_app_api/view/widgets/main_button.dart';

class QuizList extends StatefulWidget {
  final List<Question> questions;
  static Map<int, dynamic> answers = {};
  const QuizList({
    Key? key,
    required this.questions,
  }) : super(key: key);

  @override
  State<QuizList> createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  final controller = Get.find<QuizController>();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5000), () {
      Get.off(() => QuizFinishedPage(
          questions: widget.questions, answers: QuizList.answers));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      showBack: false,
      title: "widget.category.name",
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
                  child: _bulidQuestionsItems(
                      context, index, widget.questions[index]),
                ),
              ),
            );
          },
          itemCount: widget.questions.length,
        ),
      ),
      footer: [submitAnswers()],
    );
  }

  MainButton submitAnswers() {
    return MainButton(
      title: " Submit",
      onTap: () => Get.off(() => QuizFinishedPage(
          questions: widget.questions, answers: QuizList.answers)),
    );
  }

  Widget _bulidQuestionsItems(
      BuildContext context, int index, Question question) {
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
          Get.to(() => QuizPage(question: question, indexQuestion: index));
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
                            question.type.toString(),
                            style: GoogleFonts.lato(
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
                        height: 15,
                      ),
                      AutoSizeText(
                        question.question,
                        minFontSize: 10.0,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        wrapWords: false,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                width: 1,
                color: Colors.grey[200]!.withOpacity(0.7),
              ),
              RotatedBox(
                quarterTurns: 3,
                child: Text(
                  // task.isCompleted == 0 ? 'ToDo' :
                  'ToDo',
                  style: GoogleFonts.lato(
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
  //             questions: widget.questions, answers: QuizList.answers));
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

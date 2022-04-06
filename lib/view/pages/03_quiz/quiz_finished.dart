// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app_api/layouts/main_layout.dart';
import 'package:quiz_app_api/models/exam_model.dart';
import 'package:quiz_app_api/models/question.dart';
import 'package:quiz_app_api/view/pages/02_home/home.dart';
import 'package:quiz_app_api/view/pages/03_quiz/check_answers.dart';

// ignore: must_be_immutable
class QuizFinishedPage extends StatelessWidget {
  final List<DataExam> questions;
  final Map<int, dynamic> answers;
  late int correctAnswers;

  QuizFinishedPage({Key? key, required this.questions, required this.answers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int correct = 0;
    // answers.forEach((index, value) {
    //   if (answers[index] == null) {
    //     value = '';
    //   }
    // });
    // answers.forEach((index, value) {
    //   if (questions[index].correctAnswer == value) {
    //     correct++;
    //   }
    // });
    const TextStyle titleStyle = TextStyle(
        color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.w500);
    final TextStyle trailingStyle = TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold);

    return MainLayout(
      isFooter: false,
      showBack: false,
      title: 'Result',
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: const Text("Total Questions", style: titleStyle),
                  trailing: Text("${questions.length}", style: trailingStyle),
                ),
              ),
              const SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: const Text("Score", style: titleStyle),
                  trailing: Text("${correct / questions.length * 100}%",
                      style: trailingStyle),
                ),
              ),
              const SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: const Text("Correct Answers", style: titleStyle),
                  trailing: Text("$correct/${questions.length}",
                      style: trailingStyle),
                ),
              ),
              const SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: const Text("Incorrect Answers", style: titleStyle),
                  trailing: Text(
                      "${questions.length - correct}/${questions.length}",
                      style: trailingStyle),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.8),
                    child: const Text("Goto Home"),
                    onPressed: () => Get.off(() => HomePage()),
                  ),
                  RaisedButton(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Theme.of(context).primaryColor,
                    child: const Text("Check Answers"),
                    onPressed: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (_) => CheckAnswersPage(
                      //           questions: questions,
                      //           answers: answers,
                      //         )));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      footer: const [],
    );
  }
}

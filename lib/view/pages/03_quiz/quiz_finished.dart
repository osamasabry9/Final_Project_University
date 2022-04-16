// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app_api/layouts/main_layout.dart';
import 'package:quiz_app_api/view/pages/02_home/home.dart';

// ignore: must_be_immutable
class QuizFinishedPage extends StatelessWidget {
  final int totalQuestion;
  final int currentScore;
  final int totalScore;

  const QuizFinishedPage({Key? key, required this.currentScore, required this.totalScore, required this.totalQuestion, }) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
                  title: const Text("Total Score", style: titleStyle),
                  trailing: Text("$totalScore", style: trailingStyle),
                ),
              ),
              const SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: const Text("Score", style: titleStyle),
                  trailing: Text("${currentScore / totalQuestion * 100}%",
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
                  trailing: Text("$currentScore/$totalQuestion",
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
                      "${totalQuestion- currentScore}/$totalQuestion",
                      style: trailingStyle),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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

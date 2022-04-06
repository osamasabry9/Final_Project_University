import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:quiz_app_api/models/exam_model.dart';
import 'package:quiz_app_api/shared/config/app_colors.dart';
import 'package:quiz_app_api/layouts/main_layout.dart';
import 'package:quiz_app_api/models/question.dart';
import 'package:quiz_app_api/view/pages/03_quiz/quiz_list.dart';
import 'package:quiz_app_api/view/widgets/main_button.dart';

class QuizPage extends StatefulWidget {
  final DataExam question;
  final int indexQuestion;

  const QuizPage({
    Key? key,
    required this.question,
    required this.indexQuestion,
  }) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final TextStyle _questionStyle = const TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: AppColors.kBlackColor,
  );

  int? _currentIndex;

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // disableCapture();
    _currentIndex = widget.indexQuestion;
  }

  @override
  Widget build(BuildContext context) {
    DataExam question = widget.question;
    final List<dynamic> options = [];
    if (question.qtype == 'M') {
      options.add(question.a);
      options.add(question.b);
      options.add(question.b);
      options.add(question.c);
    }
    // if (!options.contains(question.correctAnswer)) {
    //   options.add(question.correctAnswer);
    //   options.shuffle();
    // }

    return WillPopScope(
      onWillPop: () async {
        bool? result = (await _onWillPop) as bool?;
        result ??= false;
        return result;
      },
      child: MainLayout(
        scaffoldKey: _key,
        body: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: AppColors.MAIN.withOpacity(0.5),
                        child: Text(
                          "${_currentIndex! + 1}",
                          style: _questionStyle,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Text(
                          HtmlUnescape().convert(question.questionx!),
                          softWrap: true,
                          style: _questionStyle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50.0),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // ...question.incorrectAnswers.map(
                        //   (option) => RadioListTile<String>(
                        //     title: Text(HtmlUnescape().convert("$option")),
                        //     groupValue: QuizList.answers[_currentIndex],
                        //     value: option,
                        //     onChanged: (value) {
                        //       setState(() {
                        //         QuizList.answers[_currentIndex!] = option;
                        //       });
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        footer: [
          MainButton(
            title: "Submit",
            onTap: _nextSubmit,
          ),
        ],
      ),
    );
  }

  void _nextSubmit() {
    if (QuizList.answers[_currentIndex] == null) {
      // ignore: deprecated_member_use
      _key.currentState!.showSnackBar(const SnackBar(
        content: Text("You must select an answer to continue."),
      ));
      return;
    } else {
      // ignore: avoid_print
      print('${QuizList.answers}');
      Get.back();
    }
  }

  Future<Future<bool?>> get _onWillPop async {
    return showDialog<bool>(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: const Text(
                "Are you sure you want to quit the quiz? All your progress will be lost."),
            title: const Text("Warning!"),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("Yes"),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              ElevatedButton(
                child: const Text("No"),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
            ],
          );
        });
  }

  void disableCapture() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }
}
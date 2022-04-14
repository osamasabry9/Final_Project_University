import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:quiz_app_api/models/exam_model.dart';
import 'package:quiz_app_api/shared/config/app_colors.dart';
import 'package:quiz_app_api/layouts/main_layout.dart';
import 'package:quiz_app_api/view/pages/03_quiz/quiz_list.dart';
import 'package:quiz_app_api/view/widgets/input_field.dart';
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

  //int? _currentIndex;
  int? _indexQuestion;

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // disableCapture();
    //_currentIndex = widget.question.id;
    _indexQuestion = widget.indexQuestion;
  }

  @override
  Widget build(BuildContext context) {
    DataExam question = widget.question;

    return WillPopScope(
      onWillPop: () async {
        bool? result = (await _onWillPop) as bool?;
        result ??= false;
        return result;
      },
      child: MainLayout(
        scaffoldKey: _key,
        body: SingleChildScrollView(
          child: Stack(
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
                            "${_indexQuestion! + 1}",
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
                    listMultichoice(question),
                  ],
                ),
              )
            ],
          ),
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

  Widget listMultichoice(DataExam question) {
    var a = 'a';
    var b = 'b';
    var c = 'c';
    var d = 'd';
    TextEditingController textAnswerController = TextEditingController();
    return Card(
      child: question.qtype == 'M' || question.qtype == 'Y'
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RadioListTile<String>(
                  title: Text(HtmlUnescape().convert('A :  ${question.a}')),
                  value: a,
                  groupValue: QuizList.answersList![_indexQuestion!].answer,
                  onChanged: (_) {
                    setState(() {
                      QuizList.answersList![_indexQuestion!].answer = a;
                      QuizList.answersList![_indexQuestion!].id = question.id;
                      QuizList.answersList![_indexQuestion!].qtype =
                          question.qtype;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text(HtmlUnescape().convert('B :  ${question.b}')),
                  value: b,
                  groupValue: QuizList.answersList![_indexQuestion!].answer,
                  onChanged: (_) {
                    setState(() {
                      QuizList.answersList![_indexQuestion!].answer = b;
                      QuizList.answersList![_indexQuestion!].id = question.id;
                      QuizList.answersList![_indexQuestion!].qtype =
                          question.qtype;
                      ;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text(HtmlUnescape().convert('C :  ${question.c}')),
                  value: c,
                  groupValue: QuizList.answersList![_indexQuestion!].answer,
                  onChanged: (_) {
                    setState(() {
                      QuizList.answersList![_indexQuestion!].answer = c;
                      QuizList.answersList![_indexQuestion!].id = question.id;
                      QuizList.answersList![_indexQuestion!].qtype =
                          question.qtype;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text(HtmlUnescape().convert('D :  ${question.d}')),
                  value: d,
                  groupValue: QuizList.answersList![_indexQuestion!].answer,
                  onChanged: (_) {
                    setState(() {
                      QuizList.answersList![_indexQuestion!].answer = d;
                      QuizList.answersList![_indexQuestion!].id = question.id;
                      QuizList.answersList![_indexQuestion!].qtype =
                          question.qtype;
                      ;
                    });
                  },
                ),
              ],
            )
          : question.qtype == 'T'
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RadioListTile<String>(
                      title: Text(HtmlUnescape().convert('A :  ${question.a}')),
                      value: a,
                      groupValue: QuizList.answersList![_indexQuestion!].answer,
                      onChanged: (_) {
                        setState(() {
                          QuizList.answersList![_indexQuestion!].answer = a;
                          QuizList.answersList![_indexQuestion!].id =
                              question.id;
                          QuizList.answersList![_indexQuestion!].qtype =
                              question.qtype;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text(HtmlUnescape().convert('B :  ${question.b}')),
                      value: b,
                      groupValue: QuizList.answersList![_indexQuestion!].answer,
                      onChanged: (_) {
                        setState(() {
                          QuizList.answersList![_indexQuestion!].answer = b;
                          QuizList.answersList![_indexQuestion!].id =
                              question.id;
                          QuizList.answersList![_indexQuestion!].qtype =
                              question.qtype;
                        });
                      },
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InputField(
                      label: 'Enter your answer',
                      textController: textAnswerController,
                      validate: (String? text) {},
                    ),
                  ],
                ),
    );
  }

  void _nextSubmit() {
    if (QuizList.answersList![_indexQuestion!].answer == null) {
      // ignore: deprecated_member_use
      _key.currentState!.showSnackBar(const SnackBar(
        content: Text("You must select an answer to continue."),
      ));
      return;
    } else {
      // ignore: avoid_print
      print('${QuizList.answersList![_indexQuestion!].answer} , ${QuizList.answersList![_indexQuestion!].id}');
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

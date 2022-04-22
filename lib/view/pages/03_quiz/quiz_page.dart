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
      child: question.qtype == 'M'
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _radioList(question, a, question.a),
                _radioList(question, b, question.b),
                _radioList(question, c, question.c),
                _radioList(question, d, question.d),
              ],
            )
          : question.qtype == 'Y'
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _checkboxList(
                        question,
                        a,
                        question.a,
                        QuizList.answersMap[_indexQuestion!]!.answer!
                            .split(',')),
                    _checkboxList(
                        question,
                        b,
                        question.b,
                        QuizList.answersMap[_indexQuestion!]!.answer!
                            .split(',')),
                    _checkboxList(
                        question,
                        c,
                        question.c,
                        QuizList.answersMap[_indexQuestion!]!.answer!
                            .split(',')),
                    _checkboxList(
                        question,
                        d,
                        question.d,
                        QuizList.answersMap[_indexQuestion!]!.answer!
                            .split(',')),
                  ],
                )
              : question.qtype == 'T'
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        _radioList(question, a, question.a),
                        _radioList(question, b, question.b),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InputField(
                          label: 'Enter your answer',
                          textController: textAnswerController,
                          validate: (String? text) {},
                          onFieldSubmitted: (String? value)
                          {
                            setState(() {
          QuizList.answersMap[_indexQuestion!]!.answer = value;
          QuizList.answersMap[_indexQuestion!]!.id = question.id;
          QuizList.answersMap[_indexQuestion!]!.qtype = question.qtype;
        });
                            return null;
                          },
                        ),
                      ],
                    ),
    );
  }

  RadioListTile<String> _radioList(
      DataExam question, String value, String? textAnswer) {
    return RadioListTile<String>(
      title:
          Text(HtmlUnescape().convert('${value.toUpperCase()} :  $textAnswer')),
      value: value,
      groupValue: QuizList.answersMap[_indexQuestion!]!.answer,
      onChanged: (_) {
        setState(() {
          QuizList.answersMap[_indexQuestion!]!.answer = value;
          QuizList.answersMap[_indexQuestion!]!.id = question.id;
          QuizList.answersMap[_indexQuestion!]!.qtype = question.qtype;
        });
      },
    );
  }

  CheckboxListTile _checkboxList(
    DataExam question,
    String valueAnswer,
    String? textAnswer,
    List selected,
  ) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      value: selected.contains(valueAnswer),
      onChanged: (value) {
        setState(() {
          if (selected.contains(valueAnswer)) {
            selected.remove(valueAnswer);
            QuizList.answersMap[_indexQuestion!]!.answer = selected.join(',');
          } else {
            selected.add(valueAnswer);
            QuizList.answersMap[_indexQuestion!]!.answer = selected.join(',');
          }

          QuizList.answersMap[_indexQuestion!]!.id = question.id;
          QuizList.answersMap[_indexQuestion!]!.qtype = question.qtype;
        });
      },
      activeColor: AppColors.MAIN,
      title: Text(HtmlUnescape()
          .convert('${valueAnswer.toUpperCase()} :  $textAnswer')),
    );
  }

  void _nextSubmit() {
    if (QuizList.answersMap[_indexQuestion!]!.answer == null) {
      // ignore: deprecated_member_use
      _key.currentState!.showSnackBar(const SnackBar(
        content: Text("You must select an answer to continue."),
      ));
      return;
    } else {
      // ignore: avoid_print
      print(
          '${QuizList.answersMap[_indexQuestion!]!.answer} , ${QuizList.answersMap[_indexQuestion!]!.id} , ${QuizList.answersMap[_indexQuestion!]!.qtype},');
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:quiz_app_api/layouts/main_layout.dart';
import 'package:quiz_app_api/models/question.dart';
import 'package:quiz_app_api/view/widgets/main_button.dart';

import '../02_home/home.dart';

class CheckAnswersPage extends StatelessWidget {
  final List<Question> questions;
  final Map<int, dynamic> answers;

  // ignore: use_key_in_widget_constructors
  const CheckAnswersPage({required this.questions, required this.answers});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      isFooter: false,
      showBack: false,
      title: 'Check Answers',
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: questions.length + 1,
        itemBuilder: _buildItem,
      ),
      footer: const [],
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    if (index == questions.length) {
      return MainButton(
        title: "Done",
        onTap: () {
          Get.off(() => HomePage());
        },
      );
    }
    Question question = questions[index];
    bool correct = question.correctAnswer == answers[index];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              HtmlUnescape().convert(question.question),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0),
            ),
            const SizedBox(height: 5.0),
            Text(
              HtmlUnescape().convert("${answers[index]}"),
              style: TextStyle(
                  color: correct ? Colors.green : Colors.red,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5.0),
            correct
                ? Container()
                : Text.rich(
                    TextSpan(children: [
                      const TextSpan(text: "Answer: "),
                      TextSpan(
                          text: HtmlUnescape().convert(question.correctAnswer),
                          style: const TextStyle(fontWeight: FontWeight.w500))
                    ]),
                    style: const TextStyle(fontSize: 16.0),
                  )
          ],
        ),
      ),
    );
  }
}

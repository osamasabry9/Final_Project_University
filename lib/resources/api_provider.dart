import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_app_api/models/question.dart';

const String baseUrl = "https://opentdb.com/api.php";

Future<List<Question>> getQuestions() async {
  String url = "$baseUrl?amount=10&category=18";
  // ignore: unnecessary_null_comparison
  // if(difficulty != null) {
  //   url = "$url&difficulty=$difficulty";
  // }
  http.Response res = await http.get(Uri.parse(url));
  List<Map<String, dynamic>> questions =
      List<Map<String, dynamic>>.from(json.decode(res.body)["results"]);
  return Question.fromData(questions);
}

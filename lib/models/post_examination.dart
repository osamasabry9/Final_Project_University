class AddAnswers {
  String? stdId;
  int? courseId;
  List<Answers>? answers;

  AddAnswers({this.stdId, this.courseId, this.answers});

  AddAnswers.fromJson(Map<String, dynamic> json) {
    stdId = json['std_id'];
    courseId = json['course_id'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(new Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['std_id'] = this.stdId;
    data['course_id'] = this.courseId;
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  int? id;
  String? answer;
  String? qtype;

  Answers({this.id, this.answer, this.qtype});

  Answers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    answer = json['answer'];
    qtype = json['qtype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['answer'] = this.answer;
    data['qtype'] = this.qtype;
    return data;
  }
}
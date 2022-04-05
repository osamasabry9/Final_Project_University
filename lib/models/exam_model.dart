class ExamModel {
  int? id;
  String? questionx;
  String? qtype;
  String? a;
  String? b;
  String? c;
  String? d;
  String? hint;
  int? courseId;

  ExamModel(
      {this.id,
      this.questionx,
      this.qtype,
      this.a,
      this.b,
      this.c,
      this.d,
      this.hint,
      this.courseId});

  ExamModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionx = json['questionx'];
    qtype = json['qtype'];
    a = json['a'];
    b = json['b'];
    c = json['c'];
    d = json['d'];
    hint = json['hint'];
    courseId = json['courseId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['questionx'] = this.questionx;
    data['qtype'] = this.qtype;
    data['a'] = this.a;
    data['b'] = this.b;
    data['c'] = this.c;
    data['d'] = this.d;
    data['hint'] = this.hint;
    data['courseId'] = this.courseId;
    return data;
  }
}

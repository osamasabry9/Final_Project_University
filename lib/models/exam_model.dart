class ExamModel {
  bool? status;
  String? message;
  List<DataExam>? data;

  ExamModel({this.status, this.message, this.data});

  ExamModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataExam>[];
      json['data'].forEach((v) {
        data!.add(new DataExam.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataExam {
  int? id;
  String? questionx;
  String? qtype;
  String? a;
  String? b;
  String? c;
  String? d;
  String? hint;
  int? courseId;

  DataExam(
      {this.id,
      this.questionx,
      this.qtype,
      this.a,
      this.b,
      this.c,
      this.d,
      this.hint,
      this.courseId});

  DataExam.fromJson(Map<String, dynamic> json) {
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


  // static List<ExamModel> fromData(List<Map<String, dynamic>> data) {
  //   return data.map((questionx) => ExamModel.fromJson(questionx)).toList();
  // }

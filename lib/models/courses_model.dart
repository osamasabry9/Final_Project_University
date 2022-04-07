// ignore_for_file: unnecessary_new, unnecessary_this, prefer_collection_literals

class StudentCoursesModel {
  bool? status;
  String? message;
  List<Data>? data;

  StudentCoursesModel({this.status, this.message, this.data});

  StudentCoursesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? courseId;
  String? courseName;
  String? startTime;
  int? durationInMinutes;
  bool? isExaminated;
  int? currentMarks;
  int? totalMarks;

  Data(
      {this.courseId,
      this.courseName,
      this.startTime,
      this.durationInMinutes,
      this.isExaminated,
      this.currentMarks,
      this.totalMarks});

  Data.fromJson(Map<String, dynamic> json) {
    courseId = json['courseId'];
    courseName = json['courseName'];
    startTime = json['startTime'];
    durationInMinutes = json['durationInMinutes'];
    isExaminated = json['isExaminated'];
    currentMarks = json['currentMarks'];
    totalMarks = json['totalMarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseId'] = this.courseId;
    data['courseName'] = this.courseName;
    data['startTime'] = this.startTime;
    data['durationInMinutes'] = this.durationInMinutes;
    data['isExaminated'] = this.isExaminated;
    data['currentMarks'] = this.currentMarks;
    data['totalMarks'] = this.totalMarks;
    return data;
  }
}

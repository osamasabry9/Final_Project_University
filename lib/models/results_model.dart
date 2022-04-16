class ResultsExamination {
  bool? status;
  String? message;
  Data? data;

  ResultsExamination({this.status, this.message, this.data});

  ResultsExamination.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['message'] = this.message;
  //   if (this.data != null) {
  //     data['data'] = this.data!.toJson();
  //   }
  //   return data;
  // }
}

class Data {
  int? id;
  int? currentScore;
  int? totalScore;

  Data({this.id, this.currentScore, this.totalScore});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currentScore = json['currentScore'];
    totalScore = json['totalScore'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['currentScore'] = this.currentScore;
  //   data['totalScore'] = this.totalScore;
  //   return data;
  // }
}

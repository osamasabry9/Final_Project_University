// ignore_for_file: unnecessary_new, unnecessary_this, prefer_collection_literals

class UserModelNew {
  bool? status;
  String? message;
  Data? data;

  UserModelNew({this.status, this.message, this.data});

  UserModelNew.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  String? expiration;
  UserDetails? userDetails;

  Data({this.token, this.expiration, this.userDetails});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expiration = json['expiration'];
    userDetails = json['userDetails'] != null
        ? new UserDetails.fromJson(json['userDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['expiration'] = this.expiration;
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails!.toJson();
    }
    return data;
  }
}

class UserDetails {
  String? id;
  String? firstname;
  String? lastname;
  String? userName;
  String? email;

  UserDetails(
      {this.id, this.firstname, this.lastname, this.userName, this.email});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    userName = json['userName'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['userName'] = this.userName;
    data['email'] = this.email;
    return data;
  }
}

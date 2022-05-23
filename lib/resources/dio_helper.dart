// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    // ignore: avoid_print
    print('dioHelper Initialized');
    dio = Dio(BaseOptions(
      baseUrl: 'https://0b39-156-210-61-184.ngrok.io',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    //String lang = 'en',
    String? token,
    Map<String, dynamic>? data,
  }) async {
    dio.options.headers = {
      //'lang':lang,
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? query,
      Map<String, dynamic>? data,
      //String lang = 'en',
      String? token}) async {
    dio.options.headers = {
      //'lang':lang,
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData(
      {required String url,
      Map<String, dynamic>? query,
      Map<String, dynamic>? data,
      //String lang = 'en',
      String? token}) async {
    dio.options.headers = {
      //'lang':lang,
      'Content-Type': 'application/json',
      'Authorization': '$token'
    };
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> deleteData(
      {required String url,
      //String lang = 'en',
      String? token}) async {
    dio.options.headers = {
      //'lang':lang,
      'Content-Type': 'application/json',
      'Authorization': '$token'
    };
    return await dio.delete(url);
  }
}

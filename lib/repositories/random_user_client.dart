import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter_tinder/models/models.dart';

class RandomUserClient {
  const RandomUserClient({this.url = "https://randomuser.me/api/0.4"});

  final String url;

  Future<User> getUser({String gender = "female"}) async {
    try {
      dio.Response dioResponse = await dio.Dio().get(
        url + "/?randomapiyy",
        queryParameters: {"gender": gender},
      );
      Response response = Response.fromJson(dioResponse.data);
      if (response.results.isEmpty) {
        throw Exception("Results is Empty");
      }
      return response.results[0].user;
    } on dio.DioError catch (e) {
      throw Exception(e.response.data["error"]);
    }
  }

  Future<List<User>> getUsers(
      {String gender = "female", int page = 0, int results = 20}) async {
    try {
      final dio.Dio dioValue = dio.Dio()
        ..interceptors.add(
          dio.LogInterceptor(requestBody: true, responseBody: true),
        );

      dio.Response dioResponse = await dioValue.get(
        url + "/?randomapiyy",
        options: dio.Options(sendTimeout: 1000),
        queryParameters: {
          "gender": gender,
          "page": page,
          "results": results,
        },
      );

      Response response = Response.fromJson(jsonDecode(dioResponse.data));
      if (response.results.isEmpty) {
        throw Exception("empty");
      }
      return response.results.map((result) => result.user).toList();
    } on dio.DioError catch (e) {
      if (e.type == dio.DioErrorType.DEFAULT) {
        throw Exception("network");
      }
      if (e.message.isNotEmpty) {
        throw Exception(e.message);
      }
      throw Exception(e.response.data["error"]);
    }
  }
}

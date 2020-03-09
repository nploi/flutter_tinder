import 'package:dio/dio.dart' as dio;
import 'package:flutter_tinder/models/models.dart';

class RandomUserClient {
  final String url = "https://randomuser.me/api/0.4";

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
      {String gender = "female", int page = 0, int result = 10}) async {
    try {
      dio.Response dioResponse = await dio.Dio().get(
        url + "/?randomapiyy",
        queryParameters: {
          "gender": gender,
          "page": page,
          "result": result,
        },
      );
      Response response = Response.fromJson(dioResponse.data);
      if (response.results.isEmpty) {
        throw Exception("Results is Empty");
      }
      return response.results.map((result) => result.user).toList();
    } on dio.DioError catch (e) {
      throw Exception(e.response.data["error"]);
    }
  }
}

import 'package:flutter_tinder/models/models.dart';
import 'package:flutter_tinder/repositories/random_user_client.dart';

class TinderRepository {
  const TinderRepository({this.client = const RandomUserClient()});
  final RandomUserClient client;

  Future<List<User>> getUsers({int page = 0, String gender = "female"}) async {
    return client.getUsers(page: page, gender: gender, results: 5);
  }
}

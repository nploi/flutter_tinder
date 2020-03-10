import 'dart:convert';

import 'package:flutter_tinder/models/models.dart';
import 'package:flutter_tinder/repositories/random_user_client.dart';
import 'package:flutter_tinder/services/services.dart';

class TinderRepository {
  const TinderRepository({this.client = const RandomUserClient()});
  final RandomUserClient client;

  Future<List<User>> getUsers({int page = 0}) async {
    var settings = getSetting();
    String gender = "";
    if (settings.showMale && settings.showFemale) {
      gender = "male,female";
    } else if (settings.showFemale) {
      gender = "female";
    } else if (settings.showMale) {
      gender = "male";
    }
    return client.getUsers(
      page: page,
      gender: gender,
      results: 10,
    );
  }

  Settings getSetting() {
    var value =
        locator<StorageDeviceService>().get(StorageDeviceService.settingsKey);
    if (value == null) {
      return Settings();
    }
    return Settings.fromJson(jsonDecode(value));
  }
}

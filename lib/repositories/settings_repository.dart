import 'dart:convert';

import 'package:flutter_tinder/models/models.dart';
import 'package:flutter_tinder/services/locator.dart';
import 'package:flutter_tinder/services/storage_device.dart';

class SettingsRepository {
  const SettingsRepository();

  Future<void> updateSetting(Settings settings) async {
    await locator<StorageDeviceService>()
        .set(StorageDeviceService.settingsKey, jsonEncode(settings.toJson()));
    return;
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

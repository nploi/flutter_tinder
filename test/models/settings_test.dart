import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tinder/models/models.dart';

void main() {
  group("Settings", () {
    test("toJson", () {
      Settings settings = Settings(languageCode: "vi");
      expect(settings.toJson(),
          {'language_code': 'vi', 'show_male': false, 'show_female': true});
    });
    test("fromJson", () {
      Settings settings = Settings(languageCode: "vi");
      var json = {
        'language_code': 'vi',
        'show_male': false,
        'show_female': true
      };
      expect(Settings.fromJson(json).toJson(), settings.toJson());
    });
  });
}

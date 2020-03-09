import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tinder/models/models.dart';

void main() {
  group("Settings", () {
    test("toJson", () {
      Settings settings = Settings(languageCode: "vi");
      expect(settings.toJson(), {"language_code": "vi"});
    });
    test("fromJson", () {
      Settings settings = Settings(languageCode: "vi");
      var json = {"language_code": "vi"};
      expect(Settings.fromJson(json).toJson(), settings.toJson());
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tinder/models/models.dart';

void main() {
  group("Name", () {
    test("toJson", () {
      Name location = Name(title: "Loi Nguyen", last: "Loi", first: "Nguyen");
      expect(location.toJson(), {
        "title": "Loi Nguyen",
        "last": "Loi",
        "first": "Nguyen",
      });
    });
    test("fromJson", () {
      Name location = Name(title: "Loi Nguyen", last: "Loi", first: "Nguyen");
      var json = {
        "title": "Loi Nguyen",
        "last": "Loi",
        "first": "Nguyen",
      };
      expect(Name.fromJson(json).toJson(), location.toJson());
    });
  });
}

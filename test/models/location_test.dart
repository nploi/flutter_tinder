import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tinder/models/models.dart';

void main() {
  group("Location", () {
    test("toJson", () {
      Location location = Location(
        city: "Ho Chi Minh",
        state: "Binh Thanh",
        street: "Pham The Hiem",
        zip: "700000",
      );
      expect(location.toJson(), {
        "city": "Ho Chi Minh",
        "state": "Binh Thanh",
        "street": "Pham The Hiem",
        "zip": "700000",
      });
    });
    test("fromJson", () {
      Location location = Location(
        city: "Ho Chi Minh",
        state: "Binh Thanh",
        street: "Pham The Hiem",
        zip: "700000",
      );
      var json = {
        "city": "Ho Chi Minh",
        "state": "Binh Thanh",
        "street": "Pham The Hiem",
        "zip": "700000",
      };
      expect(Location.fromJson(json).toJson(), location.toJson());
    });
  });
}

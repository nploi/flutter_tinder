import "package:flutter_test/flutter_test.dart";
import "package:flutter_tinder/models/models.dart";

void main() {
  group("User", () {
    test("toJson", () {
      User user = User(
        name: Name(
          first: "Nguyen",
          last: "Loi",
          title: "Loi Nguyen",
        ),
        location: Location(
          city: "Ho Chi Minh",
          state: "Binh Thanh",
          street: "Pham The Hiem",
          zip: "700000",
        ),
        email: "test@gmail.com",
        dob: 1583759733,
        registered: 1583759733,
        gender: "Male",
        phone: "+8412345678",
        picture: "https://www.test.com/test.png",
        username: "loi",
      );
      expect(user.toJson(), {
        "gender": "Male",
        "name": {"title": "Loi Nguyen", "first": "Nguyen", "last": "Loi"},
        "location": {
          "street": "Pham The Hiem",
          "city": "Ho Chi Minh",
          "state": "Binh Thanh",
          "zip": "700000"
        },
        "email": "test@gmail.com",
        "username": "loi",
        "registered": 1583759733,
        "dob": 1583759733,
        "phone": "+8412345678",
        "picture": "https://www.test.com/test.png"
      });
    });

    test("fromJson", () {
      User user = User(
        name: Name(
          first: "Nguyen",
          last: "Loi",
          title: "Loi Nguyen",
        ),
        location: Location(
          city: "Ho Chi Minh",
          state: "Binh Thanh",
          street: "Pham The Hiem",
          zip: "700000",
        ),
        email: "test@gmail.com",
        dob: 1583759733,
        registered: 1583759733,
        gender: "Male",
        phone: "+8412345678",
        picture: "https://www.test.com/test.png",
        username: "loi",
      );
      var json = {
        "gender": "Male",
        "name": {"title": "Loi Nguyen", "first": "Nguyen", "last": "Loi"},
        "location": {
          "street": "Pham The Hiem",
          "city": "Ho Chi Minh",
          "state": "Binh Thanh",
          "zip": "700000"
        },
        "email": "test@gmail.com",
        "username": "loi",
        "registered": 1583759733,
        "dob": 1583759733,
        "phone": "+8412345678",
        "picture": "https://www.test.com/test.png"
      };
      expect(User.fromJson(json).toJson(), user.toJson());
    });

    test("toDatabaseJson", () {
      User user = User(
        id: 1,
        name: Name(
          first: "Nguyen",
          last: "Loi",
          title: "Loi Nguyen",
        ),
        location: Location(
          city: "Ho Chi Minh",
          state: "Binh Thanh",
          street: "Pham The Hiem",
          zip: "700000",
        ),
        email: "test@gmail.com",
        dob: 1583759733,
        registered: 1583759733,
        gender: "Male",
        phone: "+8412345678",
        picture: "https://www.test.com/test.png",
        username: "loi",
      );
      expect(user.toDatabaseJson(), {
        "id": 1,
        "gender": "Male",
        "name": '{"title":"Loi Nguyen","first":"Nguyen","last":"Loi"}',
        "location": '{"street":"Pham The Hiem","city":"Ho Chi Minh",'
            '"state":"Binh Thanh","zip":"700000"}',
        "email": "test@gmail.com",
        "username": "loi",
        "registered": 1583759733,
        "dob": 1583759733,
        "phone": "+8412345678",
        "picture": "https://www.test.com/test.png"
      });
    });

    test("fromDatabaseJson", () {
      User user = User(
        id: 1,
        name: Name(
          first: "Nguyen",
          last: "Loi",
          title: "Loi Nguyen",
        ),
        location: Location(
          city: "Ho Chi Minh",
          state: "Binh Thanh",
          street: "Pham The Hiem",
          zip: "700000",
        ),
        email: "test@gmail.com",
        dob: 1583759733,
        registered: 1583759733,
        gender: "Male",
        phone: "+8412345678",
        picture: "https://www.test.com/test.png",
        username: "loi",
      );
      var json = {
        "id": 1,
        "gender": "Male",
        "name": '{"title":"Loi Nguyen","first":"Nguyen","last":"Loi"}',
        "location": '{"street":"Pham The Hiem","city":"Ho Chi Minh",'
            '"state":"Binh Thanh","zip":"700000"}',
        "email": "test@gmail.com",
        "username": "loi",
        "registered": 1583759733,
        "dob": 1583759733,
        "phone": "+8412345678",
        "picture": "https://www.test.com/test.png"
      };
      expect(
          User.fromDatabaseJson(json).toDatabaseJson(), user.toDatabaseJson());
    });
  });
}

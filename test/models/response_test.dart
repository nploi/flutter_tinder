import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tinder/models/models.dart';

void main() {
  group("Response", () {
    test("toJson", () {
      Response settings = Response(results: [
        Results(
          seed: "12345",
          version: "0.0.1",
          user: User(
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
          ),
        )
      ]);
      expect(settings.toJson(), {
        'results': [
          {
            'user': {
              'gender': 'Male',
              'name': {'title': 'Loi Nguyen', 'first': 'Nguyen', 'last': 'Loi'},
              'location': {
                'street': 'Pham The Hiem',
                'city': 'Ho Chi Minh',
                'state': 'Binh Thanh',
                'zip': '700000'
              },
              'email': 'test@gmail.com',
              'username': 'loi',
              'registered': 1583759733,
              'dob': 1583759733,
              'phone': '+8412345678',
              'picture': 'https://www.test.com/test.png'
            },
            'seed': '12345',
            'version': '0.0.1'
          }
        ]
      });
    });
    test("fromJson", () {
      Response settings = Response(results: [
        Results(
          seed: "12345",
          version: "0.0.1",
          user: User(
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
          ),
        )
      ]);
      var json = {
        'results': [
          {
            'user': {
              'gender': 'Male',
              'name': {'title': 'Loi Nguyen', 'first': 'Nguyen', 'last': 'Loi'},
              'location': {
                'street': 'Pham The Hiem',
                'city': 'Ho Chi Minh',
                'state': 'Binh Thanh',
                'zip': '700000'
              },
              'email': 'test@gmail.com',
              'username': 'loi',
              'registered': 1583759733,
              'dob': 1583759733,
              'phone': '+8412345678',
              'picture': 'https://www.test.com/test.png'
            },
            'seed': '12345',
            'version': '0.0.1'
          }
        ]
      };
      expect(Response.fromJson(json).toJson(), settings.toJson());
    });
  });
}

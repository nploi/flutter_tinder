@Skip("sqflite cannot run on the machine.")

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tinder/data/database_provider.dart';
import 'package:flutter_tinder/data/user.dart';
import 'package:flutter_tinder/models/models.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

const String testDBPath = "somepath";

UserDao dao;
GetIt getIt = GetIt.instance;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  getIt.registerLazySingleton<DatabaseProvider>(() => DatabaseProvider());

  group("User Database tests", () {
    // Init database
    setUp(() async {
      final String databasePath = await getDatabasesPath();
      await getIt<DatabaseProvider>()
          .boot(path: path.join(databasePath, testDBPath));
      dao = const UserDao();
    });

    // Delete the database so every test run starts with a fresh database
    tearDownAll(() async {
      final String databasePath = await getDatabasesPath();
      await deleteDatabase(path.join(databasePath, testDBPath));
    });

    test("should insert and query user by id", () async {
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
      try {
        var id = await dao.createUser(user: user);
        expect(id, isNotNull);

        var userQuery = await dao.getUserById(id: id);
        user.id = userQuery.id;

        expect(userQuery.name.title, equals(user.name.title));
        expect(userQuery.name.first, equals(user.name.first));
        expect(userQuery.name.last, equals(user.name.last));
        expect(userQuery.location.city, equals(user.location.city));
        expect(userQuery.location.state, equals(user.location.state));
        expect(userQuery.location.street, equals(user.location.street));
        expect(userQuery.location.zip, equals(user.location.zip));
        expect(userQuery.email, equals(user.email));
        expect(userQuery.registered, equals(user.registered));
        expect(userQuery.dob, equals(user.dob));
        expect(userQuery.gender, equals(user.gender));
        expect(userQuery.phone, equals(user.phone));
        expect(userQuery.picture, equals(user.picture));
        expect(userQuery.username, equals(user.username));
      } catch (exception) {
        expect(false, true);
      }

      // Delete after test
      {
        try {
          var affected = await dao.deleteUser(id: user.id);
          expect(affected, 1);

          var userQuery = await dao.getUserById(id: user.id);
          expect(userQuery, isNull);
        } catch (exception) {
          expect(false, true);
        }
      }
    });

    test("should insert, update and query user by id", () async {
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

      // Create
      {
        try {
          user.id = await dao.createUser(user: user);
          expect(user.id, isNotNull);

          var userQuery = await dao.getUserById(id: user.id);
          user.id = userQuery.id;

          expect(userQuery.name.title, equals(user.name.title));
          expect(userQuery.name.first, equals(user.name.first));
          expect(userQuery.name.last, equals(user.name.last));
          expect(userQuery.location.city, equals(user.location.city));
          expect(userQuery.location.state, equals(user.location.state));
          expect(userQuery.location.street, equals(user.location.street));
          expect(userQuery.location.zip, equals(user.location.zip));
          expect(userQuery.email, equals(user.email));
          expect(userQuery.registered, equals(user.registered));
          expect(userQuery.dob, equals(user.dob));
          expect(userQuery.gender, equals(user.gender));
          expect(userQuery.phone, equals(user.phone));
          expect(userQuery.picture, equals(user.picture));
          expect(userQuery.username, equals(user.username));
        } catch (exception) {
          expect(false, true);
        }
      }

      // Update
      {
        user.email = "update@gmail.com";
        try {
          var affected = await dao.updateUser(user: user);
          expect(affected, 1);

          var userQuery = await dao.getUserById(id: user.id);

          expect(userQuery.name.title, equals(user.name.title));
          expect(userQuery.name.first, equals(user.name.first));
          expect(userQuery.name.last, equals(user.name.last));
          expect(userQuery.location.city, equals(user.location.city));
          expect(userQuery.location.state, equals(user.location.state));
          expect(userQuery.location.street, equals(user.location.street));
          expect(userQuery.location.zip, equals(user.location.zip));
          expect(userQuery.email, equals("update@gmail.com"));
          expect(userQuery.registered, equals(user.registered));
          expect(userQuery.dob, equals(user.dob));
          expect(userQuery.gender, equals(user.gender));
          expect(userQuery.phone, equals(user.phone));
          expect(userQuery.picture, equals(user.picture));
          expect(userQuery.username, equals(user.username));
        } catch (exception) {
          expect(false, true);
        }

        // Delete after test
        {
          try {
            var affected = await dao.deleteUser(id: user.id);
            expect(affected, 1);

            var userQuery = await dao.getUserById(id: user.id);
            expect(userQuery, isNull);
          } catch (exception) {
            expect(false, true);
          }
        }
      }
    });

    test("should insert, delete and query user by id", () async {
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
      // Create
      {
        try {
          user.id = await dao.createUser(user: user);
          expect(user.id, isNotNull);

          var userQuery = await dao.getUserById(id: user.id);

          expect(userQuery.name.title, equals(user.name.title));
          expect(userQuery.name.first, equals(user.name.first));
          expect(userQuery.name.last, equals(user.name.last));
          expect(userQuery.location.city, equals(user.location.city));
          expect(userQuery.location.state, equals(user.location.state));
          expect(userQuery.location.street, equals(user.location.street));
          expect(userQuery.location.zip, equals(user.location.zip));
          expect(userQuery.email, equals(user.email));
          expect(userQuery.registered, equals(user.registered));
          expect(userQuery.dob, equals(user.dob));
          expect(userQuery.gender, equals(user.gender));
          expect(userQuery.phone, equals(user.phone));
          expect(userQuery.picture, equals(user.picture));
          expect(userQuery.username, equals(user.username));
        } catch (exception) {
          expect(false, true);
        }
      }

      // Delete
      {
        try {
          var affected = await dao.deleteUser(id: user.id);
          expect(affected, 1);

          var userQuery = await dao.getUserById(id: user.id);
          expect(userQuery, isNull);
        } catch (exception) {
          expect(false, true);
        }
      }
    });

    test("should insert, delete and get all user", () async {
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
      User user1 = User(
        name: Name(
          first: "Nguyen",
          last: "Loi Hai",
          title: "Loi Hai Nguyen",
        ),
        location: Location(
          city: "Ho Chi Minh",
          state: "Binh Thanh",
          street: "Pham The Hiem",
          zip: "700000",
        ),
        email: "test123@gmail.com",
        dob: 1583759733,
        registered: 1583759733,
        gender: "Male",
        phone: "+8412345678",
        picture: "https://www.test.com/test.png",
        username: "loi123",
      );

      // Create
      {
        try {
          user.id = await dao.createUser(user: user);
          expect(user.id, isNotNull);
          user1.id = await dao.createUser(user: user1);
          expect(user.id, isNotNull);

          var usersQuery = await dao.getAllUser();
          expect(usersQuery.length, 2);

          expect(usersQuery[0].name.title, equals(user.name.title));
          expect(usersQuery[0].name.first, equals(user.name.first));
          expect(usersQuery[0].name.last, equals(user.name.last));
          expect(usersQuery[0].location.city, equals(user.location.city));
          expect(usersQuery[0].location.state, equals(user.location.state));
          expect(usersQuery[0].location.street, equals(user.location.street));
          expect(usersQuery[0].location.zip, equals(user.location.zip));
          expect(usersQuery[0].email, equals(user.email));
          expect(usersQuery[0].registered, equals(user.registered));
          expect(usersQuery[0].dob, equals(user.dob));
          expect(usersQuery[0].gender, equals(user.gender));
          expect(usersQuery[0].phone, equals(user.phone));
          expect(usersQuery[0].picture, equals(user.picture));
          expect(usersQuery[0].username, equals(user.username));

          // user1
          expect(usersQuery[1].name.title, equals(user1.name.title));
          expect(usersQuery[1].name.first, equals(user1.name.first));
          expect(usersQuery[1].name.last, equals(user1.name.last));
          expect(usersQuery[1].location.city, equals(user1.location.city));
          expect(usersQuery[1].location.state, equals(user1.location.state));
          expect(usersQuery[1].location.street, equals(user1.location.street));
          expect(usersQuery[1].location.zip, equals(user1.location.zip));
          expect(usersQuery[1].email, equals(user1.email));
          expect(usersQuery[1].registered, equals(user1.registered));
          expect(usersQuery[1].dob, equals(user1.dob));
          expect(usersQuery[1].gender, equals(user1.gender));
          expect(usersQuery[1].phone, equals(user1.phone));
          expect(usersQuery[1].picture, equals(user1.picture));
          expect(usersQuery[1].username, equals(user1.username));
        } catch (exception) {
          expect(false, true);
        }
      }

      // Delete all users
      {
        try {
          var affected = await dao.deleteUser(id: user.id);
          expect(affected, 1);

          var userQuery = await dao.getUserById(id: user.id);
          expect(userQuery, isNull);
        } catch (exception) {
          expect(false, true);
        }

        try {
          var affected = await dao.deleteUser(id: user1.id);
          expect(affected, 1);

          var userQuery = await dao.getUserById(id: user1.id);
          expect(userQuery, isNull);
        } catch (exception) {
          expect(false, true);
        }
      }
    });
  });
}

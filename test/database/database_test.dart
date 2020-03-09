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

    test("should insert and query todo by id", () async {
      User todo = User(
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
      );
//      try {
//        var id = await dao.createUser(todo: todo);
//        expect(id, isNotNull);
//
//        var todoQuery = await dao.getUserById(id: id);
//
//        expect(todoQuery.title, equals(todo.title));
//        expect(todoQuery.expired, equals(todo.expired));
//        expect(todoQuery.done, equals(todo.done));
//        expect(todoQuery.description, equals(todo.description));
//      } catch (exception) {
//        expect(false, true);
//      }
    });

//    test("should insert, update and query todo by id", () async {
//      User todo = User(
//        title: "test",
//        expired: 100,
//        done: false,
//        description: "test game",
//      );
//      // Create
//          {
//        try {
//          todo.id = await dao.createUser(todo: todo);
//          expect(todo.id, isNotNull);
//
//          var todoQuery = await dao.getUserById(id: todo.id);
//
//          expect(todoQuery.title, equals(todo.title));
//          expect(todoQuery.expired, equals(todo.expired));
//          expect(todoQuery.done, equals(todo.done));
//          expect(todoQuery.description, equals(todo.description));
//        } catch (exception) {
//          expect(false, true);
//        }
//      }
//
//      // Update
//          {
//        todo.description = "test update";
//        todo.done = true;
//        try {
//          var affected = await dao.updateUser(todo: todo);
//          expect(affected, 1);
//
//          var todoQuery = await dao.getUserById(id: todo.id);
//
//          expect(todoQuery.title, equals(todo.title));
//          expect(todoQuery.expired, equals(todo.expired));
//          expect(todoQuery.done, equals(true));
//          expect(todoQuery.description, equals("test update"));
//        } catch (exception) {
//          expect(false, true);
//        }
//      }
//    });
//
//    test("should insert, delete and query todo by id", () async {
//      User todo = User(
//        title: "test",
//        expired: 100,
//        done: false,
//        description: "test game",
//      );
//      // Create
//          {
//        try {
//          todo.id = await dao.createUser(todo: todo);
//          expect(todo.id, isNotNull);
//
//          var todoQuery = await dao.getUserById(id: todo.id);
//
//          expect(todoQuery.title, equals(todo.title));
//          expect(todoQuery.expired, equals(todo.expired));
//          expect(todoQuery.done, equals(todo.done));
//          expect(todoQuery.description, equals(todo.description));
//        } catch (exception) {
//          expect(false, true);
//        }
//      }
//
//      // Delete
//          {
//        try {
//          var affected = await dao.deleteUser(id: todo.id);
//          expect(affected, 1);
//
//          var todoQuery = await dao.getUserById(id: todo.id);
//          expect(todoQuery, isNull);
//        } catch (exception) {
//          expect(false, true);
//        }
//      }
//    });
  });
}

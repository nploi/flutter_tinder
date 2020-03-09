import "dart:async";

import 'package:flutter_tinder/models/models.dart';
import 'package:flutter_tinder/services/locator.dart';

import 'database_provider.dart';

const String invalidArgumentsException = "Invalid arguments";

class UserDao {
  const UserDao();
  //Adds new User records
  Future<int> createUser({User user}) async {
    if (user == null) {
      throw Exception(invalidArgumentsException);
    }
    final result = locator<DatabaseProvider>()
        .database
        .insert(userTable, user.toDatabaseJson());
    return result;
  }

  Future<User> getUserById({int id}) async {
    if (id <= 0) {
      throw Exception(invalidArgumentsException);
    }
    List<Map<String, dynamic>> result = await locator<DatabaseProvider>()
        .database
        .query(userTable, where: "id = ?", whereArgs: ["$id"]);
    final List<User> listUser = result.isNotEmpty
        ? result.map((item) => User.fromDatabaseJson(item)).toList()
        : [];
    return listUser.isNotEmpty ? listUser[0] : null;
  }

  //Get All User items
  //Searches if query string was passed
  Future<List<User>> getAllUser() async {
    List<Map<String, dynamic>> result =
        await locator<DatabaseProvider>().database.query(userTable);

    final List<User> listUser = result.isNotEmpty
        ? result.map((item) => User.fromDatabaseJson(item)).toList()
        : [];
    return listUser;
  }

  //Update User record
  Future<int> updateUser({User user}) async {
    if (user == null) {
      throw Exception(invalidArgumentsException);
    }
    final result = await locator<DatabaseProvider>().database.update(
        userTable, user.toDatabaseJson(),
        where: "id = ?", whereArgs: [user.id]);

    return result;
  }

  //Delete User records
  Future<int> deleteUser({int id}) async {
    if (id <= 0) {
      throw Exception(invalidArgumentsException);
    }
    final result = await locator<DatabaseProvider>()
        .database
        .delete(userTable, where: "id = ?", whereArgs: [id]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllUser() async {
    final result = await locator<DatabaseProvider>().database.delete(
          userTable,
        );

    return result;
  }
}

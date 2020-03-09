import "dart:async";
import "package:path/path.dart";
import "package:sqflite/sqflite.dart";

const String userTable = "User";

class DatabaseProvider {
  Database _database;
  Database get database => _database;

  Future boot({String path = ""}) async {
    if (_database != null) {
      return;
    }
    _database = await createDatabase(pathTest: path);
  }

  Future<Database> createDatabase({String pathTest = ""}) async {
    final String databasePath = await getDatabasesPath();

    //"ReactiveUser.db is our database instance name
    final String path = join(databasePath, "ReactiveUser.db");
    final database = await openDatabase(pathTest.isNotEmpty ? pathTest : path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  Future initDB(Database database, int version) async {
    await database.execute("CREATE TABLE IF NOT EXISTS $userTable ("
        "id INTEGER PRIMARY KEY, "
        "gender TEXT, "
        "name TEXT, "
        "location TEXT, "
        "email TEXT, "
        "location TEXT, "
        "username TEXT, "
        "registered INTEGER, "
        "dob INTEGER, "
        "done INTEGER, "
        "description TEXT, "
        "phone TEXT, "
        "picture TEXT, "
        ")");
  }

  void dispose() {
    _database.close();
  }
}

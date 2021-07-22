import 'package:sqflite/sqflite.dart';
import 'package:stockify/constants.dart' as constants;

class LoginData {
  Future<Database> createTable() async {
    var databasesPath = await getDatabasesPath();
    String path = '${databasesPath}user.db';

    Database db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE IF NOT EXISTS User(email TEXT PRIMARY KEY, password TEXT)
        ''');
      },
    );

    return db;
  }

  Future<bool> storeData(
      {required String email, required String password}) async {
    Database db = await createTable();
    try {
      await db.rawInsert('INSERT INTO User VALUES(?, ?)', [email, password]);
      await db.close();
      return true;
    } catch (e) {
      await db.close();
      return false;
    }
  }

  Future<void> fetchData() async {
    Database db = await createTable();
    var result = await db.rawQuery('SELECT * FROM User');

    print(result);

    // constants.email = result[0]['email'].toString();
    // constants.password = result[0]['password'].toString();

    await db.close();
  }

  Future<bool> deleteData() async {
    Database db = await createTable();
    try {
      await db.rawDelete('DELETE FROM User');
      return true;
    } catch (e) {
      return false;
    }
  }
}

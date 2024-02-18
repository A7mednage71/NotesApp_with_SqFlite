import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqFlite {
  static Database? _dp;

  Future<Database?> getdp() async {
    if (_dp == null) {
      _dp = await initial();
      return _dp;
    }
    return _dp;
  }

  initial() async {
    String databasepath = await getDatabasesPath(); // get the databasepath
    String path = join(databasepath, 'Notesdp.dp');
    // add name of database to the path ==> databasepath/Notes.dp
    Database Mydatabase = await openDatabase(path, onCreate: _oncreate);
    return Mydatabase;
  }

  // create tables
  FutureOr<void> _oncreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE "Notes" (
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,
          Notes TEXT NOT NULL 
        )
  ''');
  }

  // sqflite has 4 main methods

  // SELECT == readData
  // DELETE
  // UPDATE
  // INSERT

  readData({required String sql}) async {
    Database? mydb = await getdp();
    var response = await mydb!.rawQuery(sql);
    return response;
  }
}

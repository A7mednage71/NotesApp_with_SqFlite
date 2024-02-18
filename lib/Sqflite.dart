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
    Database Mydatabase = await openDatabase(path,
        onCreate: _oncreate, version: 1, onUpgrade: _onUpgrade);
    return Mydatabase;
  }

  // create tables
  FutureOr<void> _oncreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE "Notes" (
          'id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          'Title' TEXT NOT NULL,
          'Note' TEXT NOT NULL ,
          'color' TEXT NOT NULL

        )
  ''');
    print('++++++++++++++ _oncreate ++++++++++++++++');
  }

  // sqflite has 4 main methods

  // SELECT == readData
  // DELETE
  // UPDATE
  // INSERT

  readData({required String sql}) async {
    Database? mydb = await getdp();
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  updateData({required String sql}) async {
    Database? mydb = await getdp();
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  insertData({required String sql}) async {
    Database? mydb = await getdp();
    var response = await mydb!.rawInsert(sql);
    return response;
  }

  deleteData({required String sql}) async {
    Database? mydb = await getdp();
    var response = await mydb!.rawDelete(sql);
    return response;
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('++++++++++++++ onUpgrade ++++++++++++++++');
  }

  DeleteDatabase() async {
    String databasepath = await getDatabasesPath(); // get the databasepath
    String path = join(databasepath, 'Notesdp.dp');
    await deleteDatabase(path);
  }
}

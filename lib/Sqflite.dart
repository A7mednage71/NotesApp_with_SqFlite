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

  // if i want to create a new table and want to create more than one you can use batching
  FutureOr<void> _oncreatebybatching(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
        CREATE TABLE "Students" (
          'id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          'Title' TEXT NOT NULL,
          'Note' TEXT NOT NULL ,
          'color' TEXT NOT NULL

        )
  ''');
    batch.execute('''
        CREATE TABLE "friends" (
          'id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          'Title' TEXT NOT NULL,
          'Note' TEXT NOT NULL ,
          'color' TEXT NOT NULL

        )
  ''');
    batch.commit();
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

  // sqflite has 4 main methods without sql orders

  // SELECT == readData
  // DELETE
  // UPDATE
  // INSERT

  read({required String table}) async {
    Database? mydb = await getdp();
    List<Map> response = await mydb!.query(table);
    return response;
  }

  update(
      {required String table,
      required Map<String, Object?> values,
      required String where}) async {
    Database? mydb = await getdp();
    int response = await mydb!.update(table, values, where: where);
    return response;
  }

  insert({required String table, required Map<String, Object?> values}) async {
    Database? mydb = await getdp();
    int response = await mydb!.insert(table, values);
    return response;
  }

  delete({required String table, String? where}) async {
    Database? mydb = await getdp();
    int response = await mydb!.delete(table, where: where);
    return response;
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // await db.execute("ALTER TABLE Notes ADD COLUMN color TEXT");
    print('++++++++++++++ onUpgrade ++++++++++++++++');
    // YOU can add coulmn by changing the vesion with using onupgrade method.
    // or delete the database finally.
  }

  deletemyDatabase() async {
    String databasepath = await getDatabasesPath(); // get the databasepath
    String path = join(databasepath, 'Notesdp.dp');
    await deleteDatabase(path);
  }
}

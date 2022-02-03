import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'dbModel.dart';


class DatabaseHelper {

  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'tbl_order';

  static final proid = 'product_id';
  static final proName = 'product_name';
  static final proQuantity = 'quantity';
  static final proPrice ='price';
  static final discount = 'discount';
  static final tPrice = 'tPrice';
  static final pImg = 'pImg';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $proid INTEGER PRIMARY KEY,
            $proName TEXT NOT NULL,
            $proQuantity INTEGER NOT NULL,
            $proPrice INTEGER NOT NULL,
            $discount INTEGER NOT NULL,
            $tPrice INTEGER NOT NULL,
            $pImg TEXT NOT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row) ;
  }
//TODO
  newClient(Model model) async {
    final db = await database;
    //var proidcheck = await db.rawQuery(" SELECT $proid FROM $table WHERE  ");
    var res = await db.rawInsert(
        "INSERT Into $table ($proid,$proName,$proQuantity,$proPrice,$discount,$tPrice,$pImg)"
            " VALUES (${model.pid},${model.pName},${model.pQuantity},"
            "${model.pPrice},${model.discount},${model.tPrice},${model.pImg})" );
    return res;
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> checkProduct(String checkid) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT $proid FROM $table WHERE $proid= $checkid'));
  }

  Future<int> updateCartList(Map<String, dynamic> row, int proID, ) async {
    Database db = await instance.database;
   // int id = int.parse(row[proid]);

    return await db.update(table, row, where: '$proid = ?', whereArgs: [proID]);
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[proid];
    return await db.update(table, row, where: '$proid = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {    //change string to int
    Database db = await instance.database;
    return await db.delete(table, where: '$proid = ?', whereArgs: [id]);
  }

  Future deleteall() async {    //change string to int
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('DELETE FROM $table'));
  }

  Future<int> subtotal() async{
    Database db = await instance.database;
return Sqflite.firstIntValue(await db.rawQuery('SELECT  SUM($tPrice) FROM $table'));
  }
  Future<int> dataID(int inndex) async{
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT  SUM($tPrice) FROM $table'));
  }

  //TODO
  // Future<int> resCount() async{
  //   Database db = await instance.database;
  //   return Sqflite.firstIntValue(await db.rawQuery('select count(*) from (SELECT COUNT($resid) as res  FROM $table GROUP by $resid) as x'));
  //
  // }

  Future<int> rowCount() async{
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('select count(*) from $table'));

  }
 // select count(*) from (SELECT COUNT(restaurant_id) as res  FROM `all_products` GROUP by restaurant_id) as x

}
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:task/Model/item_model.dart';

class DBHelper {
  static Database? _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'Items.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE Items (id INTEGER PRIMARY KEY, name TEXT, imageUrl TEXT, price TEXT)');
  }

  Future<Items> add(Items items) async {
    var dbClient = await db;
    items.id = await dbClient.insert('Items', items.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return items;
  }

  Future<List<Items>> getItemss() async {
    var dbClient = await db;
    List<Map> maps = await dbClient
        .query('Items', columns: ['id', 'name', 'imageUrl', 'price']);
    // ignore: non_constant_identifier_names
    List<Items> Itemss = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        Itemss.add(Items.fromMap(maps[i]));
      }
    }
    return Itemss;
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}

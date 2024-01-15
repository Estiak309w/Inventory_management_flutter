import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'inventory_app');
    var database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    String product_mst =
        "CREATE TABLE product_mst (id INTEGER PRIMARY KEY,product_name_mst TEXT, product_number_mst INTEGER);";
    String product =
        "CREATE TABLE product (id INTEGER PRIMARY KEY AUTOINCREMENT, product_name TEXT, item_num INTEGER, quantity INTEGER, ptype TEXT );";
    await database.execute(product_mst);
    await database.execute(product);
    await database.execute('''
       INSERT INTO product_mst (id, product_name_mst, product_number_mst) VALUES 
       (2, 'コンピュータ', 199),
       (1, 'tab', 12),
       (3, 'スマートフォン', 200),
        (4, 'テレビ', 566),
        (5, '冷蔵庫', 309);
       ''');
  }
}

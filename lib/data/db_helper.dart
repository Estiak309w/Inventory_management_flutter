import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'inventory');
    var database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    // String sql =
    //     "CREATE TABLE product_mst (id INTEGER PRIMARY KEY,product_name_mst TEXT, product_number_mst INTEGER);";
    String sql =
        "CREATE TABLE product (id INTEGER PRIMARY KEY,product_name_mst TEXT, product_number_mst INTEGER);";
    await database.execute(sql);
  }
}

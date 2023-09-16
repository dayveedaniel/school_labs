import 'package:school_labs/labs/models/product_model.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      '$path/products.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE products(id INTEGER PRIMARY KEY, kind TEXT NOT NULL, title TEXT NOT NULL, price REAL NOT NULL, weight REAL NOT NULL, filePath TEXT NOT NULL)",
        );
      },
    );
  }

  Future<int> insertData(List<ProductModel> products) async {
    int insertedId = 0;
    final Database db = await initDB();
    for (var product in products) {
      insertedId = await db.insert(
        'products',
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    return insertedId;
  }

  Future<List<ProductModel>> retrieveAllData() async {
    final Database db = await initDB();
    final List<Map<String, dynamic>> queryResult = await db.query('products');
    return queryResult.map((e) => ProductModel.fromMap(e)).toList();
  }

  Future<void> updateCertainData(ProductModel newProduct) async {
    final db = await initDB();
    await db.update(
      'products',
      newProduct.toMap(),
      where: 'id = ?',
      whereArgs: [newProduct.id],
    );
  }

  Future<void> deleteCertainData(int id) async {
    final db = await initDB();
    await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllData() async {
    final db = await initDB();
    await db.delete('products');
  }
}

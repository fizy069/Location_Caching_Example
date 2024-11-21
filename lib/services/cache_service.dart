import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/location.dart';

class LocationCache {
  static const String tableName = 'locations';

  Future<Database> _getDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'locations.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $tableName(address TEXT PRIMARY KEY, latitude REAL, longitude REAL)',
        );
      },
      version: 1,
    );
  }

  Future<void> saveLocation(Location location) async {
    final db = await _getDatabase();
    await db.insert(
      tableName,
      location.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<Location?> getLocation(String address) async {
    final db = await _getDatabase();
    final results = await db.query(
      tableName,
      where: 'address = ?',
      whereArgs: [address],
    );

    if (results.isNotEmpty) {
      return Location.fromMap(results.first);
    }
    return null;
  }
}

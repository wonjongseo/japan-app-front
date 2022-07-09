import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class Progressing {
  int? level;
  int? range;
  Progressing({this.level, this.range});
  Map<String, dynamic> toMap() {
    return {
      'level': level,
      'range': range,
    };
  }
}

class CustomDatabase {
  Future<Database> initDatabase() async {
    Database database =
        await openDatabase(join(await getDatabasesPath(), 'progressing.db'),
            onCreate: (db, version) {
      return db
          .execute("create table progressing(level integer, range integer)");
    }, version: 1);

    return database;
  }

  Future<List<Progressing>> getProgressing(Future<Database> db) async {
    final Database database = await db;
    final List<Map<String, dynamic>> maps = await database.query('progressing');

    return List.generate(
        maps.length,
        (index) => Progressing(
            level: maps[index]['level'], range: maps[index]['range']));
  }
}

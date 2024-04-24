import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ets_ppb/model/film.dart';
import 'dart:async';

class FilmDatabase{
  static final FilmDatabase instance = FilmDatabase._init();

  static Database? _database;

  FilmDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate:  _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute(
'''
CREATE TABLE $tableName (
  ${FilmFields.id} $idType,
  ${FilmFields.title} $textType,
  ${FilmFields.added} $textType,
  ${FilmFields.cover} $textType,
  ${FilmFields.description} $textType
)
'''
    );
  }

  Future<Film> create(Film film) async {
    final db = await instance.database;
    final id = await db.insert(tableName, film.toJson());

    return film.copy(id: id);
  }

  Future<Film> read(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableName,
      columns: FilmFields.values,
      where: '${FilmFields.id} = ?',
      whereArgs: [id]
    );

    if(maps.isNotEmpty){
      return Film.fromJson(maps.first);
    }
    else{
      throw Exception('Film with ID $id cannot be found');
    }
  }

  Future<List<Film>> readAll() async {
    final db = await instance.database;
    const orderBY = '${FilmFields.added} ASC';
    final result = await db.query(tableName, orderBy: orderBY);

    return result.map((json) => Film.fromJson(json)).toList();
  }

  Future<int> update(Film film) async {
    final db = await instance.database;
    return db.update(
      tableName,
      film.toJson(),
      where: '${FilmFields.id} = ?',
      whereArgs: [film.id]
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableName,
      where: '${FilmFields.id} = ?',
      whereArgs: [id]
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
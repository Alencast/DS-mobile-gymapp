import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/treino.dart';


class TreinoDatabase {

  static final TreinoDatabase instance = TreinoDatabase._init();

  static Database? _database;


  TreinoDatabase._init();


  Future<Database> get database async {

    if (_database != null) return _database!;

    _database = await _initDB('treinos.db');

    return _database!;
  }


  Future<Database> _initDB(String fileName) async {

    final dbPath = await getDatabasesPath();

    final path = join(dbPath, fileName);


    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }


  Future<void> _createDB(
    Database db,
    int version,
  ) async {

    await db.execute('''
      CREATE TABLE treinos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        descricao TEXT,
        duracao TEXT,
        nivel TEXT
      )
    ''');
  }


  // CREATE
  Future<int> inserirTreino(Treino treino) async {

    final db = await instance.database;

    return await db.insert(
      'treinos',
      treino.toMap(),
    );
  }


  // READ
  Future<List<Treino>> listarTreinos() async {

    final db = await instance.database;

    final resultado = await db.query(
      'treinos',
      orderBy: 'id DESC',
    );


    return resultado
        .map(
          (json) => Treino.fromMap(json),
        )
        .toList();
  }


  // UPDATE
  Future<int> atualizarTreino(Treino treino) async {

    final db = await instance.database;

    return await db.update(
      'treinos',
      treino.toMap(),
      where: 'id = ?',
      whereArgs: [treino.id],
    );
  }


  // DELETE
  Future<int> removerTreino(int id) async {

    final db = await instance.database;

    return await db.delete(
      'treinos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }


  // BUSCA
  Future<List<Treino>> buscarTreinos(
    String texto,
  ) async {

    final db = await instance.database;


    final resultado = await db.query(
      'treinos',
      where: 'titulo LIKE ?',
      whereArgs: ['%$texto%'],
    );


    return resultado
        .map(
          (json) => Treino.fromMap(json),
        )
        .toList();
  }
}
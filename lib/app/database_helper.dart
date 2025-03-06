import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  DatabaseHelper._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('todo.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      inCompleted INTEGER NOT NULL DEFAULT 0,
    )
    ''');
  }

  Future<int> insertTask(Map<String, dynamic> task) async {
    final db = await instance.database;
    return db.insert('tasks', task);
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await instance.database;
    return await db.query('tasks');
  }

  Future<int> updateTask(int id, int isCompleted) async {
    final db = await instance.database;
    return await db.update(
      'tasks',
      {'isCompleted': isCompleted},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await instance.database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}

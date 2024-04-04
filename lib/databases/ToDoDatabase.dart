import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class ToDoDatabase {
  final Future<Database> _database;

  ToDoDatabase() : _database = _initDatabase();

  static Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final dbPath = path.join(databasePath, 'todo_database.db');

    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE todolist(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, completed)',
        );
      },
    );
  }

  Future<int> insertTask(String title) async {
    final Database db = await _database;
    final Map<String, dynamic> task = {'title': title, 'completed': 0};
      return await db.insert('todolist', task);
  }

 Future<List<Map<String, dynamic>>> getAllTasks() async {
    final Database db = await _database;
    return await db.query('todolist');
  }

  Future<int> updateTask(Map<String, dynamic> task) async {
    final Database db = await _database;
    return await db.update(
      'todolist',
      task,
      where: 'id = ?',
      whereArgs: [task['id']],
    );
  }

  Future<int> deleteTask(int id) async {
    final Database db = await _database;
    return await db.delete(
      'todolist',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class ContatosDatabase {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }
  
  static Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final dbPath = path.join(databasePath, 'contatos_database.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE contatos(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, telefone TEXT)',
        );
      },
    );
  }

  static Future<int> saveContact(String name, String phone) async {
    final db = await database;
    Map<String, dynamic> dadosContato = {
      'nome': name,
      'telefone': phone,
    };

    int idContato = await db.insert('contatos', dadosContato);
    return idContato;
  }

  static Future<List<Map<String, dynamic>>> getAllContacts() async {
    final db = await database;
    return db.query('contatos');
  }

  
}

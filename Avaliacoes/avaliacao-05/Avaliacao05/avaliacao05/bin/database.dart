import 'package:sqlite3/sqlite3.dart';

class DatabaseHelper {
  final Database _db;

  DatabaseHelper(String path) : _db = sqlite3.open(path);

  void createTable() {
    _db.execute('''
      CREATE TABLE IF NOT EXISTS TB_ALUNO (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL
      )
    ''');
  }

  void insertAluno(String nome) {
    _db.execute('''
      INSERT INTO TB_ALUNO (nome) VALUES (?)
    ''', [nome]);
  }

  List<Map<String, dynamic>> getAllAlunos() {
    final rows = _db.select('SELECT * FROM TB_ALUNO');
    return rows.map((row) {
      return {
        'id': row['id'],
        'nome': row['nome'],
      };
    }).toList();
  }

  void close() {
    _db.dispose();
  }
}

import 'dart:io';
import 'database.dart';

void main() {
  final dbPath = 'alunos.db';
  final dbHelper = DatabaseHelper(dbPath);

  dbHelper.createTable();

  while (true) {
    print('Escolha uma opção:');
    print('1. Adicionar aluno');
    print('2. Listar alunos');
    print('3. Sair');
    final choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        print('Digite o nome do aluno:');
        final nome = stdin.readLineSync();
        if (nome != null && nome.isNotEmpty) {
          dbHelper.insertAluno(nome);
          print('Aluno adicionado com sucesso!');
        } else {
          print('Nome inválido.');
        }
        break;

      case '2':
        final alunos = dbHelper.getAllAlunos();
        if (alunos.isEmpty) {
          print('Nenhum aluno encontrado.');
        } else {
          print('Lista de alunos:');
          for (var aluno in alunos) {
            print('ID: ${aluno['id']}, Nome: ${aluno['nome']}');
          }
        }
        break;

      case '3':
        dbHelper.close();
        print('Saindo...');
        return;

      default:
        print('Opção inválida.');
    }
  }
}

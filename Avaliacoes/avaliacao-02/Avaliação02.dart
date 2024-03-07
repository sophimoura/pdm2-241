import 'dart:convert';

class Dependente {
  late String _nome;

  Dependente(this._nome);

  Map<String, dynamic> toJson() => {
    'nome': _nome,
  };
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(this._nome, this._dependentes);

  Map<String, dynamic> toJson() => {
    'nome': _nome,
    'dependentes': _dependentes.map((dependente) => dependente.toJson()).toList(),
  };
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(this._nomeProjeto, this._funcionarios);

  Map<String, dynamic> toJson() => {
    'nomeProjeto': _nomeProjeto,
    'funcionarios': _funcionarios.map((funcionario) => funcionario.toJson()).toList(),
  };
}

void main() {
  // 1. Criar vários objetos Dependentes
  Dependente marido = Dependente("Ailton");
  Dependente filho = Dependente("Gustavo");
  Dependente vo = Dependente("Ilda");
  Dependente vovo = Dependente("Zézin");

  // 2. Criar vários objetos Funcionario
  Funcionario funcionario1 = Funcionario("Zezão", [filho]);
  Funcionario funcionario2 = Funcionario("Lidiane", [marido]);
  Funcionario funcionario3 = Funcionario("Zezão", [vo]);
  Funcionario funcionario4 = Funcionario("Jubileu", [vovo]);

  // 4. Criar uma lista de Funcionarios
  List<Funcionario> funcionarios = [
    funcionario1,
    funcionario2,
    funcionario3,
    funcionario4
  ];

  // 5. Criar um objeto Equipe Projeto chamando o método construtor
  EquipeProjeto equipeProjeto = EquipeProjeto('Projeto Aula Taveira', funcionarios);

  // 6. Printar no formato JSON o objeto Equipe Projeto.
  String equipeProjetoJson = jsonEncode(equipeProjeto.toJson());
  print(equipeProjetoJson);
}

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulário de Validação',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  // Validação de Data
  String? validateDate(String? value) {
    final dateFormat = DateFormat('dd-MM-yyyy');
    try {
      dateFormat.parseStrict(value!);
      return null;
    } catch (e) {
      return 'Data inválida';
    }
  }

  // Validação de Email
  String? validateEmail(String? value) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(value!) ? null : 'Email inválido';
  }

  // Validação de CPF
  String? validateCPF(String? value) {
    final cpf = value!.replaceAll(RegExp(r'\D'), '');
    if (cpf.length != 11) return 'CPF deve ter 11 dígitos';
    
    // Adicionar validação real de CPF aqui (geralmente envolve cálculos)
    return null;
  }

  // Validação de Valor
  String? validateValue(String? value) {
    final valueRegex = RegExp(r'^\d+(\.\d{1,2})?$');
    return valueRegex.hasMatch(value!) ? null : 'Valor inválido';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Validação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: ListView(
            children: [
              Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormBuilderTextField(
                        name: 'data',
                        decoration: InputDecoration(
                          labelText: 'Data (dd-mm-aaaa)',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        validator: validateDate,
                      ),
                      SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'email',
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: validateEmail,
                      ),
                      SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'cpf',
                        decoration: InputDecoration(
                          labelText: 'CPF',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: validateCPF,
                      ),
                      SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'valor',
                        decoration: InputDecoration(
                          labelText: 'Valor',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.money),
                        ),
                        validator: validateValue,
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.saveAndValidate()) {
                              // Exibir mensagem de sucesso
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Formulário enviado com sucesso!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } else {
                              // Exibir mensagem de erro
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Por favor, corrija os erros no formulário.'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          child: Text('Enviar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

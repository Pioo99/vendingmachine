import 'package:firebase_database/firebase_database.dart';

class Chocolate {
  late String id;
  late String nome;
  late String quantidade;
  late String valor;

  Chocolate({required this.id, required this.nome, required this.quantidade, required this.valor});

  factory Chocolate.fromSnapshot(DataSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.value as Map<String, dynamic>?;
    return Chocolate(
      id: data?['id'] ?? '',
      nome: data?['nome'] ?? '',
      quantidade: data?['quantidade'] ?? '',
      valor: data?['valor'] ?? '',
    );
  }
}

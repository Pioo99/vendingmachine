import 'package:firebase_database/firebase_database.dart';

class Cliente {
  late String id;
  late String email;
  late int saldo;

  Cliente({required this.id, required this.email, required this.saldo});

  factory Cliente.fromSnapshot(DataSnapshot snapshot) {
    Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;
    return Cliente(
      id: data?['id'] ?? '',
      email: data?['email'] ?? '',
      saldo: data?['saldo'] ?? 0
    );
  }
}

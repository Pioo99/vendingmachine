import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/clientes.dart';

class ClientPage extends StatefulWidget {
  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  late DatabaseReference _databaseRef;
  late List<Cliente> _clientes;

  @override
  void initState() {
    super.initState();
    _databaseRef = FirebaseDatabase.instance.ref().child('usuarios');
    _clientes = [];
    _startListeners();
  }

  void _startListeners() {
    _databaseRef.onChildAdded.listen((event) {
      setState(() {
        _clientes.add(Cliente.fromSnapshot(event.snapshot));
      });
    });

    _databaseRef.onChildChanged.listen((event) {
      var updatedCliente = Cliente.fromSnapshot(event.snapshot);
      var index = _clientes.indexWhere((cliente) => cliente.id == updatedCliente.id);
      setState(() {
        _clientes[index] = updatedCliente;
      });
    });
  }

  Future<void> _updateSaldo(Cliente cliente, int newSaldo) async {
    await _databaseRef.child(cliente.id).update({'saldo': newSaldo});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Clientes'),
      ),
      body: ListView.builder(
        itemCount: _clientes.length,
        itemBuilder: (context, index) {
          var cliente = _clientes[index];
          TextEditingController saldoController = TextEditingController(text: cliente.saldo.toString());

          return ListTile(
            title: Text(cliente.email),
            subtitle: TextField(
              controller: saldoController,
              onChanged: (newSaldo) {
                cliente.saldo = int.parse(newSaldo);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Saldo'),
            ),
            trailing: IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _updateSaldo(cliente, cliente.saldo);
              },
            ),
          );
        },
      ),
    );
  }
}

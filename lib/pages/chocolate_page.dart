import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vendingmachine/models/chocolate.dart';

class ChocolatePage extends StatefulWidget {
  @override
  _ChocolatePageState createState() => _ChocolatePageState();
}

class _ChocolatePageState extends State<ChocolatePage> {
  late DatabaseReference _databaseRef;
  late List<Chocolate> _objects;

  @override
  void initState() {
    super.initState();
    _databaseRef = FirebaseDatabase.instance.ref().child('chocolates');
    _objects = [];
    _startListeners();
  }

  void _startListeners() {
    _databaseRef.onChildAdded.listen((event) {
      setState(() {
        _objects.add(Chocolate.fromSnapshot(event.snapshot));
      });
    });

    _databaseRef.onChildChanged.listen((event) {
      var updatedObject = Chocolate.fromSnapshot(event.snapshot);
      var index = _objects.indexWhere((obj) => obj.id == updatedObject.id);
      setState(() {
        _objects[index] = updatedObject;
      });
    });
  }

  Future<void> _updateValue(Chocolate obj, String newValue) async {
    await _databaseRef.child(obj.id).update({'valor': newValue});
  }

  Future<void> _updateQuantity(Chocolate obj, String newQuantity) async {
    await _databaseRef.child(obj.id).update({'quantidade': newQuantity});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de chocolates'),
      ),
      body: ListView.builder(
        itemCount: _objects.length,
        itemBuilder: (context, index) {
          var obj = _objects[index];
          TextEditingController valorController = TextEditingController(text: obj.valor);
          TextEditingController quantidadeController = TextEditingController(text: obj.quantidade);

          return ListTile(
            title: Text(obj.nome),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: valorController,
                  onChanged: (newValue) {
                    obj.valor = newValue;
                  },
                  decoration: InputDecoration(labelText: 'Valor'),
                ),
                TextField(
                  controller: quantidadeController,
                  onChanged: (newQuantity) {
                    obj.quantidade = newQuantity;
                  },
                  decoration: InputDecoration(labelText: 'Quantidade'),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _updateValue(obj, obj.valor);
                _updateQuantity(obj, obj.quantidade);
              },
            ),
          );
        },
      ),
    );
  }
}
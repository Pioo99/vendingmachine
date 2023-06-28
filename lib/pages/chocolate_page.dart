import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ChocolatePage extends StatefulWidget {

  const ChocolatePage({super.key});

  @override
  _ChocolatePageState createState() => _ChocolatePageState();
}

class _ChocolatePageState extends State<ChocolatePage> {
  late String? user;
  late DatabaseReference dbRefPedido;

  TextEditingController aquantidadeController = TextEditingController();
  TextEditingController bquantidadeController = TextEditingController();
  TextEditingController cquantidadeController = TextEditingController();
  TextEditingController avalorController = TextEditingController();
  TextEditingController bvalorController = TextEditingController();
  TextEditingController cvalorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbRefPedido = FirebaseDatabase.instance.ref().child('pedido');

    // Carregar os valores atuais do pedido
    dbRefPedido.once().then((DatabaseEvent event) {
      var dataSnapshot = event.snapshot;
      if (dataSnapshot.value != null) {
        Map<dynamic, dynamic>? pedido = dataSnapshot.value as Map<dynamic, dynamic>;
        setState(() {
          aquantidadeController.text = pedido['aquantidade']?.toString() ?? '';
          bquantidadeController.text = pedido['bquantidade']?.toString() ?? '';
          cquantidadeController.text = pedido['cquantidade']?.toString() ?? '';
          avalorController.text = pedido['avalor']?.toString() ?? '';
          bvalorController.text = pedido['bvalor']?.toString() ?? '';
          cvalorController.text = pedido['cvalor']?.toString() ?? '';
        });
      }
    });
  }

  void atualizarPedido() {
    int aquantidade = int.tryParse(aquantidadeController.text) ?? 0;
    int bquantidade = int.tryParse(bquantidadeController.text) ?? 0;
    int cquantidade = int.tryParse(cquantidadeController.text) ?? 0;
    int avalor = int.tryParse(avalorController.text) ?? 0;
    int bvalor = int.tryParse(bvalorController.text) ?? 0;
    int cvalor = int.tryParse(cvalorController.text) ?? 0;

    Map<String, dynamic> novoPedido = {
      'aquantidade': aquantidade,
      'bquantidade': bquantidade,
      'cquantidade': cquantidade,
      'avalor': avalor,
      'bvalor': bvalor,
      'cvalor': cvalor,
    };

    dbRefPedido.set(novoPedido).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Chocolate atualizado com sucesso')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar o chocolate: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chocolates'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chocolates',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text('Chocolate 1'),
            TextFormField(
              controller: aquantidadeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantidade'),
            ),
            TextFormField(
              controller: avalorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Valor'),
            ),
            SizedBox(height: 16.0),
            Text('Chocolate 2'),
            TextFormField(
              controller: bquantidadeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantidade'),
            ),
            TextFormField(
              controller: bvalorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Valor'),
            ),
            SizedBox(height: 16.0),
            Text('Chocolate 3'),
            TextFormField(
              controller: cquantidadeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantidade'),
            ),
            TextFormField(
              controller: cvalorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Valor'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Atualizar Chocolates'),
              onPressed: atualizarPedido,
            ),
          ],
        ),
      ),
    );
  }
}
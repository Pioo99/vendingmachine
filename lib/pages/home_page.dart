import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:vendingmachine/pages/admin_page.dart';

class HomePage extends StatefulWidget {
  final String? userName;

  HomePage({required this.userName});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int valorWidget1 = 0;
  int valorWidget2 = 0;
  int valorWidget3 = 0;
  late String? user;

  late DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('pedido');
  late DatabaseReference dbRefClient = FirebaseDatabase.instance.ref().child('usuarios');
  late DatabaseReference dbRefChocolate = FirebaseDatabase.instance.ref().child('chocolates');

  @override
  void initState() {
    super.initState();
    user = widget.userName;
  }

  void enviarPedido(valorWidget1, valorWidget2, valorWidget3) async {
    FirebaseDatabase.instance.ref().child('pedido').child('chocolate1').set(valorWidget1);
    FirebaseDatabase.instance.ref().child('pedido').child('chocolate2').set(valorWidget2);
    FirebaseDatabase.instance.ref().child('pedido').child('chocolate3').set(valorWidget3);
  }

  void atualizarValor(int widgetId, int novoValor) {
    setState(() {
      if (widgetId == 1) {
        valorWidget1 = novoValor;
      } else if (widgetId == 2) {
        valorWidget2 = novoValor;
      } else if (widgetId == 3) {
        valorWidget3 = novoValor;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isAdmin = user == "lucas_pio99@hotmail.com";

    return Scaffold(
      appBar: AppBar(
        title: Text('Página Inicial'),
      ),
      body: Stack(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget(
                  widgetId: 1,
                  valor: valorWidget1,
                  atualizarValor: atualizarValor,
                ),
                SizedBox(width: 16),
                ButtonWidget(
                  widgetId: 2,
                  valor: valorWidget2,
                  atualizarValor: atualizarValor,
                ),
                SizedBox(width: 16),
                ButtonWidget(
                  widgetId: 3,
                  valor: valorWidget3,
                  atualizarValor: atualizarValor,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 120.0,
                height: 40.0,
                child: ElevatedButton(
                  onPressed: () {
                    enviarPedido(valorWidget1, valorWidget2, valorWidget3);
                  },
                  child: Text('Compre'),
                ),
              ),
            ),
          ),
          if (isAdmin)
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminPage()),
                  );
                },
                child: Icon(Icons.lock),
              ),
            ),
        ],
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final int widgetId;
  final int valor;
  final Function(int, int) atualizarValor;

  ButtonWidget({
    required this.widgetId,
    required this.valor,
    required this.atualizarValor,
  });

  void _incrementarValor() {
    atualizarValor(widgetId, valor + 1);
  }

  void _decrementarValor() {
    atualizarValor(widgetId, valor - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Chocolate $widgetId',
          style: TextStyle(fontSize: 24),
        ),
        Text(
          'Valor: $valor',
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _incrementarValor,
              child: Icon(Icons.add),
            ),
            SizedBox(width: 16),
            ElevatedButton(
              onPressed: _decrementarValor,
              child: Icon(Icons.remove),
            ),
          ],
        ),
      ],
    );
  }
}

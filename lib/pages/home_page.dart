import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:vendingmachine/pages/admin_page.dart';

class HomePage extends StatefulWidget {
  final String? userName;

  const HomePage({required this.userName});

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

  Map<dynamic, dynamic> values = {};
  int saldo = 0;

  @override
  void initState() {
    super.initState();
    user = widget.userName;

    dbRef.once().then((DatabaseEvent event){
      final dataSnapshot = event.snapshot;
      Map<dynamic, dynamic>? data = dataSnapshot.value as Map<dynamic, dynamic>;
      setState(() {
        values = data;
      });
    });

    
    dbRefClient.once().then((DatabaseEvent event){
      final dataSnapshot = event.snapshot;
      Map<dynamic, dynamic>? data = dataSnapshot.value as Map<dynamic, dynamic>;
      data.forEach((key, value) { 
        if(value['email'] == user){
          setState(() {
            saldo = value['saldo'] ?? 0;
          });
        }
      });
    });

    dbRef.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        setState(() {
          values = event.snapshot.value as Map<dynamic, dynamic>;
        });
      }
    });

    dbRefClient.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          if (value['email'] == user) {
            setState(() {
              saldo = value['saldo'] ?? 0;
            });
          }
        });
      }
    });

  }

  void enviarPedido(valorWidget1, valorWidget2, valorWidget3) async {

    int totalValue = calcularValorTotal();
    if(values['retirado'] == 0)
    {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erro"),
            content: Text("Ainda há um pedido sendo processado aguarde."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }
    else if(valorWidget1 == 0 && valorWidget2 == 0 && valorWidget3 == 0)
    {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erro"),
            content: Text("Nenhum chocolate selecionado."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }
    else if(valorWidget1 > values['aquantidade'] || valorWidget2 > values['bquantidade'] || valorWidget3 > values['cquantidade'])
    {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Erro"),
              content: const Text("Quantidade escolhida acima do estoque"),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      return;
      return;
    }
    else if (totalValue > saldo) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Erro"),
            content: const Text("Saldo insuficiente."),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }
    else if (values['retirado'] == 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Erro"),
            content: const Text("Já há um pedido sendo processado"),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    FirebaseDatabase.instance.ref().child('pedido').child('chocolate1').set(valorWidget1);
    FirebaseDatabase.instance.ref().child('pedido').child('chocolate2').set(valorWidget2);
    FirebaseDatabase.instance.ref().child('pedido').child('chocolate3').set(valorWidget1);
    FirebaseDatabase.instance.ref().child('pedido').child('retirado').set(0);
    
    DatabaseReference orderRef = FirebaseDatabase.instance.ref().child('orders');
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception("Usuário não autenticado.");
    }

    DatabaseReference usuariosRef = FirebaseDatabase.instance.ref().child('usuarios');
    DatabaseEvent event = await usuariosRef.orderByChild("email").equalTo(user).once();

    Map<dynamic, dynamic> usuarios = event.snapshot.value as Map<dynamic, dynamic>;
    String usuarioId = usuarios.keys.first;

    int saldoAtual = usuarios[usuarioId]['saldo'];
    int novoSaldo = saldoAtual - totalValue;

    DatabaseReference newOrderRef = orderRef.push();
    newOrderRef.set({
      'userId': usuarioId,
      'chocolate_1': valorWidget1,
      'chocolate_2': valorWidget2,
      'chocolate_3': valorWidget3,
      'valor_total': totalValue
    });

    await usuariosRef.child(usuarioId).update({'saldo': novoSaldo});

    showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Sucesso"),
              content: Text("Pedido realizado"),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
  


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

  int calcularValorTotal() {
    int totalValue = 0;
    int? valor1 = (valorWidget1 * values['avalor']) as int?;
    int? valor2 = (valorWidget2 * values['bvalor']) as int?;
    int? valor3 = (valorWidget3 * values['cvalor']) as int?;
    totalValue = valor1! + valor2!+ valor3!;
    return totalValue;
  }

  @override
  Widget build(BuildContext context) {
    bool isAdmin = user == "lucas_pio99@hotmail.com";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Página Inicial'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            Text(
              'Saldo do usuário: $saldo',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ButtonWidget(
              widgetId: 1,
              valor: valorWidget1,
              estoque: values['aquantidade'],
              custo: values['avalor'],                
              atualizarValor: atualizarValor,
            ),
            SizedBox(height: 16),
            ButtonWidget(
              widgetId: 2,
              valor: valorWidget2,
              estoque: values['bquantidade'],
              custo: values['bvalor'],     
              atualizarValor: atualizarValor,
            ),
            SizedBox(height: 16),
            ButtonWidget(
              widgetId: 3,
              valor: valorWidget3,
              estoque: values['cquantidade'],
              custo: values['cvalor'],     
              atualizarValor: atualizarValor,
            ),
            SizedBox(height: 16),
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
                    child: Text('Valor total: ${calcularValorTotal()}'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminPage()),
                );
              },
              child: Icon(Icons.lock),
            )
          : null,
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final int widgetId;
  final int valor;
  final int estoque;
  final int custo;
  final Function(int, int) atualizarValor;

  const ButtonWidget({super.key, 
    required this.widgetId,
    required this.valor,
    required this.estoque,
    required this.custo,
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
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Chocolate $widgetId',
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          Text(
            'Estoque: $estoque',
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          Text(
            'Custo: $custo',
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          Text(
            'Quantidade desejada: $valor',
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
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
      ),
    );
  }
}

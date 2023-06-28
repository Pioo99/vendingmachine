import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late DatabaseReference _dbRef;
  List<Map<dynamic, dynamic>> _orders = [];

  @override
  void initState() {
    super.initState();
    _dbRef = FirebaseDatabase.instance.ref().child('orders');
    _loadOrders();
  }

  void _loadOrders() {
    _dbRef.once().then((DatabaseEvent event) {
      var snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
        List<Map<dynamic, dynamic>> orders = [];

        data.forEach((key, value) {
          Map<dynamic, dynamic> order = {
            'id': key,
            'userId': value['userId'],
            'chocolate1': value['chocolate_1'],
            'chocolate2': value['chocolate_2'],
            'chocolate3': value['chocolate_3'],
            'valorTotal': value['valor_total'],
          };
          orders.add(order);
        });

        setState(() {
          _orders = orders;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          Map<dynamic, dynamic> order = _orders[index];
          return ListTile(
            title: Text('Pedido ${order['id']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Usuario: ${order['userId']}'),
                Text('Chocolate 1: ${order['chocolate1']}'),
                Text('Chocolate 2: ${order['chocolate2']}'),
                Text('Chocolate 3: ${order['chocolate3']}'),
                Text('Valor Total: ${order['valorTotal']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
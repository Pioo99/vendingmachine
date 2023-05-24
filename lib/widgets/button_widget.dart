import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  int _valor = 0;

  void _incrementarValor() {
    setState(() {
      _valor++;
    });
  }

  void _decrementarValor() {
    setState(() {
      _valor--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Valor: $_valor',
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

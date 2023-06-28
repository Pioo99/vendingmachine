import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({super.key});

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
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _incrementarValor,
              child: const Icon(Icons.add),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: _decrementarValor,
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ],
    );
  }
}

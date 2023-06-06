import 'package:flutter/material.dart';
import 'package:vendingmachine/pages/chocolate_page.dart';

import 'clientes_page.dart';
import 'google_maps_page.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADMIN'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChocolatePage()),
                  );
                },
                child: Text('Chocolates'),
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClientPage()),
                  );
                },
                child: Text('Clientes'),
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapScreen()),
                  );
                },
                child: Text('Chocolates'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrimeiraPagina extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Primeira Página'),
      ),
      body: Center(
        child: Text('Conteúdo da primeira página'),
      ),
    );
  }
}

class SegundaPagina extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Segunda Página'),
      ),
      body: Center(
        child: Text('Conteúdo da segunda página'),
      ),
    );
  }
}
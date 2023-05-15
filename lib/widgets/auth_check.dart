import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendingmachine/services/auth_service.dart';

import '../main.dart';
import '../pages/login_page.dart';

class AuthCheck extends StatefulWidget {
  AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck>{
  @override
  Widget build(BuildContext context){
    AuthService auth = Provider.of<AuthService>(context);
    
    if(auth.isLoading)
      return loading();
    else if(auth.usuario == null) return LoginPage();
    else return MyHomePage(title: 'Vending Machine');
  }

  loading(){
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
        ),
    );
  }

}
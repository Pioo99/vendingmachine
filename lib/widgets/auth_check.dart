import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendingmachine/services/auth_service.dart';

import '../pages/home_page.dart';
import '../pages/login_page.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck>{
  @override
  Widget build(BuildContext context){
    AuthService auth = Provider.of<AuthService>(context);
    
    if(auth.isLoading) {
      return loading();
    } else if(auth.usuario == null) {
      return const LoginPage();
    } else {
      return HomePage(userName: auth.usuario?.email,);
    }
  }

  loading(){
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
        ),
    );
  }

}
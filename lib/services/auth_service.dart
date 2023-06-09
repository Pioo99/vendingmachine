import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception{
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('usuarios');
  User? usuario;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser(){
    usuario = _auth.currentUser;
    notifyListeners();
  }

  register(String email, String password) async{
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Map<String, dynamic> user = {
      "email": _auth.currentUser?.email ?? '',
      "id": _auth.currentUser?.email ?? '',
      'saldo': 0
    };

    dbRef.push().set(user);
    _getUser();
    } on FirebaseAuthException catch(e){
      if(e.code == 'weak-password'){
        throw AuthException('A senha é muito fraca');
      } else if(e.code == 'email-already-in-use'){
        throw AuthException('Este email já está cadastrado');
      }
    }
  }

  login(String email, String password) async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _getUser();
    } on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        throw AuthException('Email não encontrado. Cadastre-se');
      } else if(e.code == 'wrong-password'){
        throw AuthException('Senha incorreta. Tente novamente');
      }
    }
  }

  logout() async{
    await _auth.signOut();
    _getUser();
  }
}
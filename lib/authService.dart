import 'dart:math';

import 'package:countriesapp/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthService {

  // Login
  Future<bool> login(String email, String password) async {
    // Simulate a future for response after 2 second.
    return await new Future<bool>.delayed(
        new Duration(
            seconds: 2
        ), () => accessPermited(email, password)
            //() => new Random().nextBool()
    );
  }

  // Logout
  Future<void> logout(BuildContext context) async {
    // Simulate a future for response after 1 second.
    return await new Future<void>.value(
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()))
    );
  }
}

bool accessPermited(String email, String password){
  if(email == "marcos@teste.com" && password == "123456")
    return true;
  else
    return false;
}
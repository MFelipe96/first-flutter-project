
import 'package:countriesapp/bottomNavigationBar.dart';
import 'package:countriesapp/login.dart';
import 'package:flutter/material.dart';
import 'authService.dart';
import 'homePage.dart';

AuthService appAuth = new AuthService();
Widget _defaultHome = new LoginPage();

void main() async{
    runApp(MyApp());

    // Get result of the login function.
    bool _result = false;
    //await appAuth.login();
    if (_result) {
      _defaultHome = new BottomNavigationBarState();
    }
}

class MyApp extends StatelessWidget {



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Countries App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _defaultHome,
      routes: <String, WidgetBuilder>{
        // Set routes for using the Navigator.
        '/home': (BuildContext context) => new MyHomePage("Continentes"),
        '/login': (BuildContext context) => new LoginPage()
      },
    );
  }
}


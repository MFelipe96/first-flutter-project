
import 'package:countriesapp/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homePage.dart';

class NavigationWebState extends StatefulWidget{

  @override
  _NavigationWeb createState() => _NavigationWeb();


}

class _NavigationWeb extends State<NavigationWebState> {

  int _selectedIndex = 0;
  String _title = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this._title),),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Home'),
              selected: 0 == _selectedIndex,
              onTap: () {
               _onSelectItem(0);
              },
            ),
            ListTile(
              title: Text('Perfil'),
                selected: 1 == _selectedIndex,
                onTap: () {
                // Update the state of the app.
                // ...
                _onSelectItem(1);
              },
            ),
          ],
        ),
      ),
    body: _getDrawerItem(_selectedIndex),
    );
  }

  _getDrawerItem(int pos) {
    switch (pos) {
      case 0:
        return MyHomePage("Continentes");
      case 1:
        return ProfilePage();
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedIndex = index);
    setState(() {
      switch(index){
        case 0:
          _title = 'Home';
          break;
        case 1:
          _title = 'Perfil';
          break;
      }
    });
    Navigator.of(context).pop();
  }
}

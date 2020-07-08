
import 'package:countriesapp/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarState extends StatefulWidget{
  @override
  _BottomNavigationBar createState() => _BottomNavigationBar();

}

class _BottomNavigationBar extends State<BottomNavigationBarState>{

  int _currentIndex = 0;
  final List<Widget> _children = [
    MyHomePage('Continentes'),
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.green)
  ];
  void _onClickedItem(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _onClickedItem,
          currentIndex: _currentIndex,
           selectedItemColor: Colors.green,
           items:<BottomNavigationBarItem> [
            BottomNavigationBarItem(
              icon: Icon(Icons.place),
              title: Text("Lugares")
            ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text("Favoritos")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_pin),
              title: Text("Perfil")
          ),
        ],
      ),
    );
    throw UnimplementedError();
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}


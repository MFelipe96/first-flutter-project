import 'package:countriesapp/bottomNavigationBar.dart';
import 'package:countriesapp/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'details.dart';

class MyHomePage extends StatefulWidget {
  String title;

  MyHomePage(String title){
    this.title = title;
  }

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: _buildList(),
              ),
            ],
          )
      ),
    );
  }
}
final List<String> images = <String>['images/africa.png', 'images/europe.jpg', 'images/asia.jpg', 'images/americas.jpg', 'images/oceania.jpg'];
final List<String> names = <String>['África', 'Europa', 'Ásia', 'América', 'Oceania'];

Widget _buildList() => ListView.separated(
  padding: EdgeInsets.all(8.0),
  itemCount: images.length,
  itemBuilder: (BuildContext context, int index){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyContinentInformationsPage(index)));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Card(
            elevation: 5,
            child: Expanded(
              child: Container(
                height: 220,
                width: 320,
                child: Center(
                  child: Text('${names[index]}', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter:
                    ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                    image: new AssetImage('${images[index]}'),
                  ),
                ),
              ),
            ),
          ),
        ],
        /*child: Row(
              children: [
                Expanded(
                child: Image.asset(
                    '${images[index]}',
                ),
                ),
              ],
          ),*/
      ),
    );
  },
  separatorBuilder: (BuildContext context, int index) => const Divider(),
);
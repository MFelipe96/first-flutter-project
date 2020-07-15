import 'package:countriesapp/bottomNavigationBar.dart';
import 'package:countriesapp/login.dart';
import 'package:countriesapp/screenTypeLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'details.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
    return MyScreenTypeLayout(
      mobile: Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildList(),
      ),
      desktop: _buildList(),
    );
  }
}

final List<String> images = <String>['images/africa.png', 'images/europe.jpg', 'images/asia.jpg', 'images/americas.jpg', 'images/oceania.jpg'];
final List<String> names = <String>['África', 'Europa', 'Ásia', 'América', 'Oceania'];

Widget _buildList() => Center(
  child:Column(
    children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(8.0),
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index){
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyContinentInformationsPage(index)));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Card(
                    elevation: 5,
                    child: Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Center(
                            child: Text('${names[index]}', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
                          ),
                          decoration: BoxDecoration(
                            image: new DecorationImage(
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                              image: new AssetImage('${images[index]}'),
                            ),
                          ),
                        ),
                      ),
                  ),
                ],
              ),
            );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
          ),
    ],
  ),
);
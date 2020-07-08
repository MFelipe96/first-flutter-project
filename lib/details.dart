import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'homePage.dart';
import 'main.dart';

class Country {
  final String name;

  Country({this.name});
  factory Country.fromJson(Map<String, dynamic> json) {

    return Country(
      name: json['name'],
    );
  }
}

Future<List<Country>> fetchCountry(String continent) async {
  List<Country> countriesList;
  final response = await http.get('https://restcountries.eu/rest/v2/region/$continent');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    countriesList=(json.decode(response.body) as List).map((i) => Country.fromJson(i)).toList();
    return countriesList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load country');
  }
}

class MyContinentInformationsPage extends StatefulWidget{
  int index;
  MyContinentInformationsPage(int index){
    this.index = index;
  }

  @override
  _ContinentInformation createState() => _ContinentInformation(index);

}

Widget _buildContinentInformation(int index){

  return Column(
    children:[
        Card(
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(8.0), topEnd: Radius.circular(8.0))),
        child: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child:Text("África", style: TextStyle(color: Colors.lightGreen, fontSize: 30, fontWeight: FontWeight.bold))
                    ),
                  ],
                ),
                Text("Nome: "),
                Text("Idiomas: ")
              ],
          ),
        ),
      ),
      Container(
        color: Colors.blueGrey,
        child: Column(
          mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisAlignment: MainAxisAlignment.end,
          children:[
             Text("Informações")
          ],
        ),
      ),
    ],
  );
}

class _ContinentInformation extends State<MyContinentInformationsPage>{

  Future<List<Country>> futureCountry;
  int index;
  String country;
  _ContinentInformation(int index){
    this.index = index;
  }

  @override
  void initState() {
    super.initState();
    switch(names[index]){
      case "América":
          country = "americas";
          break;
      case "Europa":
        country = "europe";
        break;
      case "África":
        country = "africa";
        break;
      case "Ásia":
        country = "asia";
        break;
      case "Oceania":
        country = "oceania";
        break;
    }
    futureCountry = fetchCountry(country);
  }

  @override
  Widget build(BuildContext context) {
    List<String> countries = new List();
    return Scaffold(
      appBar: AppBar(
          title: Text("Países")
      ),
      body: Center(
        child: FutureBuilder<List<Country>>(
        future: futureCountry,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            for (int i = 0; i < snapshot.data.length; i++) {
              countries.add(snapshot.data[i].name);
            }
            return _buildList(countries);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
        ),
      ),
    );
    throw UnimplementedError();
  }

  Widget _buildList(List<String> countries) => ListView.builder(
      itemCount: countries.length,
      itemBuilder: (BuildContext context, int index){
        return ListTile(
            title: Text(countries[index])
        );
      }
    //child: _buildContinentInformation(widget.index)
  );

}
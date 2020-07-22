import 'dart:io';
import 'package:countriesapp/serverError.dart';
import 'package:dio/dio.dart';
import 'package:countriesapp/apiClient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'baseModel.dart';
import 'homePage.dart';

List<String> urls = new List();

class Country {
  final String name, code;

  Country({this.name, this.code});
  factory Country.fromJson(Map<String, dynamic> json) {

    return Country(
      name: json['name'],
      code: json['alpha2Code']
    );
  }
}

class GetImage {
  Dio dio;
  RestClient apiClient;

  GetImage() {
    dio = new Dio();
    apiClient = new RestClient(dio);
  }

  Future<BaseModel<Data>> getDataFromCode(String code) async {
     Data response;
    try {
      response = await apiClient.getCountryImage(code);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
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

class _ContinentInformation extends State<MyContinentInformationsPage>{

  Future<List<Country>> futureCountry;
  Future<BaseModel<Data>> futureImage;
  int index;
  String country;
  _ContinentInformation(int index){
    this.index = index;
  }

  @override
  void initState() {
    super.initState();
    urls.clear();

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
    futureImage = GetImage().getDataFromCode('US');
  }

  @override
  Widget build(BuildContext context) {
    List<String> countries = new List();
    List<String> codes = new List();
    return Scaffold(
      appBar: AppBar(
          title: Text("Países")
      ),
      body: Center(
        child: FutureBuilder<List<Country>>(
        future: futureCountry,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            for(int i = 0; i < snapshot.data.length; i++) {
              countries.add(snapshot.data[i].name);
              codes.add(snapshot.data[i].code);
            }
            return getImages(countries,codes);
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

  Widget _buildList(List<String> countries, List<String> urls) => ListView.separated(
    itemCount: countries.length,
      itemBuilder: (BuildContext context, int index){
        return GestureDetector(
          onTap: () => print(countries[index]),
          child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipOval(
                      child: Container(
                        height: 65,
                        width: 45,
                        child: SvgPicture.network(
                         '${urls[0]}',
                          width: 45,
                          height: 65,
                          semanticsLabel: 'Bandeira do país',
                        fit: BoxFit.cover,
                        placeholderBuilder: (context) => CircularProgressIndicator(),
                    ),
                      ),
                    ),
                  ],
                ),
              ),
              title: Text(countries[index])
          ),
        );
      },
    separatorBuilder: (context, index) => Divider(),
  );

  getImages(List<String> countries, List<String> codes){
    //a api tem um limite baixo de requisições por minuto
    //futureImage = GetImage().getDataFromCode(codes[_counter++]);
    return FutureBuilder<BaseModel<Data>>(
        future: futureImage,
        builder: (context, AsyncSnapshot<BaseModel<Data>> snapshot) {
      if (snapshot.hasData) {
          urls.add(snapshot.data.data.countryImage.imageUrl);
          return _buildList(countries, urls);
          //return _counter == codes.length-1 ? _buildList(countries, urls) : getImages(countries, codes);
      }else if (snapshot.hasError) {
        return Text("${snapshot.error}");
      }
      return CircularProgressIndicator();
          }
      );
  }
}
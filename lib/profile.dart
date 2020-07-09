
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'authService.dart';

AuthService appAuth = new AuthService();

class ProfilePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 150,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.all(Radius.zero)),
              margin: EdgeInsets.all(0.0),
              elevation: 8,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/teste.png'),
                    radius: 30,
                  ),
                ),
                    Column(
                      mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0, bottom: 4.0),
                          child: Text('Marcos Felipe', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 4.0, right: 8.0, bottom: 8.0),
                          child: Text('23 anos', style: TextStyle(fontSize: 18, color: Colors.grey)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 300,
            color: Colors.white70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOption('Editar conta', Icons.edit),
                Divider(),
                _buildOption('Sugestões', Icons.comment),
                Divider(),
                _buildOption('Ajuda', Icons.help),
                Divider(),
                _buildOption('Configurações', Icons.settings)
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  appAuth.logout(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Sair', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 18, decoration: TextDecoration.underline),),
                ),
              ),
            ],
          )
        ],
      ),
    );
    throw UnimplementedError();
  }

}

Widget _buildOption(String option, IconData icon)=> Padding(
    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:[
        Row(
          mainAxisSize: MainAxisSize.min,
          children:[
            Icon(icon, color: Colors.black54),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 8.0, bottom: 8.0),
              child: Text(option,  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),),
            ),
          ],
        ),
        Icon(Icons.arrow_forward_ios, size: 16),
      ],
    ),
  );

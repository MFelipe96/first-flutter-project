
import 'package:countriesapp/bottomNavigationBar.dart';
import 'package:countriesapp/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Login();
}

final _emailController = TextEditingController();
final _passwordController = TextEditingController();
final _textFormKey = GlobalKey<FormState>();
bool _isLoading = false;

class _Login extends State<LoginPage>{

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
          children:[
        Container(
          decoration: BoxDecoration(
            color: Colors.black,
            image: new DecorationImage(
          fit: BoxFit.cover,
          colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
          image: AssetImage('images/wallpaper_flight.jpg'),
            )
          ),
        ),
            Container(
              height: double.infinity,
              child: !_isLoading ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset('images/globe.png',height: 100, width: 100,),
                  ),
                  Container(
                    child: signIn()
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 0.0, right: 16.0, bottom: 16.0),
                      child: _loginButton()
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0, bottom: 0.0),
                    child: _registerButton()
                  )
                ],
              ) : Center(
                child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation(Colors.white),)
                ),
              ),
          ],
        ),
      );
  }

  Widget _registerButton() => Container(
    child: Align(
      alignment: FractionalOffset.bottomCenter,
      child: GestureDetector(
        onTap: () => {},
        child: Text('Cadastrar', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),),
      ),
    )
  );

  Widget _loginButton() => Container(
    child:Column(
      children:[
        SizedBox(
          width: double.infinity,
          height: 50,
          child: RaisedButton(
            color: Colors.green.shade600,
            child: Text('Login', style: TextStyle(fontSize: 18, color: Colors.white),),
            onPressed: (){
              if(_textFormKey.currentState.validate()) {
                setState(() {
                  _isLoading = true;
                });
                appAuth.login(_emailController.text,
                    _passwordController.text).then((result) {
                  _isLoading = false;
                  if (result)
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) =>
                            BottomNavigationBarState()));
                  else
                    setState(() {
                      Toast.show("Login inválido", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM);
                    });
                });
              }
            },
          ),
        ),
      ],
    ),
  );
}

InputDecoration inputDecoration(String label, IconData icon){
  return InputDecoration(
      enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white)
      ),
    labelStyle: TextStyle(color: Colors.white) ,
    labelText: label,
    icon: Icon(icon, color: Colors.white),
  );
}

Form signIn() {
  return Form(
    key: _textFormKey,
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
                controller: _emailController,
                cursorColor: Colors.white,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Este campo deve ser preenchido';
                  }
                  return null;
                },
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: inputDecoration('E-mail', Icons.email)
            ),
            TextFormField(
                controller: _passwordController,
                obscureText: true,
                cursorColor: Colors.white,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Este campo deve ser preenchido';
                  }
                  return null;
                },
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: inputDecoration('Senha', Icons.lock)
            ),

          ],
        ),
      ),
    ),
  );
}


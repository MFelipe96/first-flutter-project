
import 'package:countriesapp/bottomNavigationBar.dart';
import 'package:countriesapp/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Login();
}

class _Login extends State<LoginPage>{

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _textFormKey = GlobalKey<FormState>();
  FocusNode _myFocusNode;
  bool _isLoading = false;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _myFocusNode = FocusNode();
    _myFocusNode.addListener(_focusChange);
  }

  @override
  void dispose() {
    _myFocusNode.removeListener(_focusChange);
    _myFocusNode.dispose();
    super.dispose();
  }

  void _focusChange() {
    if (_myFocusNode.hasFocus != _focused) {
      setState(() {
        _focused = _myFocusNode.hasFocus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    void _requestFocus(){
      setState(() {
        if(_focused)
          _myFocusNode.unfocus();
        else
          FocusScope.of(context).requestFocus(_myFocusNode);
      });
    }

    return Scaffold(
      backgroundColor: Colors.green,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Faça seu login para aproveitar (:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),),
            ),
            Container(
              child: Form(
                key: _textFormKey,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: !_isLoading ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          cursorColor: Colors.white,
                          validator: (value){
                            if(value.isEmpty) {
                              return 'Este campo deve ser preenchido';
                            }
                            return null;
                          },
                          decoration: inputDecoration('E-mail', !_focused, Icons.email)
                        ),
                        TextFormField(
                          focusNode: _myFocusNode,
                          onTap: _requestFocus,
                          controller: _passwordController, obscureText: true,
                          cursorColor: Colors.white,
                          validator: (value){
                            if(value.isEmpty){
                              return 'Este campo deve ser preenchido';
                            }
                          return null;
                          },
                          decoration: inputDecoration('Senha', _focused, Icons.lock)
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0.0, top: 48.0, right: 0.0, bottom: 16.0),
                          child:SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: RaisedButton(
                              child: Text('Login', style: TextStyle(fontSize: 18),),
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
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('-----'),
                            Text(' ou '),
                            Text('-----')
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0,top: 16.0, right: 0.0, bottom: 8.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: OutlineButton(
                              borderSide: BorderSide(color: Colors.white) ,
                              child: Text('Cadastrar', style: TextStyle(color: Colors.white, fontSize: 18)),
                              onPressed: (){},
                            ),
                          ),
                        ),
                      ],
                    ) : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation(Colors.white),)
                            ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      );
    throw UnimplementedError();
  }
}

InputDecoration inputDecoration(String label, bool _focused, IconData icon){
  return InputDecoration(
      enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white)
      ),
    labelStyle: TextStyle(color: _focused ? Colors.white : Colors.black) ,
    labelText: label,
    icon: Icon(icon, color: _focused ? Colors.white: Colors.black),
  );
}

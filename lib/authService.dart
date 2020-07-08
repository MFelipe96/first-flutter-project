import 'dart:math';

class AuthService {

  // Login
  Future<bool> login(String email, String password) async {
    // Simulate a future for response after 2 second.
    return await new Future<bool>.delayed(
        new Duration(
            seconds: 2
        ), () => accessPermited(email, password)
            //() => new Random().nextBool()
    );
  }

  // Logout
  Future<void> logout() async {
    // Simulate a future for response after 1 second.
    return await new Future<void>.delayed(
        new Duration(
            seconds: 1
        )
    );
  }
}

bool accessPermited(String email, String password){
  if(email == "marcos@teste.com" && password == "123456")
    return true;
  else
    return false;
}
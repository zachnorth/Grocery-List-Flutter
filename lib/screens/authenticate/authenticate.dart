import 'package:grocerylist/screens/authenticate/register.dart';
import 'package:grocerylist/screens/authenticate/signIn.dart';
import 'package:flutter/material.dart';

/*
  Widget that toggles between Sign In and Register
*/
class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {

    if(showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}

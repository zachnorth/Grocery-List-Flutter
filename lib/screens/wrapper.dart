import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grocerylist/models/user.dart';
import 'package:grocerylist/screens/home/home.dart';
import 'package:grocerylist/screens/authenticate/authenticate.dart';


/*
  This wrapper function determines whether the user is currently logged in or not.
  If the user is not logged in, when the login button on the home page is pressed
  it redirects to the login page.
  If the user is currently logged in, when the login button on the home page
  is pressed it redirects the user to the Home Page.
*/
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //value that holds the current user
    final user = Provider.of<User>(context);

    //if user is null, then they are not logged in. Otherwise they are logged in.
    if(user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}

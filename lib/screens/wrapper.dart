import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grocerylist/models/user.dart';
import 'package:grocerylist/screens/home/home.dart';
import 'package:grocerylist/screens/authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if(user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}

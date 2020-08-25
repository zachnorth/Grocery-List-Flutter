import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocerylist/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:grocerylist/models/user.dart';
import 'package:grocerylist/screens/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Grocery List'),
    );
  }
}

//Main page displayed when a user opens the app

class MyHomePage extends StatefulWidget {
  
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final CollectionReference _db = Firestore.instance.collection('FirstList');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[800],
      appBar: AppBar(
        title: Text('Grocery List', style: TextStyle(fontSize: 20.0, color: Colors.white)),
        backgroundColor: Colors.amber,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.settings, color: Colors.black),
            label: Text(''),
            onPressed: () => {},
          )
        ],
      ),
      body: Container(
        width: 400.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              height: 50.0,
              minWidth: 170,
              color: Colors.amber[600],
              elevation: 1.0,
              child: Text('Login', style: TextStyle(fontSize: 20.0, color: Colors.white)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.amber[600])
              ),
              onPressed: () {
                _homeWrapper(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  //redirects user through the wrapper to the home page if they are logged in or to the login page
  void _homeWrapper(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return StreamProvider<User>.value(
            value: AuthService().user,
            child: MaterialApp(
              home: Wrapper(),
            ),
          );
        }
      )
    );
  }
}

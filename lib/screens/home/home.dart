import 'package:flutter/material.dart';
import 'package:grocerylist/models/userList.dart';
import 'package:grocerylist/screens/home/newListForm.dart';
import 'package:grocerylist/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:grocerylist/models/user.dart' ;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Colors.teal[800],
      appBar: AppBar(
        title: Text('Home Page', style: TextStyle(fontSize: 20.0, color: Colors.white)),
        backgroundColor: Colors.amber[600],
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.arrow_back),
            label: Text(''),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
          FlatButton.icon(
            icon: Icon(Icons.settings),
            label: Text(''),
            onPressed: () {},
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 150.0),
                  MaterialButton(
                    height: 50.0,
                    minWidth: 170,
                    color: Colors.amber[600],
                    elevation: 1.0,
                    child: Text('New List', style: TextStyle(fontSize: 28.0, color: Colors.white)),
                    onPressed: () {
                      showModalBottomSheet(context: context, builder: (context) {
                        return Container(
                          color: Colors.teal[800],
                          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                          child: NewListForm(),
                        );
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.amber[600])
                    ),
                  ),
                  SizedBox(height: 100.0),
                  MaterialButton(
                    height: 50.0,
                    minWidth: 170,
                    color: Colors.amber[600],
                    elevation: 1.0,
                    child: Text('My Lists', style: TextStyle(fontSize: 28.0, color: Colors.white)),
                    onPressed: () {
                      showModalBottomSheet(context: context, builder: (context) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          decoration: BoxDecoration(
                            color: Colors.teal[800]
                          ),
                          child: UserList()
                        );
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.amber[600])
                    ),
                  ),
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}

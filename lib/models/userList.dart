import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocerylist/screens/home/currentList.dart';
import 'package:grocerylist/services/auth.dart';
import 'package:grocerylist/services/database.dart';
import 'package:grocerylist/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:grocerylist/models/user.dart';


/*
  This widget will retrieve all lists for the current user and display them in a modal on the home page
*/

class UserList extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    //value that contains the current user
    final user = Provider.of<User>(context);

    //Reference to Firestore database
    final CollectionReference _lists = Firestore.instance.collection('lists').document(user.uid).collection('lists');

    //stream builder that retrieves all lists from database in realtime
    return StreamBuilder<QuerySnapshot>(
      stream: _lists.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasError) {
          return new Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Loading();
          default:
            return new ListView(

              //each snapshot contains all lists in the database
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                //document created for each list in the snapshot
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.amber[600],
                    borderRadius: BorderRadius.circular(18.0),
                    border: Border.all(
                      color: Colors.black,
                      width: 1
                    ),

                  ),
                  //creates a list tile for each list in the snapshot out of each document
                  child: new ListTile(

                    enabled: true,
                    title: new Text(document['name'], style: TextStyle(fontSize: 20.0, color: Colors.white)),
                    onTap: () {
                      _helper(context, document['name']);
                    },
                  ),
                );
              }).toList(),
            );
        }
      },
    );
  }

  //helper function that directs user that directs user to a page where they can view the list they selected
  void _helper(BuildContext context, String name) {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return StreamProvider<User>.value(
                value: AuthService().user,
                //widget that displays the selected list
                child: CurrentList(name: name),
              );
            }
        )
    );
  }
}

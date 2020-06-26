import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocerylist/models/user.dart';
import 'package:grocerylist/services/database.dart';
import 'package:grocerylist/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:grocerylist/screens/home/newItemForm.dart';

class CurrentList extends StatelessWidget {

  final String name;

  CurrentList({ this.name });

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    final CollectionReference _lists = Firestore.instance.collection('lists').document(user.uid).collection('lists');

    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    
    String deleteThisItem;
    

    //Snack Bar
    final snackbar =  SnackBar(
      backgroundColor: Colors.black,
      content: Row(
        children: <Widget>[
          Expanded(child: Text('Are you sure?', style: TextStyle(fontSize: 20.0, color: Colors.white))),
          SizedBox(width: 10.0),
          Expanded(child: MaterialButton(
            height: 40,
            minWidth: 120,
            child: Icon(Icons.check),
            onPressed: () async {
              await DatabaseService(uid: user.uid).deleteList(user.uid, name);
              Navigator.of(context).pop();
            },
          )),
          Expanded(child: MaterialButton(
            height: 40,
            minWidth: 120,
            child: Icon(Icons.cancel),
            onPressed: () => _scaffoldKey.currentState.hideCurrentSnackBar(),
          ))
        ],
      ),
    );


    final snackbar1 =  SnackBar(
      backgroundColor: Colors.black,
      content: Row(
        children: <Widget>[
          Expanded(child: Text('Are you sure?', style: TextStyle(fontSize: 20.0, color: Colors.white))),
          SizedBox(width: 10.0),
          Expanded(child: MaterialButton(
            height: 40,
            minWidth: 120,
            child: Icon(Icons.check),
            onPressed: () async {
              await DatabaseService(uid: user.uid).deleteItem(user.uid, deleteThisItem, name);
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
          )),
          Expanded(child: MaterialButton(
            height: 40,
            minWidth: 120,
            child: Icon(Icons.cancel),
            onPressed: () => _scaffoldKey.currentState.hideCurrentSnackBar(),
          ))
        ],
      ),
    );
    
    
    
    
    

    return StreamBuilder<QuerySnapshot>(
      stream: _lists.document(name).collection('list').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasError) {
          return new Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Loading();
          default:
            return Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.teal[800],
              appBar: AppBar(
                backgroundColor: Colors.amber[600],
                title: Text(name, style: TextStyle(fontSize: 20.0, color: Colors.white)),
                actions: <Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.add),
                    label: Text(''),
                    onPressed: () async {
                        showModalBottomSheet(context: context, builder: (context) {
                          return Container(
                            color: Colors.teal[800],
                            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                            child: NewItemForm(listName: name),
                          );
                        });
                    },
                  ),
                  Container(
                    width: 80,
                    height: 30,
                    child: Builder(
                      builder: (BuildContext context) {
                        return FlatButton.icon(
                          icon: Icon(Icons.cancel),
                          label: Text(''),
                          onPressed: () async {
                            _scaffoldKey.currentState.showSnackBar(snackbar);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              body: new ListView(
                children: snapshot.data.documents.map((DocumentSnapshot document) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(18.0),
                      border: Border.all(
                          color: Colors.black,
                          width: 1
                      ),

                    ),
                    child: new ListTile(
                      enabled: true,
                      title: new Text('${document['name']}: ${document['quantity']}', style: TextStyle(fontSize: 20.0, color: Colors.white)),
                      onTap: () {
                        print('Ive Been Pressed');
                      },
                      onLongPress: () {
                        deleteThisItem = document['name'];
                        _scaffoldKey.currentState.showSnackBar(snackbar1);

                      },
                    ),
                  );
                }).toList(),
              ),
            );
        }
      },
    );
  }
}

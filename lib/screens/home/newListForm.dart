import 'package:flutter/material.dart';
import 'package:grocerylist/models/user.dart';
import 'package:grocerylist/services/database.dart';
import 'package:grocerylist/shared/constants.dart';
import 'package:provider/provider.dart';


/*
  Form to create a new list
*/
class NewListForm extends StatefulWidget {
  @override
  _NewListFormState createState() => _NewListFormState();
}

class _NewListFormState extends State<NewListForm> {

  final _formKey = GlobalKey<FormState>();

  String _listName;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              initialValue: 'New List',
              decoration: textInputDecoration.copyWith(hintText: 'List Name'),
              validator: (val) => val == 'New List' ? 'Please Enter A List Name' : null,
              onChanged: (val) => setState(() => _listName = val),
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              color: Colors.amber[600],
              child: Text('Submit', style: TextStyle(fontSize: 20.0, color: Colors.white)),
              onPressed: () async {
                if(_formKey.currentState.validate()) {
                  //call to DatabaseService.newList that creates new list in the database
                  await DatabaseService(uid: user.uid).newList(_listName);
                }
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

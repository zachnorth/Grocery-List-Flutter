import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocerylist/models/user.dart';
import 'package:grocerylist/services/database.dart';
import 'package:grocerylist/shared/constants.dart';
import 'package:provider/provider.dart';

/*
  Form to create new item in currently selected list
*/
class NewItemForm extends StatefulWidget {

  final String listName;

  NewItemForm({ this.listName});


  @override
  _NewItemFormState createState() => _NewItemFormState(listName: listName);
}

class _NewItemFormState extends State<NewItemForm> {

  final String listName;

  _NewItemFormState({ this.listName });

  final _formKey = GlobalKey<FormState>();

  String _itemName;
  int _quantity;


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Item Name'),
              validator: (val) => val == 'New List' ? 'Please Enter A List Name' : null,
              onChanged: (val) => setState(() => _itemName = val),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              validator: (val) => val.isEmpty ? 'Please Select A Quantity' : null,
              decoration: textInputDecoration.copyWith(hintText: 'Quantity'),
              onChanged: (val) => setState(() => _quantity = int.parse(val)),
            ),
            RaisedButton(
              color: Colors.amber[600],
              child: Text('Submit', style: TextStyle(fontSize: 20.0, color: Colors.white)),
              onPressed: () async {
                if(_formKey.currentState.validate()) {
                  print(listName);
                  //call to DatabaseService.addNewItem that adds new item to currently selected list
                  await DatabaseService(uid: user.uid).addNewItem(user.uid, _itemName, listName, _quantity);
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

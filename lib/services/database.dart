import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class DatabaseService {


  final String uid;

  DatabaseService({ this.uid });

  final CollectionReference lists = Firestore.instance.collection('lists');

  Future newList(String listName) async {
    return await lists.document(uid)
        .collection('lists')
        .document(listName)
        .setData({ 'name': listName, 'date': DateTime.now() });
  }

  Future deleteList(String uid, String name) async {

    await lists.document(uid).collection('lists').document(name).delete();

    dynamic result = await lists.document(uid).collection('lists').document(name).get();
    if(!result.exists) {
      print('List $name deleted successfully');
    } else {
      print('List $name not deleted...');
    }
  }


  Future addNewItem(String uid, String itemName, String listName, int quantity) async {

    return await lists.document(uid)
        .collection('lists')
        .document(listName)
        .collection('list')
        .document(itemName)
        .setData({ 'name': itemName, 'quantity': quantity });
  }

  Future deleteItem(String uid, String itemName, String listName) async {

    await lists.document(uid)
        .collection('lists')
        .document(listName)
        .collection('list')
        .document(itemName)
        .delete();

    dynamic result = await lists.document(uid).collection('lists').document(listName).collection('list').document(itemName).get();
    if(!result.exists) {
      print('Item deleted successfully');
    } else {
      print('Item not deleted...');
    }
  }
}
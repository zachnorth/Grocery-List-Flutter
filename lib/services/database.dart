import 'package:cloud_firestore/cloud_firestore.dart';

/*
  Class that holds all database interaction services
*/
class DatabaseService {


  final String uid;

  DatabaseService({ this.uid });

  //Reference to generic lists section in database
  final CollectionReference lists = Firestore.instance.collection('lists');

  //method to create a new list
  Future newList(String listName) async {
    return await lists.document(uid)
        .collection('lists')
        .document(listName)
        .setData({ 'name': listName, 'date': DateTime.now() });
  }

  //method to delete selected list
  Future deleteList(String uid, String name) async {

    await lists.document(uid).collection('lists').document(name).delete();

    dynamic result = await lists.document(uid).collection('lists').document(name).get();
    if(!result.exists) {
      print('List $name deleted successfully');
    } else {
      print('List $name not deleted...');
    }
  }


  //method to add new item to currently selected list
  Future addNewItem(String uid, String itemName, String listName, int quantity) async {

    return await lists.document(uid)
        .collection('lists')
        .document(listName)
        .collection('list')
        .document(itemName)
        .setData({ 'name': itemName, 'quantity': quantity });
  }

  //method to delete selected item from currently selected list
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
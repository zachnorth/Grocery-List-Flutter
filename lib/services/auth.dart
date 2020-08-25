import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocerylist/models/user.dart';

/*
  Script that contains all authorization methods
*/
class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //method that takes in a FirebaseUser and returns a User formatted for this app
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //method for update value of User
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //method that signs in a user with email and password and returns an instance
  //of User that is compatible with app
  Future signInWithEmailAndPassword(String email, String password) async {

    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //method that registers a user with email and password and returns an instance
  //of User that is compatible with app
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //method that signs out current user
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

}
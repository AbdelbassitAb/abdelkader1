import 'package:abdelkader1/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'controllers.dart';

class AuthController extends GetxController{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Chef _userFromFirebaseUser(User user) {
    return user != null ? Chef(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<Chef> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password,
      String name, String numTlf, double money) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      // create a new document for the user with a uniq uid
      await DataBaseController(uid: user.uid).updateUserData(
          user.uid, name, email, numTlf, money, false,
          );
      return _userFromFirebaseUser(user);
    } catch (error) {
      return error.toString();
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}

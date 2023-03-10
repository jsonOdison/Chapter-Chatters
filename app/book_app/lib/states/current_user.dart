import 'package:book_app/models/user.dart';
import 'package:book_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CurrentUser extends ChangeNotifier {
  UserModel _currentUser = UserModel();

  UserModel get getUid => _currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //set the state for login cycle
  Future<String> onStartUp() async {
    String retVal = 'error';
    try {
      User firebaseUser = _auth.currentUser!;
      _currentUser.uid = firebaseUser.uid;
      _currentUser.email = firebaseUser.email!;
      retVal = 'success';
    } on FirebaseAuthException catch (e) {
      retVal = e.message.toString();
    }
    return retVal;
  }

  //set the state for logout or signout  cycle
  // ignore: non_constant_identifier_names
  Future<String> SingOut() async {
    String retVal = 'error';
    try {
      await _auth.signOut();
      _currentUser = UserModel();

      retVal = 'success';
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return retVal;
  }

  Future<String> signUpUserWithEmail(
      String email, String password, String fullName) async {
    String retVal = "error";
    UserModel user = UserModel();
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user.uid = authResult.user?.uid;
      user.email = authResult.user?.email;
      user.fullname = fullName;
      String returnString = await Database().createUser(user);
      if (returnString == 'success') {
        retVal = "success";
      }
    } on FirebaseAuthException catch (e) {
      retVal = e.message.toString();
    }
    return retVal;
  }

  Future<String> loginUserWithEmail(String email, String password) async {
    String retVal = "error";
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = authResult.user;
      if (user != null) {
        _currentUser.uid = user.uid;
        _currentUser.email = user.email!;
        retVal = "success";
      }
    } on FirebaseAuthException catch (e) {
      retVal = e.message.toString();
    }
    notifyListeners();
    return retVal;
  }

  Future<String> loginUserWithGoogle() async {
    String retVal = "error";
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    UserModel user = UserModel();
    try {
      //get the user
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      //authenticate the user
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      UserCredential authResult = await _auth.signInWithCredential(credential);
      //signin to firebase
      if (authResult.additionalUserInfo!.isNewUser) {
        user.uid = authResult.user!.uid;
        user.email = authResult.user!.email;
        user.fullname = authResult.user!.displayName;
        Database().createUser(user);
      }
      _currentUser.uid = authResult.user!.uid;
      _currentUser.email = authResult.user!.email!;
      retVal = "success";
    } on FirebaseAuthException catch (e) {
      retVal = e.message.toString();
    }
    return retVal;
  }
}

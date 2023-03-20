import 'package:book_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> createUser(UserModel user) async {
    String retVal = 'error';
    try {
      //create a user
      await _firestore.collection("users").doc(user.uid).set({
        'fullname': user.fullname,
        'email': user.email,
        'accountCreated': Timestamp.now(),
      });
      retVal = 'success';
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return retVal;
  }

  Future<UserModel?> getUserInfo(String uid) async {
    UserModel retVal = UserModel();
    try {
      DocumentSnapshot docSnap =
          await _firestore.collection('users').doc(uid).get();
      retVal.uid = uid;
      Map<String, dynamic> data = docSnap.data() as Map<String, dynamic>;
      retVal.fullname = data['fullname'];
      retVal.email = data['email'];
      retVal.accountCreated = data['accountCreated'];
      retVal.groupId = data['groupId'];
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return null;
  }
}

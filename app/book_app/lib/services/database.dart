// import 'package:book_app/models/user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';

// class Database {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   Future<String> createUser(UserModel user) async {
//     String retVal = 'error';
//     try {
//       //create a user
//       await _firestore.collection("users").document(user.uid).setData({
//         'fullname':user.fullname;
      
//       });
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//     }

//     return retVal;
//   }
// }

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;
  String? fullname;
  Timestamp? accountCreated;
  UserModel({
    this.uid,
    this.email,
    this.fullname,
    this.accountCreated,
  });
}

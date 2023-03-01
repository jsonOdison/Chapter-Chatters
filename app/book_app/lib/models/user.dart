// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String uid;
  late String email;
  late String fullname;
  late Timestamp accountCreated;
  UserModel({
    required this.uid,
    required this.email,
    required this.fullname,
    required this.accountCreated,
  });
}

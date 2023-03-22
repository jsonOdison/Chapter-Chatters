// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class UserGroup {
  String? name;
  String? uid;
  String? leader;
  List<String> members;
  Timestamp groupCreated;
  UserGroup({
    required this.name,
    required this.uid,
    this.leader,
    required this.members,
    required this.groupCreated,
  });
}

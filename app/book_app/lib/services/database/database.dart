import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  //references for our collections

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");
  final CollectionReference libraryCollection =
      FirebaseFirestore.instance.collection('library');
  //saving the user data

  Future savingUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "groups": [],
      "profilePic": "",
      "uid": uid,
      "library": []
    });
  }

  //getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  //getting list of groups
  getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  // Future<DocumentSnapshot<Map<String, dynamic>>> getUserLibrary() async {
  //   return userCollection.doc(uid).get();
  // }

  //creating a group
  Future createGroup(String userName, String id, String groupName) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id}_$userName",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$userName"]),
      "groupId": groupDocumentReference.id,
    });
    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "groups":
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
    });
  }

  //getting the chats
  getChats(String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  //get group admin
  Future getGroupAdmin(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }

  //getMembers
  getGroupMembers(groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }

  // search function
  searchByName(String groupName) {
    return groupCollection.where("groupName", isEqualTo: groupName).get();
  }
  // function to check is joined or not

  Future<bool> isUserJoined(
      String groupName, String groupId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> groups = await documentSnapshot['groups'];
    if (groups.contains("${groupId}_$groupName")) {
      return true;
    } else {
      return false;
    }
  }

  // toggling the group join or exit
  Future toggleGroupJoin(
      String groupId, String userName, String groupName) async {
    //doc ref
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];

    //if user has is in groups -> then remove or re-join
    if (groups.contains("${groupId}_$groupName")) {
      await userDocumentReference.update({
        "groups": FieldValue.arrayRemove(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_$userName"])
      });
    } else {
      await userDocumentReference.update({
        "groups": FieldValue.arrayUnion(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$userName"])
      });
    }
  }

  // send messge
  sendMessage(String groupId, Map<String, dynamic> chatMessagesData) async {
    groupCollection.doc(groupId).collection("messages").add(chatMessagesData);
    groupCollection.doc(groupId).update({
      "recentMessage": chatMessagesData['message'],
      "recentMessageSender": chatMessagesData['sender'],
      "recentMessageTime": chatMessagesData['time'].toString(),
    });
  }

  //toggling if User has a library First
  Future<bool> isLibraryEmpty() async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(uid);
    final userData = await userRef.get();
    final libraryData = userData.data()?['library'];
    return libraryData == null || libraryData.isEmpty;
  }

  //does book exist already

  Future<bool> bookExist(String bookId) async {
    final usersCollection = FirebaseFirestore.instance.collection('users');

    final userDoc = await usersCollection.doc(uid).get();

    final library = userDoc.data()?['Library'] as Map<String, dynamic>;

    return library.containsKey(bookId);
  }

  Future<void> addBookToLibrary(String bookId, String bookName) async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(uid);

    Map<String, dynamic> bookData = {
      bookId: {
        'id': bookId,
        'name': bookName,
      },
    };
    return await userRef.update({
      'library': FieldValue.arrayUnion([bookData])
    });
  }

  //delete books from libary
  Future<void> deleteBookToLibrary(String bookId) async {
    try {
      final userRef = FirebaseFirestore.instance.collection('users').doc(uid);
      final userDoc = await userRef.get();

      List<Map<String, dynamic>> library =
          List<Map<String, dynamic>>.from(userDoc.get('library') ?? []);

      // Find the index of the book in the library array
      int bookIndex = library.indexWhere((book) => book.containsKey(bookId));

      if (bookIndex != -1) {
        // Remove the book from the library
        library.removeAt(bookIndex);

        // Update the library in the database
        await userRef.update({'library': library});

        if (kDebugMode) {
          print("Book deleted successfully.");
        }
      } else {
        if (kDebugMode) {
          print("Book not found in the library.");
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print("Failed to delete book: $error");
      }
    }
  }
}

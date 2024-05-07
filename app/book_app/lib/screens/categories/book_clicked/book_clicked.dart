import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../services/database/database.dart';

class BookClicked extends StatelessWidget {
  final String bookid;
  final String title;
  final String image;
  final String author;

  const BookClicked({
    Key? key,
    required this.title,
    required this.image,
    required this.author,
    required this.bookid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              image,
              height: screenHeight * 0.5,
              width: screenWidth * 0.5,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "By $author",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                addToLibrary(context, bookid, title);
              },
              child: const Text("Add book"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addToLibrary(BuildContext context, bookId, bookName) async {
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .addBookToLibrary(bookId, bookName);
    if (kDebugMode) {
      print("successfully added");
    }
    var snackBar = const SnackBar(
      content: Text("Book created succesfully"),
      backgroundColor: Color.fromARGB(255, 50, 114, 52),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

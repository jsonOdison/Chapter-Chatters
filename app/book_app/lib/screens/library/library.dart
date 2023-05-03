import 'package:book_app/services/books_api/fetch_books.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/book_details.dart';

// assume you have access to the uid
final userRef = FirebaseFirestore.instance
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid);

class Library extends StatelessWidget {
  const Library({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              "Library",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: const Icon(Icons.notifications),
                  color: Colors.black,
                  onPressed: () {
                    // Do something
                  },
                ),
              ),
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage("assets/icons/avatar_profile.png"),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: userRef.snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }
          final library =
              (snapshot.data?.data() as Map<String, dynamic>)['library'] ?? [];
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: library.length,
            itemBuilder: (BuildContext context, int index) {
              final book = library[index];
              final bookData = book.values.first as Map<String, dynamic>?;
              final bookName = bookData?['name'] as String?;
              final bookId = bookData?['id'] as String;

              return FutureBuilder<BookDetails>(
                future: BooksApi().fetchBookDetails(bookId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final bookDetails = snapshot.data!;
                    return Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Center(
                              child: Text(
                                bookDetails.title,
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Image.network(
                            bookDetails.thumbnail ?? '',
                            width: 100,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}

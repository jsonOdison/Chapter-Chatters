import 'package:book_app/services/books_api/fetch_books.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../services/database/database.dart';
import '../book_details/book_details.dart';
import '../../models/book_details.dart';

// assume you have access to the uid

class Library extends StatefulWidget {
  const Library({
    super.key,
  });

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  late DocumentReference<Map<String, dynamic>> userRef;
  late double _cardWidth;

  @override
  void initState() {
    super.initState();
    setState(() {
      userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: AppBar(
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
          final screenWidth = MediaQuery.of(context).size.width;
          if (screenWidth < 600) {
            _cardWidth = (screenWidth - 30) / 2;
          } else {
            _cardWidth = (screenWidth - 50) / 4;
          }
          return library.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Your Library is currently Empty ",
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 0.5,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: _cardWidth / (_cardWidth + 80),
                  ),
                  itemCount: library.length,
                  itemBuilder: (BuildContext context, int index) {
                    final book = library[index];
                    final bookData = book.values.first as Map<String, dynamic>?;

                    final bookId = bookData?['id'] as String;

                    return FutureBuilder<BookDetails>(
                      future: BooksApi().fetchBookDetails(bookId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final bookDetails = snapshot.data!;
                          return GestureDetector(
                            onLongPress: () =>
                                deleteBookDBHelper(context, bookId),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BookDetailsClicked(bookId: bookId),
                                ),
                              );
                            },
                            child: Card(
                              color: const Color(0xffFEF8F0),
                              elevation: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    bookDetails.thumbnail ?? '',
                                    width: 100,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
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
                                ],
                              ),
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

  Future<void> deleteBookDBHelper(BuildContext context, bookId) async {
    await DatabaseService()
        .deleteBookToLibrary(FirebaseAuth.instance.currentUser!.uid, bookId);
    if (kDebugMode) {
      print("successfully deleted");
    }
    var snackBar = const SnackBar(
      content: Text("Book Deleted succesfully"),
      backgroundColor: Color.fromARGB(255, 50, 114, 52),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

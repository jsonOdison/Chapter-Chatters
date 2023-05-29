import 'package:book_app/models/book_details.dart';
import 'package:book_app/services/books_api/fetch_books.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../models/book.dart';
import '../../../../services/database/database.dart';
import '../../../../widgets/widgets.dart';
import '../../../book_details_clicked/book_details_clicked.dart';

class LibrarySection extends StatefulWidget {
  const LibrarySection({super.key});

  @override
  State<LibrarySection> createState() => _LibrarySectionState();
}

class _LibrarySectionState extends State<LibrarySection> {
  final List<BookModel> _books = [];
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
    return Column(
      children: [
        Row(
          //padding for the title section widget
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Your Library",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(fontSize: 25),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        //check if book library is empty
        StreamBuilder<DocumentSnapshot>(
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
                (snapshot.data?.data() as Map<String, dynamic>)['library'] ??
                    [];

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
                : SizedBox(
                    height: 250,
                    child: ListView.builder(
                        // padding: const EdgeInsets.all(10),
                        scrollDirection: Axis.horizontal,
                        itemCount: library.length,
                        itemBuilder: (BuildContext context, int index) {
                          final book = library[index];
                          final bookData =
                              book.values.first as Map<String, dynamic>?;
                          final bookId = bookData?['id'] as String;
                          return FutureBuilder<BookDetails>(
                              future: BooksApi().fetchBookDetails(bookId),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final bookDetails = snapshot.data!;
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            nextScreen(
                                                context,
                                                BookDetailsClicked(
                                                  bookId: bookDetails.id,
                                                ));
                                          },
                                          child: Card(
                                            elevation: 10,
                                            child: Container(
                                              height: 180,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      bookDetails.thumbnail ??
                                                          ''),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 160,
                                          child: Center(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  bookDetails.title,
                                                  softWrap: true,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    bookDetails.authors!
                                                        .join(', ')),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('Errpr: ${snapshot.error}');
                                } else {
                                  return const SizedBox.shrink();
                                }
                              });
                        }),
                  );
          },
        ),
      ],
    );
  }

  Future<void> deleteBookDBHelper(BuildContext context, bookId) async {
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .deleteBookToLibrary(bookId);
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

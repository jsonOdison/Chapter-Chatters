import 'package:book_app/services/Books_api/fetch_books.dart';
import 'package:book_app/services/database/database.dart';
import 'package:book_app/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/book_details.dart';

class BookDetailsClicked extends StatefulWidget {
  final String bookId;

  const BookDetailsClicked({Key? key, required this.bookId}) : super(key: key);

  @override
  State<BookDetailsClicked> createState() => _BookDetailsClickedState();
}

class _BookDetailsClickedState extends State<BookDetailsClicked> {
  bool _isLoading = true;
  bool _isBookAdded = false;
  late BookDetails _bookDetails = BookDetails(id: widget.bookId, title: '');
  Future<void> _loadBook() async {
    try {
      final fetchedBook = await BooksApi().fetchBookDetails(widget.bookId);
      final bookExist = await DatabaseService().bookExist(widget.bookId);
      if (fetchedBook != null) {
        setState(() {
          _bookDetails = fetchedBook;
          _isLoading = false;
          _isBookAdded = bookExist;
        });
      } else {
        // Handle the case where the book details are null or not available
        // For example, you could show an error message or navigate back.
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading book: $e');
      }
      // Handle the error appropriately (e.g., show an error message).
    }
  }

  @override
  void initState() {
    super.initState();
    _loadBook();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 250,
                    width: 172,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.grey),
                                strokeWidth: 2,
                              ),
                            )
                          : Image.network(
                              _bookDetails.thumbnail ?? '',
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(_bookDetails.title),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: 350,
                      child: Center(
                          child:
                              Text("by ${_bookDetails.authors?.join(", ")}"))),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: _isBookAdded
                        ? const Text("data")
                        : buildButton(
                            "add",
                            () => addBookDBHelper(
                                context, widget.bookId, _bookDetails.title),
                            context),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DataTable(
                    dataRowHeight: 100,
                    headingRowHeight: 10,
                    columnSpacing: 30,
                    dividerThickness: 2,
                    columns: [
                      DataColumn(label: Container()),
                      DataColumn(label: Container()),
                    ],
                    rows: [
                      DataRow(cells: [
                        const DataCell(Text(
                          'Book author(s)',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )),
                        DataCell(Text(_bookDetails.authors?.join(", ") ?? "")),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text(
                          'Book categories/genres',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )),
                        DataCell(
                            Text(_bookDetails.categories?.join(", ") ?? "")),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text(
                          'Book language',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )),
                        DataCell(Text(_bookDetails.language ?? "")),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text(
                          'Book publisher',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )),
                        DataCell(Text(_bookDetails.publisher ?? "")),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text(
                          'Book published date',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )),
                        DataCell(Text(_bookDetails.publishedDate ?? "")),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text(
                          'Book page count',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )),
                        DataCell(
                            Text(_bookDetails.pageCount?.toString() ?? "")),
                      ]),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87,
                          letterSpacing: 0.5,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "${_bookDetails.description}",
                      style: const TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.5,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> addBookDBHelper(BuildContext context, bookId, bookName) async {
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

  // void launchGoogleBooksPreview(
  //     BuildContext context, String? previewLink) async {
  //   if (previewLink != null) {
  //     final Uri url = Uri.parse(previewLink);
  //     if (await canLaunchUrl(url.toString())) {
  //       await launchUrl(url.toString());
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Failed to launch preview.'),
  //         ),
  //       );
  //     }
  //   }
  // }
}

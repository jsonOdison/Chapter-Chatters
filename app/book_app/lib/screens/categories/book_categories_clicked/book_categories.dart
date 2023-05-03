import 'package:book_app/screens/categories/book_clicked/book_clicked.dart';
import 'package:book_app/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../models/book.dart';
import '../../../services/Books_api/fetch_books.dart';

class BookScreen extends StatefulWidget {
  final String category;
  final String bookTitle;

  const BookScreen({Key? key, required this.category, required this.bookTitle})
      : super(key: key);

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  List<BookModel> books = [];

  Future<void> _loadBooks() async {
    try {
      final fetchedBooks =
          await BooksApi().fetchBooksByCategory(widget.category);
      setState(() {
        books = fetchedBooks;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error loading books: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: Center(
        child: books.isNotEmpty
            ? ListView.separated(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        nextScreen(
                            context,
                            BookClicked(
                              title: book.title,
                              image: book.thumbnail,
                              author: book.author.join(', '),
                              bookid: book.id,
                            ));
                      },
                      child: ListTile(
                        leading: Image.network(
                          book.thumbnail,
                          height: 1200,
                          width: 50,
                        ),
                        title: Text(book.title),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}

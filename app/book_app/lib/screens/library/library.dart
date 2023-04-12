import 'dart:convert';

import 'package:book_app/models/book.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  bool isLoading = false;
  List<BookClass> books = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: List.generate(books.length, (index) {
                final book = books[index];
                final title = book.title ?? 'Unknown Title';
                final author = book.author ?? 'Unknown Author';
                final bookDescription =
                    book.bookDescription ?? 'No description available';
                final coverImg = book.coverImg;

                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: coverImg != null
                            ? Image(image: coverImg, fit: BoxFit.cover)
                            : Container(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(author),
                            const SizedBox(height: 4),
                            Text(
                              bookDescription,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchBooks,
        child: const Icon(
          Icons.refresh,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<List<BookClass>> fetchBooks() async {
    setState(() {
      isLoading = true;
    });

    try {
      const String url =
          'https://www.googleapis.com/books/v1/volumes?q=game of thrones';
      final uri = Uri.parse(url);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final items = json['items'] as List<dynamic>;
        final List<BookClass> booksList = [];

        for (final item in items) {
          final volumeInfo = item['volumeInfo'];
          final id = item['id'];
          final title = volumeInfo['title'] ?? 'Unknown Title';
          final List<dynamic> authors =
              volumeInfo['authors'] ?? ['Unknown author'];
          final String author = authors.join(', ');
          final String bookDescription = volumeInfo['description'] ?? '';
          final String thumbnailUrl =
              volumeInfo['imageLinks']['thumbnail'] ?? '';
          final ImageProvider coverImg = NetworkImage(thumbnailUrl);
          final book = BookClass(id, title, author, bookDescription, coverImg);
          booksList.add(book);
        }

        setState(() {});
        return booksList;
      } else {
        throw Exception('Failed to fetch books');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to fetch books'),
        ),
      );
      return [];
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}

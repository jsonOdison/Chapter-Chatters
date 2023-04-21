import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchBook extends StatefulWidget {
  const SearchBook({super.key});

  @override
  State<SearchBook> createState() => _SearchBookState();
}

class _SearchBookState extends State<SearchBook> {
  TextEditingController searchBookController = TextEditingController();
  List<dynamic> books = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 90,
            color: Colors.white.withOpacity(0.9),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                SizedBox(
                    height: 300,
                    width: 320,
                    child: TextField(
                      controller: searchBookController,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade400, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade600, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade400, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Search for a Group",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                GestureDetector(
                  onTap: () => fetchBooks(searchBookController.text),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(40)),
                    child: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              var book = books[index];
              var id = book['id'];
              var bookTitle = book['volumeInfo']['title'];
              var authors = book['volumeInfo']['authors'];
              var authorString =
                  authors != null ? authors.join(', ') : 'Unknown';
              var img = book['volumeInfo']['imageLinks'] != null
                  ? book['volumeInfo']['imageLinks']['thumbnail']
                  : 'http://via.placeholder.com/200x150';

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Image.network(
                    img,
                    height: 1200,
                    width: 50,
                  ),
                  title: Text(bookTitle),
                  subtitle: Text("by $authorString"),
                ),
              );
            },
          ))
        ],
      ),
    );
  }

  void fetchBooks(String searchTerm) async {
    try {
      if (searchTerm.isEmpty) return;
      final String url =
          'https://www.googleapis.com/books/v1/volumes?q=$searchTerm';
      var uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      setState(() {
        books = json['items'];
      });
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching books: $error');
      }
      // Handle error here, for example show a snackbar or display an error message
    }
  }
}

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
  TextEditingController searchController = TextEditingController();
  List<dynamic> books = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => fetchBooks(searchController.text),
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
        print(books);
      });
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching books: $error');
      }
      // Handle error here, for example show a snackbar or display an error message
    }
  }
}

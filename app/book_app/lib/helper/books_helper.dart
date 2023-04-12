import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class books extends StatefulWidget {
  const books({super.key});

  @override
  State<books> createState() => _booksState();
}

class _booksState extends State<books> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: fetchUser),
    );
  }

  void fetchUser() async {
    const String url = 'https://www.googleapis.com/books/v1/volumes?q=flutter';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      final books = json['items'];
      print(books);
    });
    print("fetch books completed");
  }
}

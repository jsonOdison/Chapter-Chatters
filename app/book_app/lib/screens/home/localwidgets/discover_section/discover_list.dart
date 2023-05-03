import 'dart:math';

import 'package:book_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../../../models/book.dart';
import '../../../../services/Books_api/fetch_books.dart';
import 'book_cards/book_cards.dart';

class CategoryList extends StatefulWidget {
  final String searchTerm;
  final int maxResults;
  const CategoryList({Key? key, required this.maxResults, this.searchTerm = ''})
      : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<BookModel> _books = [];
  String _searchTerm = "";
  // stuff

  static final _random = Random();
  static final _keywords = keywords;

  @override
  void initState() {
    super.initState();
    _searchTerm = _keywords[_random.nextInt(_keywords.length)];
    _fetchBooks(_searchTerm);
  }

  Future<void> _fetchBooks(String searchTerm) async {
    final booksApi = BooksApi();
    final books = await booksApi.fetchBooks(
      searchTerm,
      maxResults: 5,
    );
    setState(() {
      _books = books;
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
              "Discover",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 20),
            ),
            Text(
              "view all",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                  color: const Color.fromARGB(255, 162, 160, 160)),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        BookCard(
          books: _books,
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          //padding for the title section widget
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Continue Reading",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 20),
            ),
            Text(
              "view all",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                  color: const Color.fromARGB(255, 162, 160, 160)),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        BookCard(
          books: _books,
        ),
      ],
    );
  }
}

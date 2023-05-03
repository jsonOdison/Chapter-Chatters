import 'package:flutter/material.dart';

import '../../../../../models/book.dart';

class BookCard extends StatefulWidget {
  final List<BookModel> books;

  const BookCard({required this.books, Key? key}) : super(key: key);

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final book in widget.books)
            buildBookCard(
              author: book.author,
              thumbnail: book.thumbnail,
              title: book.title,
            ),
        ],
      ),
    );
  }
}

Widget buildBookCard(
    {required String thumbnail,
    required String title,
    required List<String> author}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Card(
          elevation: 10,
          child: Container(
            height: 150,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(thumbnail),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 150,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(author.join(', ')),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

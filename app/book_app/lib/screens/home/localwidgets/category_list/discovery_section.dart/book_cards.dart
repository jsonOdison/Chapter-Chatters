import 'package:flutter/material.dart';

class BookCard extends StatefulWidget {
  const BookCard({super.key});

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
          buildBookCard("assets/images/book1.jpg"),
          buildBookCard("assets/images/book3.jpg"),
          buildBookCard("assets/images/book2.jpg"),
          buildBookCard("assets/images/book4.jpg"),
        ],
      ),
    );
  }
}

buildBookCard(String path) {
  return Padding(
    padding: const EdgeInsets.only(right: 16.0),
    child: Card(
      child: Container(
        height: 230,
        width: 150,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(path),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}

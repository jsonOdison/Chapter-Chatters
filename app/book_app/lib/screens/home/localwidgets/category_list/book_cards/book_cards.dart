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
    padding: const EdgeInsets.only(right: 8.0),
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
                image: AssetImage(path),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("rating"),
            Text("Name book"),
            Text("Author"),
          ],
        )
      ],
    ),
  );
}

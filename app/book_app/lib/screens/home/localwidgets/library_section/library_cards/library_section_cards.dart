import 'package:flutter/material.dart';

import '../../../../../widgets/widgets.dart';
import '../../../../book_details_clicked/book_details_clicked.dart';

class BookCardSection extends StatefulWidget {
  final List<dynamic> books;

  const BookCardSection({
    required this.books,
    Key? key,
  }) : super(key: key);

  @override
  State<BookCardSection> createState() => _BookCardSectionState();
}

class _BookCardSectionState extends State<BookCardSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final book in widget.books)
            buildBookCardSection(
              context: context,
              author: book.author,
              thumbnail: book.thumbnail,
              title: book.title,
              id: book.id,
            ),
        ],
      ),
    );
  }
}

Widget buildBookCardSection(
    {required String thumbnail,
    required String title,
    required List<String> author,
    required String id,
    required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        GestureDetector(
          onTap: () {
            nextScreen(
                context,
                BookDetailsClicked(
                  bookId: id,
                ));
          },
          child: Card(
            elevation: 10,
            child: Container(
              height: 180,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(thumbnail),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 160,
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
                Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    author.join(', ')),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

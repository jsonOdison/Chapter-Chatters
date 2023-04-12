import 'package:flutter/material.dart';

import 'book_cards/book_cards.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        const BookCard(),
      ],
    );
  }
}

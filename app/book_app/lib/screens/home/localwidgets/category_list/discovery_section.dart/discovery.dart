import 'package:book_app/screens/home/localwidgets/category_list/discovery_section.dart/book_cards.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiscoverCategory extends StatefulWidget {
  const DiscoverCategory({super.key});

  @override
  State<DiscoverCategory> createState() => _DiscoverCategoryState();
}

class _DiscoverCategoryState extends State<DiscoverCategory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Discover",
          style: GoogleFonts.newsreader(color: Colors.white, fontSize: 25),
        ),
        const SizedBox(
          height: 15,
        ),
        const BookCard(),
      ],
    );
  }
}

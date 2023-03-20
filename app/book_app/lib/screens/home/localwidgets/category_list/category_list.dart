import 'package:book_app/screens/home/localwidgets/category_list/discovery_section.dart/discovery.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding for the parent widget
      padding: const EdgeInsets.all(20),
      child: Column(
        children: const [
          // Row(
          //   //padding for the title section widget
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "Category",
          //       style: GoogleFonts.newsreader(
          //           color: Colors.redAccent, fontSize: 25),
          //     ),
          //     Text("See more",
          //         style: GoogleFonts.poppins(color: Colors.white, fontSize: 15))
          //   ],
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // const Tabs(),

          DiscoverCategory(),
        ],
      ),
    );
  }
}

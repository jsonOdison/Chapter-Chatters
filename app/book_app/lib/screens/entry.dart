import 'package:book_app/screens/categories/categories_page.dart';
import 'package:book_app/screens/library/library.dart';
import 'package:book_app/screens/search_book/search_book.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'group/root_group.dart';
import 'home/home.dart';

class Entry extends StatefulWidget {
  const Entry({Key? key}) : super(key: key);

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    CategoryScreen(),
    const SearchBook(),
    const GroupMainPage(),
    const Library(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.06,
            vertical: MediaQuery.of(context).size.height * 0.01,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: GNav(
              gap: 6,
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
              tabBackgroundColor: Theme.of(context).primaryColor,
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                if (kDebugMode) {
                  print(index);
                }
              },
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                  iconActiveColor: Colors.white,
                  textColor: Colors.white,
                ),
                GButton(
                  icon: Icons.explore,
                  text: "Categories",
                  iconActiveColor: Colors.white,
                  textColor: Colors.white,
                ),
                GButton(
                  icon: Icons.search,
                  text: "Search Books",
                  iconActiveColor: Colors.white,
                  textColor: Colors.white,
                ),
                GButton(
                  icon: Icons.group,
                  text: "Groups",
                  iconActiveColor: Colors.white,
                  textColor: Colors.white,
                ),
                GButton(
                  icon: Icons.library_books,
                  text: "Library",
                  iconActiveColor: Colors.white,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

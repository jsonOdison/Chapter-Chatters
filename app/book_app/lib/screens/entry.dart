import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'Profile/profile.dart';
import 'group/group.dart';
import 'home/home.dart';
import 'library.dart/library.dart';

class Entry extends StatefulWidget {
  const Entry({Key? key}) : super(key: key);

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const Library(),
    const InGroup(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff292731),
        leading: const IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: null,
        ),
        title: Text(
          "H E L L O",
          style: GoogleFonts.newsreader(color: Colors.white, fontSize: 20),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: GNav(
            gap: 8,
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(15),
            tabBackgroundColor: const Color(0xffFF6C6C),
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
              ),
              GButton(
                icon: Icons.library_books,
                text: "Library",
              ),
              GButton(icon: Icons.group, text: "Groups"),
              GButton(icon: Icons.account_circle, text: "Profile"),
            ],
          ),
        ),
      ),
    );
  }
}

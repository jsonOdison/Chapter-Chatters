import 'package:book_app/helper/user_helper.dart';
import 'package:book_app/screens/login/login.dart';
import 'package:book_app/services/authentication/auth_services.dart';
import 'package:book_app/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'Profile/profile.dart';
import 'group/root_group.dart';
import 'home/home.dart';
import 'search_book/search_book.dart';

class Entry extends StatefulWidget {
  const Entry({Key? key}) : super(key: key);

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  String userName = "";
  String email = "";
  AuthService authService = AuthService();
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchBook(),
    const GroupMainPage(),
    const Profile(),
  ];
  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  gettingUserData() async {
    await HelperFunction.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunction.getUserNameFromSF().then((val) {
      setState(() {
        userName = val!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(19),
          children: [
            const Icon(
              Icons.account_circle,
              size: 150,
              color: Color.fromRGBO(66, 70, 68, 1),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 99, 97, 97),
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 99, 97, 97),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Divider(
                    height: 4,
                    color: Colors.black,
                  ),
                  ListTile(
                    onTap: () {},
                    selectedColor: Theme.of(context).primaryColor,
                    selected: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    leading: const Icon(Icons.group),
                    title: const Text(
                      "Groups",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      nextScreenReplacement(context, const Profile());
                    },
                    selectedColor: const Color.fromARGB(255, 108, 155, 129),
                    selected: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    leading: const Icon(Icons.person_3_rounded),
                    title: const Text(
                      "Profile",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Logout"),
                              content: const Text(
                                  "Are you sure you want to logout ?"),
                              actions: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await authService.signOut();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()),
                                        (route) => false);
                                  },
                                  icon: const Icon(Icons.done,
                                      color: Colors.green),
                                ),
                              ],
                            );
                          });
                    },
                    selectedColor: Colors.blueGrey,
                    selected: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    leading: const Icon(Icons.logout),
                    title: const Text(
                      "Logout",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    // Do something
                  },
                ),
              ),
              const CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage("assets/icons/avatar_profile.png")),
            ],
            // Add padding to the entire app bar
          ),
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
                icon: Icons.account_circle,
                text: "Profile",
                iconActiveColor: Colors.white,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

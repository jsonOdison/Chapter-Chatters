import 'package:flutter/material.dart';

import '../../helper/user_helper.dart';
import '../../services/authentication/auth_services.dart';
import '../../widgets/widgets.dart';
import '../Profile/profile.dart';
import '../group/root_group.dart';
import '../login/login.dart';
import 'localwidgets/discover_section/discovery_section.dart';
import 'localwidgets/library_section/library_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';
  String email = "";
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  String getFirstName(String res) {
    res = res.substring(0, res.indexOf(" "));
    return res.substring(0, 1).toUpperCase() + res.substring(1);
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
        firstName = getFirstName(userName);
      });
    });
  }

  String firstName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color(0xffFEF8F0),
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
                    onTap: () {
                      nextScreen(context, const GroupMainPage());
                    },
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
                      nextScreen(context, const Profile());
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
                                            builder: (BuildContext context) =>
                                                const LoginScreen()),
                                        (Route<dynamic> route) => false);
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
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hello, $firstName !",
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(
                    height: 20,
                  ),

                  const SizedBox(
                    height: 40,
                  ),
                  //Library seciton
                  const LibrarySection(),
                  const SizedBox(
                    height: 50,
                  ),

                  //category seciton
                  const DiscoverySection(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:book_app/screens/root/root.dart';
import 'package:book_app/states/current_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blueAccent,
        title: const Text('Home'),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            // Navigate to home screen
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to account screen
            },
          ),
        ],
      ),
      body: Container(
        // Your app content goes here
        child: ElevatedButton(
            onPressed: () async {
              CurrentUser currentUser =
                  Provider.of<CurrentUser>(context, listen: false);
              String returnString = await currentUser.SingOut();
              if (returnString == 'success') {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MyRoot()),
                    (route) => false);
              }
            },
            child: const Text("data")),
      ),
    );
  }
}

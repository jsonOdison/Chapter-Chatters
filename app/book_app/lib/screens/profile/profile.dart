import 'package:book_app/services/authentication/auth_services.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                "Profile",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: const Icon(Icons.notifications),
                    color: Colors.black,
                    onPressed: () {
                      // Do something
                    },
                  ),
                ),
                const CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      AssetImage("assets/icons/avatar_profile.png"),
                ),
              ],
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // CustomCard(),
          ],
        ),
      ),
    );
  }
}

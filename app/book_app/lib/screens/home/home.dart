import 'package:book_app/screens/root/root.dart';
import 'package:book_app/states/current_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home '),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            CurrentUser currentUser =
                Provider.of<CurrentUser>(context, listen: false);
            String returnString = await currentUser.SingOut();
            if (returnString == 'success') {
              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MyRoot()),
                  (route) => false);
            }
          },
          child: const Text("Sign out"),
        ),
      ),
    );
  }
}

import 'package:book_app/screens/login/localwidgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    "assets/icons/avatarforbackground.svg",
                    height: 250,
                    width: 250,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const LoginForm(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

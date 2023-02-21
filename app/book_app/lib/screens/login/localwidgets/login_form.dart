import 'package:book_app/widgets/container.dart';
import 'package:flutter/material.dart';

import '../../signup/signup.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
            child:
                Text('Log In', style: Theme.of(context).textTheme.titleLarge),
          ),
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.alternate_email), hintText: 'Email'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock_outline), hintText: 'password'),
            obscureText: true,
          ),
          const SizedBox(
            height: 20,
          ),
          const ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Color(0xfff1e6ff),
              ),
            ),
            onPressed: null,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                "LOG IN",
                style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 66, 66, 65),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SignUpScreen(),
                ),
              );
            },
            child: const Text("Don't have an account ? Sign up here "),
          )
        ],
      ),
    );
  }
}

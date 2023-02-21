import 'package:book_app/widgets/container.dart';
import 'package:flutter/material.dart';

import '../../login/login.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
            child:
                Text('SIGN UP', style: Theme.of(context).textTheme.titleLarge),
          ),
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_2_outlined),
                hintText: 'Full Name'),
          ),
          const SizedBox(
            height: 20,
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
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock_open),
                hintText: 'confirm password'),
            obscureText: true,
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            child: const Text("Alredy have an account ? Log in here "),
          )
        ],
      ),
    );
  }
}

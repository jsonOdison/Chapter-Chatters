import 'package:book_app/states/current_user.dart';
import 'package:book_app/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../login/login.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _signUpUser(String email, String password, BuildContext context) async {
    CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);
    try {
      String returString =
          await currentUser.signUpUserWithEmail(email, password);
      if (returString == 'success') {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(returString),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

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
            controller: _fullNameController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_2_outlined),
                hintText: 'Full Name'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.alternate_email), hintText: 'Email'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock_outline), hintText: 'password'),
            obscureText: true,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _confirmPasswordController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock_open),
                hintText: 'confirm password'),
            obscureText: true,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Color(0xfff1e6ff),
              ),
            ),
            onPressed: () {
              if (_passwordController.text == _confirmPasswordController.text) {
                _signUpUser(
                    _emailController.text, _passwordController.text, context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Passwords do not match'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                "SIGN UP",
                style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 66, 66, 65),
                    fontWeight: FontWeight.bold),
              ),
            ),
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

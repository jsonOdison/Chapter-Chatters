import 'package:book_app/screens/home/home.dart';
import 'package:book_app/states/current_user.dart';
import 'package:book_app/widgets/container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/signin_google.dart';
import '../../signup/signup.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late String _returnString;
  void _loginUser(
      {required String type,
      required String email,
      required String password,
      required BuildContext context}) async {
    CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);
    try {
      switch (type) {
        case 'email':
          _returnString = await currentUser.loginUserWithEmail(email, password);
          break;
        case 'google':
          _returnString = await currentUser.loginUserWithGoogle();
          break;
        default:
      }

      if (_returnString == 'success') {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_returnString),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
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
                Text('Log In', style: Theme.of(context).textTheme.titleLarge),
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
          ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Color(0xfff1e6ff),
              ),
            ),
            onPressed: () {
              _loginUser(
                  type: "email",
                  email: _emailController.text,
                  password: _passwordController.text,
                  context: context);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                "LOG IN",
                style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 66, 66, 65),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 15),
          GoogleButton(
            onPressed: () {
              _loginUser(
                  type: "google",
                  email: _emailController.text,
                  password: _passwordController.text,
                  context: context);
            },
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
          ),
        ],
      ),
    );
  }
}

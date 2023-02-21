import 'package:book_app/screens/login/login.dart';
import 'package:book_app/utils/main_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BookApp());
}

class BookApp extends StatelessWidget {
  const BookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'welcome screen',
      theme: MainTheme().buildTheme(),
      home: const LoginScreen(),
    );
  }
}

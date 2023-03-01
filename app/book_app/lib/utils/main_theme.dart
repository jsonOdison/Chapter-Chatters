import 'package:flutter/material.dart';

class MainTheme {
  final Color _purple = const Color(0xffA379CD);
  final Color _lightPurple = const Color(0xfff1e6ff);
  final Color _darkerGrey = const Color.fromARGB(255, 74, 73, 73);
  final Color _colorTextTitle = const Color.fromARGB(255, 104, 104, 104);

  ThemeData buildTheme() {
    return ThemeData(
      canvasColor: _purple,
      primaryColor: _purple,
      hintColor: _darkerGrey,
      //Text
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 72.0,
          fontWeight: FontWeight.bold,
          color: _darkerGrey,
        ),
        titleLarge: TextStyle(
            color: _colorTextTitle,
            fontSize: 25.0,
            fontWeight: FontWeight.bold),
        bodyMedium: const TextStyle(fontSize: 14.0),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: _lightPurple),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: _purple),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: _lightPurple,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        minWidth: 200,
        height: 40,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MainTheme {
  final Color _canvasColor = const Color(0xff292731);
  final Color _cardColor = const Color(0xffFAF5E8);
  final Color _darkBrown = const Color(0xff7C7461);
  final Color _darkerGrey = const Color.fromARGB(255, 74, 73, 73);
  final Color _colorTextTitle = const Color(0xff43434F);

  ThemeData buildTheme() {
    return ThemeData(
      fontFamily: 'Newsreader',
      canvasColor: _canvasColor,
      primaryColor: _cardColor,
      hintColor: _darkerGrey,
      //Text
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 20,
          backgroundColor: _colorTextTitle,
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
          borderSide: BorderSide(color: _darkBrown),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: _canvasColor),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: _darkBrown,
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

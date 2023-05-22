import 'package:flutter/material.dart';

class MainTheme {
  final Color _canvasColor = const Color.fromARGB(255, 255, 255, 255);
  final Color _primaryColor = const Color(0xff7891e1);
  final Color _darkBrown = const Color(0xff7C7461);
  final Color _colorTextTitle = const Color(0xff43434F);

  ThemeData buildTheme() {
    return ThemeData(
      fontFamily: 'Karla',
      scaffoldBackgroundColor: const Color(0xffFEF8F0),
      primaryColor: _primaryColor,
      // app bar theme
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 28),
        color: Color(0xffFEF8F0),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      //Text
      textTheme: TextTheme(
        displayLarge: const TextStyle(
          fontFamily: 'Karla',
          fontSize: 60,
          fontWeight: FontWeight.w700,
          color: Color.fromARGB(255, 94, 92, 92),
        ),
        displayMedium: const TextStyle(
          fontFamily: 'Newsreader',
          fontSize: 30,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 94, 92, 92),
        ),
        titleLarge: TextStyle(
            fontFamily: 'Rubik',
            color: _colorTextTitle,
            fontSize: 35.0,
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
        padding: const EdgeInsets.symmetric(horizontal: 50),
        minWidth: 200,
        height: 40,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

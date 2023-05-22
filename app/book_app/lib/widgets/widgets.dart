import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  filled: true,
  fillColor: Color.fromARGB(255, 234, 234, 234),
  labelStyle: TextStyle(
    color: Color.fromARGB(255, 90, 89, 89),
    fontWeight: FontWeight.w200,
  ),
  focusedBorder: InputBorder.none,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide.none,
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Color.fromARGB(255, 231, 25, 77), width: 2),
  ),
);

//navigator stuff here

void nextScreen(context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

void nextScreenReplacement(context, page) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

void nextScreenAsyncReplacement(BuildContext context, screen) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (BuildContext context) => screen()),
    (Route<dynamic> route) => false,
  );
}

void showSnackBar(context, message, color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 14),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: "ok",
        onPressed: () {},
        textColor: Colors.white,
      ),
    ),
  );
}

//genres
final List<String> keywords = [
  "Action and Adventure",
  "Classic",
  "Comic and Graphic Novel",
  "Crime and Detective",
  "Drama",
  "Fairy Tale",
  "Fantasy",
  "Historical",
  "Horror",
  "Humor",
  "Mystery",
  "Mythology",
  "Manga",
  "Science Fiction",
  "Short Story",
  "Suspense/Thriller",
  "Biography/Autobiography",
  "Self-Help Book",
];

final List<Color> categoryColors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.purple,
  Colors.orange,
  Colors.teal,
  Colors.brown,
  Colors.grey,
  Colors.indigo,
  Colors.pink,
  Colors.amber,
  Colors.lime,
  Colors.cyan,
  Colors.deepPurple,
  Colors.deepOrange,
  Colors.lightBlue,
  Colors.lightGreen,
];

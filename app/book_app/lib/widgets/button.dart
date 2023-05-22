import 'package:flutter/material.dart';

buildButton(String message, VoidCallback press, BuildContext context) {
  return SizedBox(
    height: 50,
    width: 130,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        foregroundColor:
            MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
        textStyle:
            MaterialStateProperty.all<TextStyle>(const TextStyle(fontSize: 16)),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.blue),
          ),
        ),
      ),
      onPressed: press,
      child: Text(message),
    ),
  );
}

import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    labelStyle: TextStyle(
      color: Colors.black,
    ),
    focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Color.fromARGB(255, 70, 153, 216), width: 2)),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent, width: 2)));

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void showSnackBar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: TextStyle(fontSize: 14),
    ),
    backgroundColor: color,
    duration: Duration(seconds: 2),
    action: SnackBarAction(
      label: "OK",
      onPressed: () {},
      textColor: Colors.white,
    ),
  ));
}

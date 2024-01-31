import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(String labelText) {
  return InputDecoration(
    labelText: labelText,
    border: OutlineInputBorder(
      borderSide:
          BorderSide(color: Colors.red), // Set your desired border color
    ),
    labelStyle: TextStyle(color: Colors.grey),
    enabledBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: Colors.white), // Set your desired border color
    ),
    filled: true,
    fillColor: Color.fromARGB(132, 60, 75, 104),
    contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 8),
  );
}

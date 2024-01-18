import 'package:flutter/material.dart';

class CustomInputDecorations {
  static InputDecoration dynamicInputDecoration({
    required String labelText,
    required Color labelColor,
    required Color cursorColor,
    required Color enabledBorderColor,
  }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: labelColor),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: enabledBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: enabledBorderColor),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 8),
    );
  }

  static Widget buildTextField({
    required String labelText,
    Color labelColor = const Color.fromARGB(255, 156, 146, 146),
    Color cursorColor = const Color.fromARGB(255, 156, 146, 146),
    Color enabledBorderColor = const Color.fromARGB(255, 156, 146, 146),
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        cursorColor: cursorColor,
        style: TextStyle(color: const Color.fromARGB(255, 156, 146, 146)),
        decoration: dynamicInputDecoration(
          labelText: labelText,
          labelColor: labelColor,
          enabledBorderColor: enabledBorderColor,
          cursorColor: cursorColor,
        ),
      ),
    );
  }
}

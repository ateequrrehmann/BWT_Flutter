

import 'package:flutter/material.dart';

TextFormField reusableTextFormField(String text, IconData icon, TextEditingController controller, bool check){
  return TextFormField(
    controller: controller,
    obscureText: false,
    enableSuggestions: false,
    autocorrect: false,
    cursorColor: Colors.black,

    validator: check?(value) {
      if (value == null || value.isEmpty) {
        return "$text can't be empty";
      } else {
        return null;
      }
    }:(value){
      if (value == null || value.isEmpty) {
        return "$text can't be empty";
      } else if (text.toLowerCase() == 'email' && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
        return "Enter a valid email address";
      } else {
        return null;
      }
    },
    style: TextStyle(
      color: Colors.black.withOpacity(0.9),
    ),
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
        suffixIcon: Icon(icon),
        labelText: "Enter your $text",
        labelStyle: TextStyle(
          color: Colors.black.withOpacity(0.9),
        ),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Color(0xFFFFFFFF),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
                width: 0, style: BorderStyle.none))),
  );
}
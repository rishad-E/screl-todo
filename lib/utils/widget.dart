import 'package:flutter/material.dart';

decoration() {
  return InputDecoration(
    // labelText: 'Edit Ta,
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 3, color: Color.fromARGB(255, 150, 200, 240)),
      borderRadius: BorderRadius.circular(15),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 3, color: Colors.red),
      borderRadius: BorderRadius.circular(15),
    ),
  );
}

import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      useMaterial3: false,
      primarySwatch: Colors.orange,
      scaffoldBackgroundColor: Colors.grey[200],
      fontFamily: "Montserrat Regular",
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)))));
}

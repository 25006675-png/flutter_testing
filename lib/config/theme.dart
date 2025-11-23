import 'package:flutter/material.dart';

class AppTheme {
  // 1. Define your specific colors here
  static const Color primaryColor = Color(0xFF6200EE);
  static const Color accentColor = Color(0xFF03DAC6);
  static const Color backgroundColor = Color(0xFFF2F2F2);

  // 2. Define your text styles here
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );
  
  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    color: Colors.black54,
  );

  // 3. Create the main theme data (for Material widgets)
  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
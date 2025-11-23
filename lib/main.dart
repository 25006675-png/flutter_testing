import 'package:flutter/material.dart';
import 'navigation/bottom_nav.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Five Tabs App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomNav(), // Load the bottom navigation
    );
  }
}

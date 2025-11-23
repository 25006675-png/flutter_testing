import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/page1.dart';
import '../pages/page2.dart';
import '../pages/page3.dart';
import '../pages/page4.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key}); 
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    Page1(),
    Page2(),
    Page3(),
    Page4(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Needed for 4+ items
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.looks_one), label: "Page1"),
          BottomNavigationBarItem(icon: Icon(Icons.looks_two), label: "Page2"),
          BottomNavigationBarItem(icon: Icon(Icons.looks_3), label: "Page3"),
          BottomNavigationBarItem(icon: Icon(Icons.looks_4), label: "Page4"),
        ],
      ),
    );
  }
}

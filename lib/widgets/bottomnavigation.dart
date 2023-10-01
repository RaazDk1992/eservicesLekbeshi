// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class AppBottomNavBar extends StatelessWidget {
  final selectedIndex;
  ValueChanged<int> onClicked;
  AppBottomNavBar({required this.selectedIndex, required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.feed),
          label: 'Feed',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.bubble_chart_sharp),
          label: 'Bubbles',
        )
      ],
      currentIndex: selectedIndex, // the variable is undefined
      onTap: onClicked, // the function is undefined
      selectedItemColor: Colors.red[800],
      unselectedItemColor: Color.fromARGB(115, 85, 85, 85),
      showUnselectedLabels: false,
    );
  }
}

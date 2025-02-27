import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_max_rounded),
        label: "Home"
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.label_outline_rounded),
        label: "Categories"
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite_outline_rounded),
        label: "Favorite"
      ),
    ]);
  }
}

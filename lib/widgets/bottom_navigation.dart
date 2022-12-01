import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:money/screens/add_transaction.dart';
import 'package:money/screens/home_screen.dart';
import 'package:money/screens/statistic_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int? index;

  final screen = const [
    HomeScreen(),
    AddTransactionScreen(),
    StatisticScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: CurvedNavigationBar(
          color: Colors.deepPurple.shade600,
          backgroundColor: Colors.transparent,
          index: 1,
          height: 55,
          onTap: (value) {
            setState(() {
              index = value;
              if (index == 1) {
                Navigator.pushNamed(context, AddTransactionScreen.routeName);
              }
              if (index == 2) {
                Navigator.pushNamed(context, StatisticScreen.route_name);
              }
            });
          },
          items: const [
            Icon(Icons.home, color: Colors.white, size: 32),
            Icon(Icons.add, color: Colors.white, size: 32),
            Icon(Icons.category, color: Colors.white, size: 32),
          ]),
    );
  }
}

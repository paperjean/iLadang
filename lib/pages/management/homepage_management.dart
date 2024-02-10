import 'package:flutter/material.dart';
import 'package:sawitcare_app/pages/management/tree/tree_screen.dart';
import 'package:sawitcare_app/pages/activity/activity_screen.dart';
import 'package:sawitcare_app/pages/management/yield/yield_screen.dart';
import 'package:sawitcare_app/pages/management/employee/employee_screen.dart';
import 'package:sawitcare_app/pages/profile/profile_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final primaryColor = const Color(0xFF1E1E1E);
  final secondaryColor = const Color.fromRGBO(43, 128, 90, 1);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);
  int currentIndex = 2;

  final screen = [
    Tree(),
    Activity(),
    Yield(),
    Employee(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 110,
        child: BottomNavigationBar(
          //Item Selection
          type: BottomNavigationBarType.fixed,
          backgroundColor: secondaryColor,
          selectedItemColor: const Color.fromARGB(255, 182, 255, 185),
          unselectedItemColor: Colors.white,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          //Item List
          items: [
            BottomNavigationBarItem(
              label: "Employee",
              icon: Icon(Icons.people),
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              label: "Tree",
              icon: Icon(Icons.list_alt_rounded),
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              label: "Yield",
              icon: Icon(Icons.bar_chart_rounded),
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              label: "Employee",
              icon: Icon(Icons.people),
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(Icons.person),
              backgroundColor: primaryColor,
            ),
          ],
        ),
      ),
      body: Center(
        child: screen[currentIndex],
      ),
    );
  }
}

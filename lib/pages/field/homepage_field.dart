import 'package:flutter/material.dart';
import 'package:sawitcare_app/pages/field/menu/menu_screen.dart';
import 'package:sawitcare_app/pages/management/activity/activity_screen.dart';
import 'package:sawitcare_app/pages/management/yield/yield_screen.dart';
import 'package:sawitcare_app/pages/profile/profile_screen.dart';

class MyEmployeeHomePage extends StatefulWidget {
  const MyEmployeeHomePage({super.key});

  State<MyEmployeeHomePage> createState() => _MyEmployeeHomePageState();
}

class _MyEmployeeHomePageState extends State<MyEmployeeHomePage> {
  final primaryColor = const Color(0xFF1E1E1E);
  final secondaryColor = const Color.fromRGBO(99, 201, 142, 1);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);
  int currentIndex = 1;

  final screen = [
    Activity(),
    Menu(),
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
          backgroundColor: primaryColor,
          selectedItemColor: secondaryColor,
          unselectedItemColor: Colors.grey,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          //Item List
          items: [
            BottomNavigationBarItem(
              label: "Activities",
              icon: Icon(Icons.list_alt_rounded),
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              label: "Menu",
              icon: Icon(Icons.bar_chart_rounded),
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

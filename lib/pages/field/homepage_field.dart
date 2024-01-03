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
  final primaryColor = const Color.fromRGBO(248, 249, 250, 1);
  final secondaryColor = const Color.fromRGBO(43, 128, 90, 1);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);
  int currentIndex = 1;

  final screen = [
    const Activity(),
    const Menu(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 110,
        child: BottomNavigationBar(
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
              label: "Activities",
              icon: Icon(Icons.list_alt_rounded),
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              label: "Menu",
              icon: Icon(Icons.view_module),
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

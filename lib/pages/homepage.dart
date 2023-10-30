import 'package:flutter/material.dart';
import 'package:sawitcare_app/pages/employee/employee_screen.dart';
import 'package:sawitcare_app/pages/activity/activity_screen.dart';
import 'package:sawitcare_app/pages/yield/yield_screen.dart';
import 'package:sawitcare_app/pages/assets/assets_screen.dart';
import 'package:sawitcare_app/pages/market/market_screen.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final primaryColor = const Color(0xFF1E1E1E);
  final secondaryColor = const Color.fromRGBO(99, 201, 142, 1);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);
  int currentIndex = 2;

  final screen = [
    Employee(),
    Activity(),
    Yield(),
    Assets(),
    Market(),
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
              label: "Employee",
              icon: Icon(Icons.people),
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              label: "Activtiy",
              icon: Icon(Icons.list_alt_rounded),
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              label: "Yield",
              icon: Icon(Icons.bar_chart_rounded),
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              label: "Report",
              icon: Icon(Icons.analytics_rounded),
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

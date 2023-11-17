import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChooseRolePage extends StatefulWidget {
  const ChooseRolePage({super.key});

  @override
  State<ChooseRolePage> createState() => _ChooseRolePageState();
}

class _ChooseRolePageState extends State<ChooseRolePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Create the background image
        Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/rolebackground.jpg',
              ),
            ),
          ),
        ),
        Container(
          height: 500.0,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: FractionalOffset.bottomCenter,
                  end: FractionalOffset.topCenter,
                  colors: [
                Colors.black.withOpacity(0.0),
                Colors.black87.withOpacity(0.8)
              ],
                  stops: const [
                0.0,
                1.0
              ])),
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(247, 247, 247, 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
          ),
          margin: const EdgeInsets.only(top: 450.0),
          child: Column(
            children: [
              const Text(
                'Join as',
                style: TextStyle(
                    color: Colors.black, // Set the desired text color
                    fontSize: 25.0, // Set the desired font size
                    decoration: TextDecoration.none, // Remove underline
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 5.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: const Text(
                  'Welcome to SawitCare !\n  Pick your roles so we can help you get started',
                  style: TextStyle(
                      color: Colors.black, // Set the desired text color
                      fontSize: 14.0, // Set the desired font size
                      decoration: TextDecoration.none, // Remove underline
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16.0),
              OutlinedButton(
                onPressed: () {
                  // Handle button1 click
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                      color:
                          Color.fromRGBO(43, 128, 90, 1)), // Set border color
                  backgroundColor: const Color.fromRGBO(230, 252, 242, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fixedSize: const Size(300, 50),
                ),
                child: const Text(
                  'Plantation Owner',
                  style: TextStyle(
                      color: Color.fromRGBO(43, 128, 90, 1),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 5.0),
              TextButton(
                onPressed: () {
                  // Handle button2 click
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(43, 128, 90, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fixedSize: const Size(300, 50),
                ),
                child: const Text(
                  'Manager',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 5.0),
              TextButton(
                onPressed: () {
                  // Handle button3 click
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fixedSize: const Size(300, 50),
                ),
                child: const Text(
                  'Field Employee',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

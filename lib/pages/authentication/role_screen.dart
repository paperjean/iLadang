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
          color: Colors.white,
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 500.0),
          child: Column(
            children: [
              Text(
                'Choose Your Role',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  // Handle button1 click
                },
                child: Text(
                  'Role 1',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Handle button2 click
                },
                child: Text(
                  'Role 2',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Handle button3 click
                },
                child: Text(
                  'Role 3',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
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

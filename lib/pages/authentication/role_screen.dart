import 'package:flutter/material.dart';
import 'package:sawitcare_app/main.dart';
import 'package:sawitcare_app/pages/authentication/employee_registration.dart';
import 'package:sawitcare_app/pages/authentication/manager_registration.dart';
import 'package:sawitcare_app/pages/authentication/plantation_registration.dart';
import 'package:sawitcare_app/pages/authentication/start_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChooseRolePage extends StatefulWidget {
  const ChooseRolePage({super.key});

  @override
  State<ChooseRolePage> createState() => _ChooseRolePageState();
}

class _ChooseRolePageState extends State<ChooseRolePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                const SizedBox(
                  height: 16.0,
                ),
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
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: const Text(
                    'Welcome to SawitCare !\n  Pick your roles so we can help you get started',
                    style: TextStyle(
                        color: Colors.black, // Set the desired text color
                        fontSize: 14.0, // Set the desired font size
                        decoration: TextDecoration.none, // Remove underline
                        fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16.0),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const PlantationRegistration()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color.fromRGBO(43, 128, 90, 1),
                      width: 0.5,
                    ), // Set border color
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
                const SizedBox(height: 10.0),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const ManagerRegistration()),
                    );
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
                const SizedBox(height: 10.0),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const EmployeeRegistration()),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(45, 45, 45, 1),
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
          Positioned(
            top: 50.0,
            right: 30.0,
            child: FloatingActionButton(
              onPressed: () {
                _signOut();
              },
              child: Icon(Icons.logout_rounded, color: Colors.white),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut() async {
    try {
      await supabase.auth.signOut();
    } on AuthException catch (error) {
      SnackBar(
        content: Text(error.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch (error) {
      SnackBar(
        content: const Text('Unexpected error occurred'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } finally {
      if (mounted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const StartPage()));
      }
    }
  }
}

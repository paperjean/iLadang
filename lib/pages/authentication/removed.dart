import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sawitcare_app/main.dart';
import 'package:sawitcare_app/pages/authentication/start_page.dart';
import 'package:sawitcare_app/pages/management/homepage_management.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RemovedPage extends StatefulWidget {
  const RemovedPage({super.key});

  @override
  State<RemovedPage> createState() => _RemovedPageState();
}

class _RemovedPageState extends State<RemovedPage> {
  bool _cancelLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
            margin: const EdgeInsets.only(top: 500.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 16.0,
                ),
                const Text(
                  'You have been removed',
                  style: TextStyle(
                      color: Colors.black, // Set the desired text colorDWA
                      fontSize: 25.0, // Set the desired font size
                      decoration: TextDecoration.none, // Remove underline
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 5.0),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: const Text(
                    'You have been removed by the plantation. Please contact the plantation admin for more information.',
                    style: TextStyle(
                        color: Colors.black, // Set the desired text color
                        fontSize: 14.0, // Set the desired font size
                        decoration: TextDecoration.none, // Remove underline
                        fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Textfield
                const SizedBox(height: 10.0),
                TextButton(
                  onPressed: () async {
                    setState(() {
                      _cancelLoading = true;
                    });
                    try {
                      await supabase
                          .from('request')
                          .delete()
                          .eq('requester_id', supabase.auth.currentUser!.id);

                      await supabase.from('user_profile').update({
                        'role': null,
                      }).eq('id', supabase.auth.currentUser!.id.toString());

                      Navigator.of(context).pushReplacementNamed('/role');

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                              'You can make another new request now'),
                          backgroundColor: Colors.yellow[700],
                        ),
                      );
                    } catch (e) {
                      print(e);
                      SnackBar(
                        content: Text('Delete Request Failed'),
                        backgroundColor: Theme.of(context).colorScheme.error,
                      );
                    }

                    setState(() {
                      _cancelLoading = false;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color.fromRGBO(201, 53, 59, 1),
                      width: 0.5,
                    ), // Set border color
                    backgroundColor: const Color.fromRGBO(255, 248, 248, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fixedSize: const Size(300, 50),
                  ),
                  child: const Text(
                    'Back',
                    style: TextStyle(
                        color: Color.fromRGBO(201, 53, 59, 1),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700),
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

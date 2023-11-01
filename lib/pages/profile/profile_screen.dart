import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'constants.dart';
import 'package:sawitcare_app/utils/common.dart';
import 'package:sawitcare_app/pages/start_page.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: AppBar(
          elevation: 0,
          title: const Text(
            "Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Center(
        child: OutlinedButton(
          onPressed: () async {
            try {
              await client.auth.signOut();
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
                  MaterialPageRoute(builder: (context) => const StartPage()),
                );
              }
            }
          },
          child: const Text('Sign Out'),
        ),
      ),
    );
  }
}

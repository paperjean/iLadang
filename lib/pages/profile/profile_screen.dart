import 'package:flutter/material.dart';
import 'package:sawitcare_app/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sawitcare_app/pages/authentication/start_page.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: AppBar(
          elevation: 0,
          title: const Text(
            "Profile",
          ),
        ),
      ),
      body: Center(
        child: OutlinedButton(
          onPressed: _signOut,
          child: const Text('Sign Out'),
        ),
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

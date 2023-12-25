import 'package:flutter/material.dart';
import 'package:sawitcare_app/main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    if (!mounted) {
      return;
    }

    final session = supabase.auth.currentSession;
    if (session != null) {
      final roleResponse = await supabase
          .from('user_profile')
          .select()
          .eq('id', supabase.auth.currentUser!.id)
          .single();

      final userRole = roleResponse['role'];
      print(userRole);
      switch (userRole) {
        case 'owner':
          print('You have administrative privileges.');
          Navigator.of(context).pushReplacementNamed('/account');
          break;
        case 'manager':
          print('You have regular user privileges.');
          Navigator.of(context).pushReplacementNamed('/account');
          break;
        case 'pending_manager':
          print('You have guest privileges.');
          Navigator.of(context).pushReplacementNamed('/pending');
          break;
        case 'employee':
          print('You have regular user privileges.');
          Navigator.of(context).pushReplacementNamed('/employee');
          break;
        case 'pending_employee':
          print('You have guest privileges.');
          Navigator.of(context).pushReplacementNamed('/pending');
          break;
        default:
          Navigator.of(context)
              .pushReplacementNamed('/role'); // Handle invalid roles here
      }

      if ((userRole == null || userRole.isEmpty)) {
      } else {}
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

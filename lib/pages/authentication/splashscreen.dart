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
      final userRole = await supabase
          .from('user_profile')
          .select('role')
          .eq('id', supabase.auth.currentUser!.id)
          .limit(1);
      print(userRole);
      if ((userRole == null || userRole.isEmpty)) {
        Navigator.of(context).pushReplacementNamed('/role');    
      } else {
        Navigator.of(context).pushReplacementNamed('/account');
      }
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

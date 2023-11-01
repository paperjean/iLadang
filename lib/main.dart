import 'package:flutter/material.dart';
import 'package:sawitcare_app/pages/login.dart';
import 'package:sawitcare_app/pages/profile/profile_screen.dart';
import 'package:sawitcare_app/pages/start_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sawitcare_app/pages/homepage.dart';
import 'package:sawitcare_app/pages/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ssvarfvhyhkzchcawzci.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNzdmFyZnZoeWhremNoY2F3emNpIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTg1NzM5NzEsImV4cCI6MjAxNDE0OTk3MX0.okvg3vcjvy9FdkDR3NxvA1kY6T_veouxGy98en8s02U',
  );

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const SplashPage(),
        '/login': (_) => const StartPage(),
        '/account': (_) => const MyHomePage(),
      },
    );
  }
}

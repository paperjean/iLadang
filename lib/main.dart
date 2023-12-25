import 'package:flutter/material.dart';
import 'package:sawitcare_app/pages/authentication/pending_registration.dart';
import 'package:sawitcare_app/pages/authentication/start_page.dart';
import 'package:sawitcare_app/pages/field/homepage_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sawitcare_app/pages/management/homepage_management.dart';
import 'package:sawitcare_app/pages/authentication/splashscreen.dart';
import 'package:sawitcare_app/pages/authentication/role_screen.dart';

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
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color.fromRGBO(247, 247, 247, 1),
        primaryColor: const Color.fromRGBO(43, 128, 90, 1),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color.fromRGBO(43, 128, 90, 1),
            backgroundColor: const Color.fromRGBO(43, 128, 90, 1),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromRGBO(43, 128, 90, 1),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: Color.fromRGBO(43, 128, 90, 1)),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(43, 128, 90, 1)),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.2)),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color.fromRGBO(43, 128, 90, 1),
        ),
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const SplashPage(),
        '/pending': (_) => const PendingRegistration(),
        '/login': (_) => const StartPage(),
        '/account': (_) => const MyHomePage(),
        '/employee': (_) => const MyEmployeeHomePage(),
        '/role': (_) => const ChooseRolePage()
      },
    );
  }
}

// ignore_for_file: prefer_const_constructors
import 'package:call_app/screens/login.dart';
import 'package:call_app/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:call_app/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const Login(),
        '/register': (context) => Register(),
      },
      initialRoute: '/',
    );
  }
}

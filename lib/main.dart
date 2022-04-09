// ignore_for_file: prefer_const_constructors
import 'package:call_app/screens/login.dart';
import 'package:call_app/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:call_app/screens/welcome_screen.dart';

void main() {
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
        '/register': (context) => const Register(),
      },
      initialRoute: '/',
    );
  }
}

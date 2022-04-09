// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import "package:flutter/material.dart";

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(child: Text('Welcome to Register Screen'))));
  }
}

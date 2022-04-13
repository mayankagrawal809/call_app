// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Call app "),
        backgroundColor: Colors.grey,
      ),
      body: SafeArea(
          child: Column(
        children: [
          FloatingActionButton(
            child: const Icon(
              Icons.add,
              color: Colors.black87,
            ),
            onPressed: () {
              print("SDP created");
            },
            backgroundColor: Colors.grey,
          )
        ],
      )),
    );
  }
}

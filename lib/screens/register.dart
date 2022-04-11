// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import "package:flutter/material.dart";

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Text(
              "Register",
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: 320,
              height: 40,
              child: TextField(
                cursorColor: Colors.red,
                onChanged: (String) {},
                decoration: InputDecoration.collapsed(hintText: "enter email"),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: 320,
              height: 40,
              child: TextField(
                cursorColor: Colors.red,
                onChanged: (String) {},
                decoration:
                    InputDecoration.collapsed(hintText: "enter password"),
              ),
            ),
            TextButton(onPressed: () {}, child: Text("Register"))
          ],
        )));
  }
}

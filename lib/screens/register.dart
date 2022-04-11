// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatelessWidget {
  String emailID = '';
  String userPass = '';
  FirebaseAuth authInstance = FirebaseAuth.instance;
  Register({Key? key}) : super(key: key);

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
                onChanged: (value) {
                  emailID = value;
                },
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
                onChanged: (value) {
                  userPass = value;
                },
                decoration:
                    InputDecoration.collapsed(hintText: "enter password"),
              ),
            ),
            TextButton(
                onPressed: () async {
                  try {
                    await authInstance.createUserWithEmailAndPassword(
                        email: emailID, password: userPass);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text("Register"))
          ],
        )));
  }
}

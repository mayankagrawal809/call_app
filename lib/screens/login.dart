// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable, avoid_print
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatelessWidget {
  String emailID = '';
  String userPass = '';
  FirebaseAuth authInstance = FirebaseAuth.instance;
  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
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
                  decoration:
                      InputDecoration.collapsed(hintText: "Enter email"),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                width: 320,
                height: 40,
                child: TextField(
                  obscureText: true,
                  cursorColor: Colors.red,
                  onChanged: (value) {
                    userPass = value;
                  },
                  decoration:
                      InputDecoration.collapsed(hintText: "Enter password"),
                ),
              ),
              TextButton(
                  onPressed: () async {
                    try {
                      await authInstance.signInWithEmailAndPassword(
                          email: emailID, password: userPass);
                      Navigator.pushNamed(context, '/mainpage');
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
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.grey),
                  ))
            ],
          ),
        )));
  }
}

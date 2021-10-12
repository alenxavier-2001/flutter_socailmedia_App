import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/pages/home.dart';
import 'package:wallpaper/temp.dart';

Future SignIN_Function(
    String email, String password, BuildContext context) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .whenComplete(() => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage())));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No user found for that email.')));
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Wrong password provided for that user')));
    }
  }
}

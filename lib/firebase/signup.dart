import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/pages/sign/signin.dart';
import 'package:wallpaper/temp.dart';

Future SignUp_Function(
    String email, String password, BuildContext context) async {
  try {
    Map<String, dynamic> data = {"email": email, "password": password};
    Null userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(email)
          .collection(email)
          .add(data)
          .whenComplete(() => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomePage())));
    });
  } on FirebaseAuthException catch (e) {
    print("hdddddddddddddd");
    if (e.code == 'weak-password') {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('The password provided is too weak.')));
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('The account already exists for that email.')));
      print('The account already exists for that email.');
    }
  } catch (e) {
    print("eeeeeeerrrrrrrrrrrorrrrrrrr");
    print(e);
  }
}

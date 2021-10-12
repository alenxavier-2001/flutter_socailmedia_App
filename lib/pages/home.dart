import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/pages/firstpage.dart';
import 'package:wallpaper/pages/profileviewer.dart';
import 'package:wallpaper/styles/buttonstyles.dart';
import 'package:wallpaper/styles/textstyles.dart';
import 'package:wallpaper/temp.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    User? user = FirebaseAuth.instance.currentUser;
    String? mail = user!.email;
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
          ],
        ),
        body: Column(
          children: [
            Text(
              "user",
              style: TextStyle(fontSize: 25),
            ),
            Text(
              mail.toString(),
              style: TextStyle(fontSize: 25),
            ),
            ElevatedButton(
              style: EleButtonStyle(Colors.white),
              child: Text("Signout",
                  style: TextFontStyle(Colors.black, width / 23)),
              onPressed: () async {
                await FirebaseAuth.instance.signOut().whenComplete(() =>
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FirstPage())));
              },
            ),
          ],
        ));
  }
}

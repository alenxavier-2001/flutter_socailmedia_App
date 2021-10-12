import 'package:flutter/material.dart';

import 'package:wallpaper/pages/sign/signupcre.dart';
import 'package:wallpaper/styles/buttonstyles.dart';
import 'package:wallpaper/styles/textstyles.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Choose Your Ac",
              style: TextFontStyle(Theme.of(context).canvasColor, width / 21),
            ),
          ),
          SizedBox(
            height: height / 16,
          ),
          Center(
            child: SizedBox(
              height: height / 20,
              width: width / 2,
              child: ElevatedButton(
                  style: EleButtonStyle(Colors.blue),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Signup_Creator()));
                  },
                  child: Text(
                    "Creator",
                    style: TextFontStyle(Colors.white, width / 23),
                  )),
            ),
          ),
          SizedBox(
            height: height / 8,
          ),
          Center(
            child: SizedBox(
              width: width / 2,
              height: height / 20,
              child: ElevatedButton(
                  style: EleButtonStyle(Colors.blue),
                  onPressed: () {},
                  child: Text(
                    "Business",
                    style: TextFontStyle(Colors.white, width / 23),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

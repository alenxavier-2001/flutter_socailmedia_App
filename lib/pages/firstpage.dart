import 'package:flutter/material.dart';
import 'package:wallpaper/pages/sign/signin.dart';
import 'package:wallpaper/pages/sign/signup.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.tealAccent, Colors.blue.shade800])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height / 20,
                width: width / 3,
                child: ElevatedButton(
                  style: ButtonStyle(Colors.white),
                  child: Text("SignIn",
                      style: FontStyle(Colors.black, width / 23)),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignIn()));
                  },
                ),
              ),
              SizedBox(
                width: width / 8,
              ),
              SizedBox(
                width: width / 3,
                height: height / 20,
                child: ElevatedButton(
                  style: ButtonStyle(Colors.blue),
                  child: Text(
                    "SignUp",
                    style: FontStyle(Colors.white, width / 23),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: height / 7,
          )
        ],
      ),
    );
  }
}

ButtonStyle(Color color) {
  return ElevatedButton.styleFrom(primary: color, shape: StadiumBorder());
}

FontStyle(Color color, double fs) {
  return TextStyle(
    color: color,
    fontSize: fs,
  );
}

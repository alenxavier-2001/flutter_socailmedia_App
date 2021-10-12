import 'package:flutter/material.dart';
import 'package:wallpaper/firebase/signin.dart';
import 'package:wallpaper/firebase/signup.dart';
import 'package:wallpaper/styles/buttonstyles.dart';
import 'package:wallpaper/styles/textstyles.dart';

class Signup_Creator extends StatefulWidget {
  Signup_Creator({Key? key}) : super(key: key);

  @override
  State<Signup_Creator> createState() => _Signup_CreatorState();
}

class _Signup_CreatorState extends State<Signup_Creator> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String value = "";
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height / 6,
            ),
            Padding(
              padding: EdgeInsets.all(40),
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  // border: OutlineInputBorder(),
                  labelText: 'User Email',
                  hintText: 'Enter Your Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  //border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter Password',
                ),
              ),
            ),
            SizedBox(
              height: height / 6,
            ),
            Center(
              child: SizedBox(
                width: width / 2,
                height: height / 20,
                child: ElevatedButton(
                    style: EleButtonStyle(Colors.blue),
                    onPressed: () {
                      print(emailController.text.toString());
                      (emailController.text.isEmpty ||
                              passwordController.text.isEmpty)
                          ? ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Enter all the feild')))
                          : SignUp_Function(emailController.text.toString(),
                              passwordController.text.toString(), context);
                    },
                    child: Text(
                      "SignUp",
                      style: TextFontStyle(Colors.white, width / 23),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

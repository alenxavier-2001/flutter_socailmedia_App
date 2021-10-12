import 'package:flutter/material.dart';
import 'package:wallpaper/firebase/signin.dart';
import 'package:wallpaper/styles/buttonstyles.dart';
import 'package:wallpaper/styles/textstyles.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  // border: OutlineInputBorder(),
                  labelText: 'User Name',
                  hintText: 'Enter Your Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: TextField(
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
                          : SignIN_Function(emailController.text.toString(),
                              passwordController.text.toString(), context);
                    },
                    child: Text(
                      "SignIn",
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

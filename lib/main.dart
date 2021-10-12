import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/consts/theme_data.dart';
import 'package:wallpaper/functions/videopicker.dart';
import 'package:wallpaper/pages/class.dart';
import 'package:wallpaper/pages/home.dart';
import 'package:wallpaper/provider/dark_theme_provider.dart';
import 'package:wallpaper/pages/firstpage.dart';
import 'package:wallpaper/provider/followprovided.dart';
import 'package:wallpaper/temp.dart';
import 'package:wallpaper/videotemp.dart';

//  keytool -genkey -v -keystore C:\Users\HETNAIL-PC\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();

    FollowProvider();
  }

  void workFunctiomn() {
    FollowProvider();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => themeChangeProvider),
        ChangeNotifierProvider(create: (context) => FollowProvider())
      ],
      child: Consumer<DarkThemeProvider>(builder: (context, themedata, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: Styles.themeData(themeChangeProvider.darkTheme, context),
          //home: (user == null) ? FirstPage() : Home(),
          home: (user == null) ? FirstPage() : HomePage(),
          //home: VideoPicker(),
        );
      }),
      /* providers: [
          ChangeNotifierProvider(create: (_) {
            return themeChangeProvider;
          })
        ],
        child:
            Consumer<DarkThemeProvider>(builder: (context, themeData, child) {
          User? user = FirebaseAuth.instance.currentUser;
          return MaterialApp(
            title: 'Flutter Demo',
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            home: (user == null) ? FirstPage() : Home(),
          );
        })*/
    );
  }
}

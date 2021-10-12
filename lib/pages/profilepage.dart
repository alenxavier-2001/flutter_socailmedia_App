import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/pages/class.dart';
import 'package:wallpaper/provider/dark_theme_provider.dart';
import 'package:wallpaper/provider/followprovided.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String followerlen;
  late String folllowinglen;
  String? mail = FirebaseAuth.instance.currentUser!.email;
  List _followers = [];
  List _following = [];
  CollectionReference<Map<String, dynamic>> _firestore =
      FirebaseFirestore.instance.collection('users');

  _getfollowers() async {
    List itemList = [];

    try {
      CollectionReference reference =
          _firestore.doc(mail).collection('follower');

      await reference.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemList.add(element.data());
        });

        setState(() {
          _followers = itemList;
        });
        //_setlist();
      });
      print(_followers);
    } catch (e) {
      print("get error");

      return null;
    }
  }

  _getfollowing() async {
    List itemList = [];

    try {
      CollectionReference reference =
          _firestore.doc(mail).collection('following');

      await reference.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemList.add(element.data());
        });
        setState(() {
          _following = itemList;
        });

        //_setlist();
      });
      print(_following);
    } catch (e) {
      print("get error");

      return null;
    }
  }

  @override
  void initState() {
    _getfollowers();
    _getfollowing();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    String? email = FirebaseAuth.instance.currentUser!.email;

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text("User page"),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .where('uid', isEqualTo: email)
              .snapshots(),
          /*stream: FirebaseFirestore.instance
              .collection('users')
              .doc(mail)
              .collection('gallery')
              .snapshots(),*/
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            folllowinglen = _following.length.toString();
            followerlen = _followers.length.toString();
            print(_followers.length);
            print(_following.length);
            return !snapshot.hasData
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, index) {
                      return (index != 0)
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      //shadowColor: Colors.grey,
                                      elevation: 10,
                                      child: Image(
                                          image: NetworkImage(snapshot
                                              .data!.docs[index]['url']))),
                                  //color: Colors.red,
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Text("Dark Theme"),
                                Center(
                                  child: CupertinoSwitch(
                                      value: themeChange.darkTheme,
                                      onChanged: (value) {
                                        print(value);
                                        setState(() {
                                          themeChange.darkTheme = value;
                                        });
                                        // print(themeChange);
                                      }),
                                ),
                                Text(
                                  "email",
                                  style: TextStyle(fontSize: 25),
                                ),
                                Text(
                                  email.toString(),
                                  style: TextStyle(fontSize: 25),
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Text("Following     "),
                                          Text(_following.length.toString()),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text("Followers"),
                                          Text(_followers.length.toString()),
                                          // Text(_followers[index]['uid']),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            );
                    });
          },
        ));
  }
}

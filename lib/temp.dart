import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

// flutter build apk --release
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/addfile.dart';

import 'package:wallpaper/functions/imagepicker.dart';
import 'package:wallpaper/functions/like.dart';
import 'package:wallpaper/pages/profileviewer.dart';

import 'package:wallpaper/pages/profilepage.dart';
import 'package:wallpaper/videotemp.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final mail = FirebaseAuth.instance.currentUser!.email;

  CollectionReference<Map<String, dynamic>> likecol =
      FirebaseFirestore.instance.collection('likes');
  CollectionReference<Map<String, dynamic>> postscol =
      FirebaseFirestore.instance.collection('posts');

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final email = FirebaseAuth.instance.currentUser!.email;
    late File video;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              icon: Icon(Icons.people))
        ],
        title: Text('Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print("pressed");
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddFile()));
        },
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          return !snapshot.hasData
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, index) {
                    bool isliked = false;
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProfileViewer(
                                    mail: snapshot.data!.docs[index]['uid']
                                        .toString())));
                          },
                          child: Text(
                            snapshot.data!.docs[index]['uid'].toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onDoubleTap: () {
                              LikeFunction(
                                  context,
                                  email!,
                                  snapshot.data!.docs[index]['postid'],
                                  snapshot.data!.docs[index]['like']);
                            },
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              //shadowColor: Colors.grey,
                              elevation: 10,
                              child: (snapshot.data!.docs[index]['type'] ==
                                      true)
                                  ? VideoPlayerr(
                                      path: File('your initial file'),
                                      videoUrl: snapshot.data!.docs[index]
                                          ['url'],
                                      url: true)
                                  : Image(
                                      image: NetworkImage(
                                          snapshot.data!.docs[index]['url'])),
                              //color: Colors.red,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: width / 28,
                            ),
                            IconButton(
                                onPressed: () {
                                  LikeFunction(
                                      context,
                                      email!,
                                      snapshot.data!.docs[index]['postid'],
                                      snapshot.data!.docs[index]['like']);
                                },
                                icon: Icon(Icons.thumb_up)),
                            Text(snapshot.data!.docs[index]['like'].toString()),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.comment),
                            ),
                            Text("10"),
                            SizedBox(
                              width: width / 2.2,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.share),
                            ),
                          ],
                        )
                      ],
                    );
                  });
        },
      ),
    );
  }
}

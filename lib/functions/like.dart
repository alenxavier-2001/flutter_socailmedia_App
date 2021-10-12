import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

LikeFunction(
    BuildContext context, String usermail, String postid, int likecount) {
  print("get in function");
  DocumentReference<Map<String, dynamic>> likecol =
      FirebaseFirestore.instance.collection("likes").doc(usermail);
  DocumentReference<Map<String, dynamic>> postcol =
      FirebaseFirestore.instance.collection("posts").doc(postid);

  late bool exist;

  Future<DocumentSnapshot<Map<String, dynamic>>> docRef =
      FirebaseFirestore.instance.collection("likes").doc(usermail).get();

  try {
    print("gggggggggggujujujujujujujujujujujujk");
    docRef.then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        try {
          if (documentSnapshot.get(postid) == true) {
            postcol.update({'like': likecount - 1});
            likecol.update({postid: FieldValue.delete()});

            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('DisLiked')));
          } else if (documentSnapshot.get(postid) == false) {
            postcol.update({'like': likecount + 1});
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Liked')));
            likecol.update({postid: true});
          }
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Liked')));
          postcol.update({'like': likecount + 1});
          likecol.update({postid: true});
        }

        // print(documentSnapshot.get(postid));

      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Liked')));
        postcol.update({'like': likecount + 1});
        likecol.set({postid: true});
        print('Document does not exist on the database');
      }
    });
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
  }
  /*docRef.doc(usermail).get().then((doc) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('get in collection')));

    exist = doc.exists;
  }).whenComplete(() {
    if (exist == true) {
      likecol.update({postid: true});
      postcol.update({'like': likecount + 1});
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('update class')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('set class')));
      postcol.update({'like': likecount + 1});
      likecol.set({postid: true});
    }
  });*/
}

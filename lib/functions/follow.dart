import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/provider/userdetails_provider.dart';

FollowFunction(
  BuildContext context,
  String following,
  String follower,
) async {
  print(follower);
  CollectionReference<Map<String, dynamic>> col =
      FirebaseFirestore.instance.collection("users");
  DocumentReference<Map<String, dynamic>> followingcol =
      col.doc(following).collection("follower").doc(follower);

  DocumentReference<Map<String, dynamic>> followercol =
      col.doc(follower).collection("following").doc(following);
  final snapShot =
      await col.doc(follower).collection("following").doc(following).get();

  if (snapShot == null || !snapShot.exists) {
    followercol
        .set({'uid': following})
        .whenComplete(() => followingcol.set({'uid': follower}))
        .whenComplete(() => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Followed.'))));
  } else {
    followercol.delete().whenComplete(() => followingcol.delete()).whenComplete(
        () => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('UNFollowed.'))));
  }
}

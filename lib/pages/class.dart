import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Follow {
  String hello = "hello";
  String? mail = FirebaseAuth.instance.currentUser!.email;
  static List _followers = [];
  static List _following = [];
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

        _followers = itemList;
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

        _following = itemList;
        //_setlist();
      });
      print(_following);
    } catch (e) {
      print("get error");

      return null;
    }
  }
}

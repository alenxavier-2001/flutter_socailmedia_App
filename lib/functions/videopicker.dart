import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:wallpaper/videotemp.dart';

class VideoPicker extends StatefulWidget {
  const VideoPicker({Key? key}) : super(key: key);

  @override
  _VideoPickerState createState() => _VideoPickerState();
}

class _VideoPickerState extends State<VideoPicker> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String? usermail = FirebaseAuth.instance.currentUser!.email;
  bool uploading = false;
  double val = 0;
  late CollectionReference imgRef;
  late CollectionReference imgcom;
  late CollectionReference sot;
  late firebase_storage.Reference ref;
  String name = "upload";
  bool isTrue = false;

  final picker = ImagePicker();

  late File video;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Video'),
        actions: [
          FlatButton(
              onPressed: () {
                setState(() {
                  uploading = true;
                });
                uploadFile().whenComplete(() => Navigator.of(context).pop());
              },
              child: Text(
                'upload',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),

      ///
      ///

      body: Stack(
        children: [
          Column(
            children: [
              Text(name),
              isTrue
                  ? VideoPlayerr(
                      url: false,
                      path: video,
                      videoUrl: "",
                    )
                  : Container(),
              Container(
                child: IconButton(
                  onPressed: () {
                    chooseImage();
                  },
                  icon: Icon(Icons.add),
                ),
              ),
            ],
          ),
          uploading
              ? Center(
                  child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Text(
                        'uploading...',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CircularProgressIndicator(
                      value: val,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    )
                  ],
                ))
              : Container(),
        ],
      ),
    );
  }

  chooseImage() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    setState(() {
      video = File(pickedFile!.path);
      name = video.toString();
      isTrue = true;
    });
    if (pickedFile!.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        video = File(response.file!.path);
        name = video.toString();
        isTrue = true;
      });
    } else {
      print(response.file);
    }
  }

  Future uploadFile() async {
    String docid = "";
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('videos/${Path.basename(video.path)}');

    await ref.putFile(video).whenComplete(() async {
      await ref.getDownloadURL().then((value) {
        sot.add({
          'type': true,
          'url': value,
          'like': 0,
          'uid': usermail,
        }).then((value) {
          final doc = value.id;
          docid = value.id;
          print(value.id);
          sot.doc(docid).update({'postid': docid});
          imgRef.add({'imgid': doc});
        }).catchError((error) => print("Failed to add user: $error"));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    imgcom = FirebaseFirestore.instance.collection('common');
    imgRef = users.doc(usermail).collection('gallery');
    sot = FirebaseFirestore.instance.collection("posts");
  }
}

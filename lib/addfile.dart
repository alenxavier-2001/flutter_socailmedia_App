import 'package:flutter/material.dart';
import 'package:wallpaper/functions/imagepicker.dart';
import 'package:wallpaper/functions/videopicker.dart';

class AddFile extends StatelessWidget {
  const AddFile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddImage()));
            },
            child: Text("Image")),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => VideoPicker()));
            },
            child: Text("Video")),
      ],
    );
  }
}

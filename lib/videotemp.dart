import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wallpaper/videoplayerwidget.dart';

class VideoPlayerr extends StatefulWidget {
  File path;
  String videoUrl;
  bool url;

  VideoPlayerr(
      {Key? key, required this.path, required this.videoUrl, required this.url})
      : super(key: key);

  @override
  _VideoPlayerrState createState() => _VideoPlayerrState();
}

class _VideoPlayerrState extends State<VideoPlayerr> {
  //final asset = 'assets/video.mp4';
  final asset =
      'https://firebasestorage.googleapis.com/v0/b/wallpaper-7deef.appspot.com/o/NO%20TIME%20TO%20DIE%20-%20Range%20Rover%20Sport%20SVR.mp4?alt=media&token=124a9c84-7ed1-4366-9ae6-8deb31443fc0';
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.url
        ? VideoPlayerController.network(widget.videoUrl)
        : VideoPlayerController.file(widget.path)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((value) => _controller.play());
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller != null && _controller.value.isInitialized
        ? GestureDetector(
            onDoubleTap: () {
              setState(() {
                (_controller.value.volume == 0)
                    ? _controller.setVolume(1)
                    : _controller.setVolume(0);
              });
            },
            onTap: () {
              setState(() {
                print("set");
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: Container(
              alignment: Alignment.topCenter,
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  Positioned.fill(
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: buildIndicator(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
  }

  Widget buildIndicator() => VideoProgressIndicator(
        _controller,
        allowScrubbing: true,
      );
}

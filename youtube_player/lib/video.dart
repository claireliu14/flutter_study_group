import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyVideoPage extends StatefulWidget {
  final String videoId;

  MyVideoPage(this.videoId) {
    print(videoId);
  }

  @override
  _MyVideoPageState createState() => _MyVideoPageState();
}

class _MyVideoPageState extends State<MyVideoPage> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = YoutubePlayerController(
        initialVideoId: widget.videoId,
        flags: YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          forceHideAnnotation: true,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video'),
      ),
      body: Column(
        children: <Widget>[
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () {
              print('Player is ready');
            },
            bottomActions: <Widget>[
              ProgressBar(
                isExpanded: true,
              ),
              RemainingDuration(),
              FullScreenButton()
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () {
                  _controller.play();
                },
              ),
              IconButton(
                icon: Icon(Icons.pause),
                onPressed: () {
                  _controller.pause();
                },
              ),
              IconButton(
                icon: Icon(Icons.replay),
                onPressed: () {
                  _controller.seekTo(Duration(seconds: 0));
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

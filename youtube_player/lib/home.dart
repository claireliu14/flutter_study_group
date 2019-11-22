import 'package:flutter/material.dart';
import 'package:youtube_player/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'data.dart';

class MyHomePage extends StatelessWidget {
  List<String> videos = [...videoList];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 10),
          itemCount: videos.length,
          itemBuilder: (context, position) {
            return new GestureDetector(
                onTap: () {
                  String videoId = YoutubePlayer.convertUrlToId(videos[position]);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyVideoPage(videoId)));
                },
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    elevation: 5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        YoutubePlayer.getThumbnail(
                            quality: ThumbnailQuality.medium,
                            videoId:
                                YoutubePlayer.convertUrlToId(videos[position])),
                        fit: BoxFit.fill,
                      ),
                    )));
          }),
    );
  }
}

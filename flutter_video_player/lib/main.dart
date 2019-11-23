import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MyVideoPage());

class MyVideoPage extends StatefulWidget {
  @override
  _MyVideoPageState createState() => _MyVideoPageState();
}

class _MyVideoPageState extends State<MyVideoPage> {
  VideoPlayerController _controller;
  String positionTime = '00:00';
  String durationTime = '00:00';
  double sliderValue = 0;
  double sliderEndValue = 0;
  double volumeValue = 1.0;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
        'https://bestvpn.org/html5demos/assets/dizzy.mp4')
      ..initialize().then((_) {
        Duration duration = _controller.value.duration;
        durationTime = [duration.inMinutes, duration.inSeconds]
            .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
            .join(':');
        sliderEndValue = duration.inSeconds.toDouble();
        setState(() {});
      })
      ..addListener(() {
        Duration position = _controller.value.position;
        positionTime = [position.inMinutes, position.inSeconds]
            .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
            .join(':');
        sliderValue = position.inSeconds.toDouble();
        setState(() {});
      });

    // 上述兩個點是 Dart 的特殊語法，讓 _controller 可以接著定義
    // 原始敘述則如下：
    // _controller.initialize().then((value){});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('Video Demo')),

        //TODO: video Player
        body: Column(
          children: <Widget>[
            Center(
                child: _controller.value.initialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller))
                    : Container()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: <Widget>[
                  Text(positionTime),

                  // 使用 AnimatedCrossFade 來改變 Icon 的狀態
                  AnimatedCrossFade(
                    crossFadeState: _controller.value.isPlaying
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: Duration(milliseconds: 300),
                    firstChild: IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () {
                        if (_controller.value.position.inSeconds.toDouble() ==
                                sliderEndValue &&
                            !_controller.value.isPlaying) {
                          _controller.seekTo(Duration(seconds: 0));
                        }
                        _controller.play();
                      },
                    ),
                    secondChild: IconButton(
                      icon: Icon(Icons.pause),
                      onPressed: () {
                        _controller.pause();
                      },
                    ),
                  ),

                  Expanded(
                      child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 8.0,
                            trackShape: RectangularSliderTrackShape(),
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 0.0),
                          ),
                          child: Slider(
                            min: 0.0,
                            max: sliderEndValue,
                            value: sliderValue,
                            onChanged: (value) {
                              _controller
                                  .seekTo(Duration(seconds: value.round()));

                              // 避免 play/pause 和實際播放不同步
                              if (_controller.value.isPlaying) {
                                _controller.play();
                              } else {
                                _controller.pause();
                              }
                            },
                          ))),
                  Text(durationTime),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(volumeValue <= 0.0
                    ? Icons.volume_off
                    : volumeValue >= 1.0 ? Icons.volume_up : Icons.volume_down),
                Slider.adaptive(
                    inactiveColor: Colors.yellow,
                    activeColor: Colors.deepOrangeAccent,
                    divisions: 3,
                    max: 1.0,
                    min: 0.0,
                    value: volumeValue,
                    onChanged: (value) {
                      setState(() => volumeValue = value);
                      _controller.setVolume(value);
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}

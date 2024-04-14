import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_monitoring_diabetic_patients/utils/counter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Exercises extends StatefulWidget {
  const Exercises({super.key});

  @override
  State<Exercises> createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {
  YoutubePlayerController? _controller;

  Counter counter = Counter();
  int value = 0;
  bool _isStarted = false;
  late Timer _timer;

  void _startStop() {
    setState(() {
      _isStarted = !_isStarted;
      if (_isStarted) {
        _timer = Timer.periodic(
            const Duration(seconds: 1), (_) => setState(() {
              counter.incrementCounter();
              value = counter.value;
            })
        );
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: 'Ev6yE55kYGw',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
        isLive: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller!,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
        ),
        builder: (context, player) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Exercises'),
            ),
            body: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Walking',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 23),
                  ),
                  Divider(
                    thickness: 1,
                    indent: 10,
                    endIndent: 20,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Stack(
                    children: [
                      Center(
                        child: Container(
                          height: 200,
                          width: 200,
                          child: CircularProgressIndicator(
                            value: counter.value / 1000,
                            backgroundColor:
                                Colors.deepPurple.shade100.withOpacity(0.2),
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 50.0,
                        left: 125.0,
                        top: 50,
                        child: Column(
                          children: <Widget>[
                            Text(
                              '${value}',
                              style: TextStyle(fontSize: 40),
                            ),
                            Text(
                              'Steps taken:',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _startStop,
                        child: Text(_isStarted ? 'Stop' : 'Start'),
                      ),
                      ElevatedButton(
                        onPressed: (){
                          setState(() {
                            counter.restartCounter();
                            value = counter.value;
                          });
                        },
                        child: Text('restart'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Mild Exercises',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 23),
                  ),
                  Divider(
                    thickness: 1,
                    indent: 10,
                    endIndent: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  YoutubePlayer(controller: _controller!)
                ],
              ),
            ),
          );
        });
  }
}

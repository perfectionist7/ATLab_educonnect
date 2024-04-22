import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';

class MotionDetectionRhymes extends StatefulWidget {
  const MotionDetectionRhymes({Key? key}) : super(key: key);

  @override
  State<MotionDetectionRhymes> createState() => _MotionDetectionRhymesState();
}

class _MotionDetectionRhymesState extends State<MotionDetectionRhymes> {
  int x = 0, y = 0, z = 0;
  int w = 0;
  int k = 0;
  int circularx = 0;
  int circulary = 0;
  final player = AudioPlayer();

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Container(
                decoration: BoxDecoration(),
                child: ListView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      StreamBuilder<UserAccelerometerEvent>(
                          stream:
                              SensorsPlatform.instance.userAccelerometerEvents,
                          builder: (_, snapshot) {
                            if (snapshot.hasData) {
                              x = snapshot.data!.x.toInt().abs();
                              y = snapshot.data!.y.toInt().abs();
                              z = snapshot.data!.z.toInt().abs();
                              w = [x, y, z].reduce(max);
                              if (w == 0) {
                                print("Not accelarating");
                                k = 0;
                                circularx = 0;
                                circulary = 0;
                              } else if (circularx >= 2 && circulary >= 3) {
                                player.play(AssetSource('sounds/spectre.mp3'));
                              } else if (k >= 3) {
                                player.play(AssetSource('sounds/masakali.mp3'));
                              } else if (w == x) {
                                if (snapshot.data!.x.toInt() < 0) {
                                  //right
                                  k++;
                                  circularx++;
                                  player.play(AssetSource('sounds/sound1.mp3'));
                                } else {
                                  //left
                                  k++;
                                  circularx++;
                                  player.play(AssetSource('sounds/sound2.mp3'));
                                }
                              } else if (w == y) {
                                k = 0;
                                if (snapshot.data!.y.toInt() < 0) {
                                  //top
                                  player.play(AssetSource('sounds/sound3.mp3'));
                                } else {
                                  //bottom
                                  player.play(AssetSource('sounds/sound4.mp3'));
                                }
                              } else if (w == z) {
                                k = 0;
                                if (snapshot.data!.z.toInt() < 0) {
                                  //up
                                  circulary++;
                                  player.play(AssetSource('sounds/sound5.mp3'));
                                } else {
                                  //down
                                  circulary++;
                                  player.play(AssetSource('sounds/sound6.mp3'));
                                }
                              }
                            }

                            return Container(
                              margin: EdgeInsets.fromLTRB(
                                  0.15625 * screenWidth,
                                  0.3188775510204082 * screenHeight,
                                  0.15625 * screenWidth,
                                  0),
                              child: GestureDetector(
                                onDoubleTap: () {
                                  //doubletap
                                  player.stop();
                                },
                                child: FlutterLogo(
                                  size: 0.1913265306122449 * screenHeight,
                                  duration: Duration(seconds: 2),
                                ),
                              ),
                            );
                          }),
                    ]))));
  }
}

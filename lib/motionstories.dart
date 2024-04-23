import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'drawer_content.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

class MotionDetectionStories extends StatefulWidget {
  const MotionDetectionStories({Key? key}) : super(key: key);

  @override
  State<MotionDetectionStories> createState() => _MotionDetectionStoriesState();
}

class _MotionDetectionStoriesState extends State<MotionDetectionStories> {
  int x = 0, y = 0, z = 0;
  int w = 0;
  int k = 0;
  int circularx = 0;
  int circulary = 0;
  final player = AudioPlayer();
  int currentPlayingSound = 0;
  List<String> rhymeList = [
    "No rhyme", // 0
    "Spectre", // 1
    "Masakali", // 2
    "Rhyme 1", // 3
    "Rhyme 2", // 4
    "Rhyme 3", // 5
    "Rhyme 4", // 6
    "Rhyme 5", // 7
    "Rhyme 6", // 8
  ];
  List<String> directionList = [
    "Not Moving", // 0
    "Clockwise Spin", // 1 (Spectre)
    "Highest acceleration", // 2 (Masakali)
    "Right", // 3
    "Left", // 4
    "Forward", // 5
    "Back", // 6
    "Top", // 7
    "Down", // 8
  ];

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Subscribe to accelerometer events
    SensorsPlatform.instance.userAccelerometerEvents.listen((event) {
      _handleUserAccelerometerEvent(event);
    });
  }

  bool isDrawerOpen = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  void toggleDrawer() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
      if (isDrawerOpen) {
        _scaffoldKey.currentState?.openEndDrawer(); // Open the drawer
      } else {
        Navigator.of(context).pop(); // Close the drawer
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            backgroundColor: Color(0xffe6f0ff),
            elevation: 0,
            toolbarHeight: 70,
            leading: Container(
                margin: EdgeInsets.only(left: 20),
                child: IconButton(
                  icon: ImageIcon(
                    AssetImage(
                      'assets/burger_icon.png',
                    ),
                    size: 50,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _scaffoldKey.currentState?.openDrawer();
                    });
                  },
                ))),
        drawer: Container(
          width: 240,
          child: Drawer(
            child: DrawerContent(),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(),
          child: ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 100),
                    alignment: Alignment.center,
                    child: Text(
                      'Now Playing: ${rhymeList[currentPlayingSound]}',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff001F3F),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      0.15625 * screenWidth,
                      150,
                      0.15625 * screenWidth,
                      0,
                    ),
                    child: GestureDetector(
                      onDoubleTap: () {
                        player.stop();
                      },
                      child: Center(
                        child: Image.asset(
                          'assets/applogo.png',
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 425, left: 30, right: 30),
                    alignment: Alignment.center,
                    child: Text(
                      'Detected: ${directionList[currentPlayingSound]}',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff001F3F),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(
                    (40 / 411.42857142857144) * screenWidth, 125, 0, 0),
                padding: const EdgeInsets.all(1),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_rounded,
                      color: Color(0xff001F3F)),
                  iconSize: screenWidth * 0.08,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleUserAccelerometerEvent(UserAccelerometerEvent event) {
    setState(() {
      x = event.x.toInt().abs();
      y = event.y.toInt().abs();
      z = event.z.toInt().abs();
      w = [x, y, z].reduce(max);
      if (w == 0) {
        k = 0;
        circularx = 0;
        circulary = 0;
      } else if (w == x) {
        if (event.x.toInt() < 0) {
          k++;
          circularx++;
          player.play(AssetSource('sounds/sound1.mp3'));
          _updateCurrentPlayingSound(3);
        } else {
          k++;
          circularx++;
          player.play(AssetSource('sounds/sound2.mp3'));
          _updateCurrentPlayingSound(4);
        }
      } else if (w == y) {
        k = 0;
        if (event.y.toInt() < 0) {
          player.play(AssetSource('sounds/sound3.mp3'));
          _updateCurrentPlayingSound(5);
        } else {
          player.play(AssetSource('sounds/sound4.mp3'));
          _updateCurrentPlayingSound(6);
        }
      } else if (w == z) {
        k = 0;
        if (event.z.toInt() < 0) {
          circulary++;
          player.play(AssetSource('sounds/sound5.mp3'));
          _updateCurrentPlayingSound(7);
        } else {
          circulary++;
          player.play(AssetSource('sounds/sound6.mp3'));
          _updateCurrentPlayingSound(8);
        }
      }
    });
  }

  void _updateCurrentPlayingSound(int soundNumber) {
    if (currentPlayingSound != soundNumber) {
      setState(() {
        currentPlayingSound = soundNumber;
      });
    }
  }
}

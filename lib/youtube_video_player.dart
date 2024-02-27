import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'checkvideos.dart';
import 'drawer_content.dart';
import 'package:google_fonts/google_fonts.dart';

class YoutubePlayerExample extends StatefulWidget {
  const YoutubePlayerExample(
      {Key? key, required this.data, required this.link, required this.value})
      : super(key: key);

  @override
  State<YoutubePlayerExample> createState() => _YoutubePlayerExampleState();
  final String data;
  final String link;
  final bool value;
}

class _YoutubePlayerExampleState extends State<YoutubePlayerExample> {
  late YoutubePlayerController controller;
  late String videoUrl;
  late String videoId;
  double screenHeight = 0.0;
  double screenWidth = 0.0;
  bool isPlaying = false;
  int index = 0;
  bool isMotionEnabled = false;

  @override
  void initState() {
    super.initState();
    index = int.parse(widget.data);
    videoUrl = widget.link;
    isMotionEnabled = widget.value;
    // ignore: deprecated_member_use
    videoId = YoutubePlayer.convertUrlToId(videoUrl)!;
    controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: false));

    controller.addListener(() {
      setState(() {
        isPlaying = controller.value.isPlaying; // Update the play/pause state
      });
    });
    // controller.setLooping(true);
    // controller.initialize().then((_) => setState(() {}));
    //controller.play();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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

  Future togglePlaying() async {
    if (isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    Widget buildStart() {
      var icon = isPlaying
          ? SizedBox(child: Image.asset('assets/pause.png'))
          : SizedBox(
              child: Image.asset('assets/play.png'),
            );

      return IconButton(
          iconSize: (80 / 784) * screenHeight,
          color: Colors.black,
          onPressed: () async {
            await togglePlaying();
          },
          icon: icon);
    }

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor:
            Color(0xffe6f0ff), // Set the background color to transparent
        elevation: 0, // Remove the shadow from the AppBar
        toolbarHeight: (110 / 784) * screenHeight,
        actions: [
          Container(
            padding: EdgeInsets.only(
              right: (40 / 384) * screenWidth,
              left: (180 / 384) * screenWidth,
            ), // Add some margin here
            child: IconButton(
              icon: Image.asset('assets/burger_icon.png'),
              onPressed: () {
                setState(() {
                  _scaffoldKey.currentState?.openEndDrawer();
                });
              },
            ),
          ),
        ],
      ),
      endDrawer: SizedBox(
        width: (240 / 384) * screenWidth,
        child: Drawer(
          child: DrawerContent(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/onboarding.png"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: (40 / 784) * screenHeight),
                  height: (300 / 784) * screenHeight,
                  child: YoutubePlayer(
                    controller: controller,
                    showVideoProgressIndicator: true,
                    onReady: () => debugPrint("Ready"),
                    bottomActions: [
                      CurrentPosition(),
                      ProgressBar(
                        isExpanded: true,
                        colors: const ProgressBarColors(
                          playedColor: Colors.red,
                          handleColor: Colors.redAccent,
                        ),
                      ),
                      const PlaybackSpeedButton(),
                    ],
                  ),
                ),
                SizedBox(
                  height: (30 / 784) * screenHeight,
                ),
                Text(
                  VideoSourcesManager.videoSourcesData[index]['title'],
                  style: GoogleFonts.poppins(
                      fontSize: (22 / 784) * screenHeight,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                // Container(
                //     margin: EdgeInsets.only(top: (30 / 784) * screenHeight),
                //     height: (25 / 784) * screenHeight,
                //     child: Text(
                //       VideoSourcesManager.videoSourcesData[index]['title'],
                //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                //     )),
                Container(
                  margin: EdgeInsets.only(top: (10 / 784) * screenHeight),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (controller.value.isPlaying) {
                            controller.pause();
                          }
                          setState(() {
                            index = index - 1 < 0
                                ? VideoSourcesManager.videoSourcesData.length -
                                    1
                                : index - 1;
                            videoUrl = VideoSourcesManager
                                .videoSourcesData[index]['uri'];
                            videoId = YoutubePlayer.convertUrlToId(videoUrl)!;
                            controller.load(videoId);
                          });
                          //previous
                        },
                        iconSize: (60 / 784) * screenHeight,
                        color: const Color(0xff1C1B1F),
                        icon: SizedBox(
                            // height: (32 / 784) * screenHeight,
                            // width: (30 / 384) * screenWidth,
                            child: Image.asset('assets/back_buttonrhymes.png')),
                      ),
                      buildStart(),
                      IconButton(
                        onPressed: () {
                          //next video
                          if (controller.value.isPlaying) {
                            controller.pause();
                          }
                          setState(() {
                            index = index + 1 ==
                                    VideoSourcesManager.videoSourcesData.length
                                ? 0
                                : index + 1;
                            videoUrl = VideoSourcesManager
                                .videoSourcesData[index]['uri'];
                            videoId = YoutubePlayer.convertUrlToId(videoUrl)!;

                            controller.load(videoId);
                          });
                        },
                        iconSize: (60 / 784) * screenHeight,
                        color: Colors.black,
                        icon: SizedBox(
                            // height: (32 / 784) * screenHeight,
                            // width: (30 / 384) * screenWidth,
                            child:
                                Image.asset('assets/front_buttonrhymes.png')),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.only(
                      left: (20 / 384) * screenWidth,
                      top: screenHeight * 0.06,
                      bottom: screenHeight * 0.08),
                  padding: const EdgeInsets.all(1),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_rounded),
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
      ),
    );
  }
}

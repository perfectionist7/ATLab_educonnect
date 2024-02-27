import 'package:flutter/cupertino.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'youtube_video_player.dart';
import 'drawer_content.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'checkvideos.dart';

import 'package:firebase_auth/firebase_auth.dart';

class VideoList extends StatefulWidget {
  const VideoList({Key? key, required this.classid}) : super(key: key);
  final int classid;
  @override
  State<VideoList> createState() => _VideoListState();
}

final _auth = FirebaseAuth.instance;
double screenHeight = 0.0;
double screenWidth = 0.0;
bool isScreenLock = false;

class _VideoListState extends State<VideoList> {
  int newclassid = 0;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;
  getCurrentUser() async {}

  @override
  void initState() {
    newclassid = widget.classid;
    _initializeVideoPlayer();

    super.initState();
  }

  Future<void> _initializeVideoPlayer() async {
    setState(() {
      _isLoading = true; // Set loading to true when initializing
    });
    if (newclassid == 0) {
      await VideoSourcesManager.fetchDataFromSpreadsheet();
    } else if (newclassid == 1) {
      await VideoSourcesManager.fetchDataFromSpreadsheet1();
    } else if (newclassid == 2) {
      await VideoSourcesManager.fetchDataFromSpreadsheet2();
    } else if (newclassid == 3) {
      await VideoSourcesManager.fetchDataFromSpreadsheet3();
    } else {
      Fluttertoast.showToast(msg: "Error fetching data from spreadsheet");
    }

    // print(VideoSourcesManager.videoSourcesData);
    // print(VideoSourcesManager.videoSourcesData.length);
    setState(() {});
    setState(() {
      _isLoading = false; // Set loading to true when initializing
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

  bool isMotionEnabled = false;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
                backgroundColor: Color(0xffe6f0ff),
                toolbarHeight: (110 / 784) * screenHeight,
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
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/onboarding.png"),
                      fit: BoxFit.cover),
                ),
                child: _isLoading
                    ? Container(
                        alignment: Alignment.topCenter,
                        margin: const EdgeInsets.only(top: 240),
                        child: DefaultTextStyle(
                          style: GoogleFonts.poppins(
                            color: const Color(0xffF3940C),
                            fontWeight: FontWeight.w400,
                            fontSize: (20 / 784) * screenHeight,
                          ),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              WavyAnimatedText(
                                'Loading your video playlist...',
                                speed: const Duration(milliseconds: 150),
                              ),
                            ],

                            isRepeatingAnimation: true,
                            // onTap: () {
                            //   print("Tap Event");
                            // },
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(0.20625 * screenWidth,
                                0, 0.20625 * screenWidth, 0),
                            child: Text(
                              'choose from our DIY playlist',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: (24 / 784) * screenHeight,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(top: 30, left: 30),
                              height: (400 / 784) * screenHeight,
                              child: CupertinoScrollbar(
                                thickness: 4,
                                thumbVisibility: true,
                                controller: _scrollController,
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(
                                        parent:
                                            AlwaysScrollableScrollPhysics()),
                                    controller: _scrollController,
                                    itemCount: VideoSourcesManager
                                        .videoSourcesData.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            10, 10, 30, 20),
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.25),
                                                blurRadius: 4,
                                                offset: const Offset(0,
                                                    4), // changes position of shadow
                                              ),
                                            ],
                                            border: Border.all(
                                                color: const Color(0xff0A1621)),
                                            color: Colors.grey[400],
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15))),
                                        child: ListTile(
                                          leading: const Icon(
                                            Icons.video_collection_rounded,
                                            color: Color(0xff0A1621),
                                          ),
                                          title: Text(
                                            VideoSourcesManager
                                                    .videoSourcesData[index]
                                                ['title'],
                                            style: GoogleFonts.poppins(
                                                fontSize:
                                                    (16 / 784) * screenHeight,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) =>
                                                    YoutubePlayerExample(
                                                        value: isMotionEnabled,
                                                        data: VideoSourcesManager
                                                                .videoSourcesData[
                                                            index]['id'],
                                                        link: VideoSourcesManager
                                                                .videoSourcesData[
                                                            index]['uri'])));
                                          },
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.bottomLeft,
                                margin: EdgeInsets.fromLTRB(
                                  (30 / 384) * screenWidth,
                                  screenHeight * 0.04,
                                  0,
                                  screenHeight * 0.04,
                                ),
                                padding: const EdgeInsets.all(1),
                                child: IconButton(
                                  icon:
                                      const Icon(Icons.arrow_back_ios_rounded),
                                  iconSize: screenWidth * 0.08,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              // Text(
                              //   'Motion Detection',
                              //   style: TextStyle(
                              //       color: Colors.black, fontSize: 18),
                              // ),
                              // Container(
                              //   margin: EdgeInsets.fromLTRB(
                              //       (20 / 384) * screenWidth,
                              //       (50 / 784) * screenHeight,
                              //       screenWidth * 0.05,
                              //       0),
                              //   child: CupertinoSwitch(
                              //     value: isMotionEnabled,
                              //     onChanged: (value) async {
                              //       setState(() {
                              //         isMotionEnabled = true;
                              //       });
                              //     },
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ))));
  }
}

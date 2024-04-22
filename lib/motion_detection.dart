import 'package:educonnect/motionrhymes.dart';
import 'package:educonnect/motionstories.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'drawer_content.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'drawer_content.dart';
import 'main.dart';

// ignore: camel_case_types
class Motion_Detect_Descrp extends StatefulWidget {
  const Motion_Detect_Descrp({Key? key}) : super(key: key);

  @override
  State<Motion_Detect_Descrp> createState() => _Motion_Detect_DescrpState();
}

final _auth = FirebaseAuth.instance;
double screenHeight = 0.0;
double screenWidth = 0.0;

class _Motion_Detect_DescrpState extends State<Motion_Detect_Descrp> {
  bool showSpinner = false;
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
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

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
            body: ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0.15625 * screenWidth, 40, 0.15625 * screenWidth, 0),
                    child: Text(
                      'Pick one of the following options',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: (22 / 784) * screenHeight,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    margin: EdgeInsets.only(
                        top: (50 / 784) * screenHeight,
                        left: (10 / 384) * screenWidth,
                        right: (0 / 384) * screenWidth),
                    child: SizedBox(
                      height: (130 / 784) * screenHeight,
                      width: (250 / 384) * screenWidth,
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MotionDetectionRhymes()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/rhymes.png'), // Replace 'path_to_your_image.jpg' with the actual path to your image asset
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    margin: EdgeInsets.only(
                        top: (50 / 784) * screenHeight,
                        left: (10 / 384) * screenWidth,
                        right: (0 / 384) * screenWidth),
                    child: SizedBox(
                      height: (130 / 784) * screenHeight,
                      width: (250 / 384) * screenWidth,
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MotionDetectionStories()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/stories.png'), // Replace 'path_to_your_image.jpg' with the actual path to your image asset
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(
                        (40 / 411.42857142857144) * screenWidth, 120, 0, 0),
                    padding: const EdgeInsets.all(1),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Color(0xff001F3F),
                      ),
                      iconSize: screenWidth * 0.08,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            )));
  }
}

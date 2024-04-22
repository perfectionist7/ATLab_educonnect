import 'dart:io';
import 'package:educonnect/camera_view.dart';
import 'package:educonnect/checkclass.dart';
import 'package:educonnect/home_screen.dart';
import 'package:educonnect/landing.dart';
import 'package:educonnect/motion_detection.dart';
import 'package:educonnect/videolist.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'drawer_content.dart';
import 'package:educonnect/object_detector_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'motion_detection.dart';
import 'package:educonnect/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:educonnect/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _auth = FirebaseAuth.instance;
  String fullName = '';
  bool showSpinner = true;
  @override
  void initState() {
    super.initState();
    fetchFullName();
    showSpinner = false;

    // listening();
  }

  Future<void> fetchFullName() async {
    // Get current user's email
    String? email = _auth.currentUser?.email;
    if (email != null) {
      // Retrieve data from Firestore
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('newUsers')
          .doc(email)
          .get();

      // Check if the document exists
      if (userDoc.exists) {
        // Get the full name from the document
        setState(() {
          fullName = userDoc['fullname'];
        });
      } else {
        print('Document does not exist');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    // player2.dispose();
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
    // print(screenHeight);
    // print(screenWidth);

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
                child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/onboarding.png"),
                          fit: BoxFit.cover),
                    ),
                    child: ListView(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 30, top: 20),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Welcome, ',
                                      style: GoogleFonts.exo(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '$fullName!',
                                      style: GoogleFonts.exo(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                            height: 160,
                            width: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  14), // Apply border radius to the container
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.14),
                                  blurRadius: 17,
                                  offset: const Offset(
                                      0, 8), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ObjectDetectorView()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      14), // Apply border radius to the button
                                ),
                                backgroundColor: Colors
                                    .white, // Set the background color for the button
                                elevation:
                                    0, // Set elevation to 0 to make the border radius more visible
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      14), // Apply border radius to the button's background
                                  color: Colors
                                      .white, // Set the background color for the button
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(
                                          5), // Padding around the image
                                      child: SizedBox(
                                        width:
                                            127, // Adjusted width considering padding
                                        height: 150,
                                        child: Image.asset(
                                          'assets/object_detection.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 10),
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Learn ',
                                                style: GoogleFonts.exo(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: '\'n Scan',
                                                style: GoogleFonts.exo(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '\n\nUnlock learning adventures instantly with \'Learn \'n Scan\'  - tap to discover and hear about real-world objects in seconds!',
                                                style: GoogleFonts.exo(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black,
                                                ),
                                              )
                                            ],
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                            height: 160,
                            width: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  14), // Apply border radius to the container
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.14),
                                  blurRadius: 17,
                                  offset: const Offset(
                                      0, 8), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CheckClass()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      14), // Apply border radius to the button
                                ),
                                backgroundColor: Colors
                                    .white, // Set the background color for the button
                                elevation:
                                    0, // Set elevation to 0 to make the border radius more visible
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      14), // Apply border radius to the button's background
                                  color: Colors
                                      .white, // Set the background color for the button
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(
                                          5), // Padding around the image
                                      child: SizedBox(
                                        width:
                                            127, // Adjusted width considering padding
                                        height: 150,
                                        child: Image.asset(
                                          'assets/learning_videos.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 10),
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    'Age-Tailored Learning Vault',
                                                style: GoogleFonts.exo(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '\n\nDiscover curated educational videos and stories, sorted by age group, for enhanced learning!',
                                                style: GoogleFonts.exo(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black,
                                                ),
                                              )
                                            ],
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                            height: 160,
                            width: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  14), // Apply border radius to the container
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.14),
                                  blurRadius: 17,
                                  offset: const Offset(
                                      0, 8), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Motion_Detect_Descrp()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      14), // Apply border radius to the button
                                ),
                                backgroundColor: Colors
                                    .white, // Set the background color for the button
                                elevation:
                                    0, // Set elevation to 0 to make the border radius more visible
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      14), // Apply border radius to the button's background
                                  color: Colors
                                      .white, // Set the background color for the button
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(
                                          5), // Padding around the image
                                      child: SizedBox(
                                        width:
                                            127, // Adjusted width considering padding
                                        height: 150,
                                        child: Image.asset(
                                          'assets/move_and_groove.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 10),
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Move \'n Groove',
                                                style: GoogleFonts.exo(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '\n\nEngage in interactive storytelling or music based on your device\'s movements for an immersive learning journey; pause when the fun pauses!',
                                                style: GoogleFonts.exo(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black,
                                                ),
                                              )
                                            ],
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 30, 20, 30),
                            height: 160,
                            width: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  14), // Apply border radius to the container
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.14),
                                  blurRadius: 17,
                                  offset: const Offset(
                                      0, 8), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      14), // Apply border radius to the button
                                ),
                                backgroundColor: Colors
                                    .white, // Set the background color for the button
                                elevation:
                                    0, // Set elevation to 0 to make the border radius more visible
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      14), // Apply border radius to the button's background
                                  color: Colors
                                      .white, // Set the background color for the button
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(
                                          5), // Padding around the image
                                      child: SizedBox(
                                        width:
                                            127, // Adjusted width considering padding
                                        height: 150,
                                        child: Image.asset(
                                          'assets/chat_with_us.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 10),
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Mood Boost Chat',
                                                style: GoogleFonts.exo(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '\n\nChat with our mental health AI assistant for uplifting conversations that brighten your day.',
                                                style: GoogleFonts.exo(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black,
                                                ),
                                              )
                                            ],
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ])))));
  }
}

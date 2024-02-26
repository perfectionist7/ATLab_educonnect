import 'dart:io';
import 'package:educonnect/camera_view.dart';
import 'package:educonnect/checkclass.dart';
import 'package:educonnect/landing.dart';
import 'package:educonnect/videolist.dart';
import 'drawer_content.dart';
import 'package:educonnect/object_detector_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:educonnect/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:educonnect/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  @override
  void initState() {
    super.initState();
    showSpinner = false;
    // listening();
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
                toolbarHeight: 110,
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
                child: ListView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(70, 10, 70, 0),
                        height: 60,
                        width: 267,
                        child: ElevatedButton(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ObjectDetectorView()),
                              );
                              // showSpinner = false;
                            },
                            child: Text('Begin Identifying',
                                style: GoogleFonts.exo(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4178F3),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(70, 40, 70, 0),
                        height: 60,
                        width: 267,
                        child: ElevatedButton(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheckClass()),
                              );
                              showSpinner = false;
                            },
                            child: Text('Learn from Videos',
                                style: GoogleFonts.exo(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4178F3),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(70, 40, 70, 0),
                        height: 60,
                        width: 267,
                        child: ElevatedButton(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ObjectDetectorView()),
                              );
                              // showSpinner = false;
                            },
                            child: Text('Chat with us!',
                                style: GoogleFonts.exo(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4178F3),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(70, 40, 70, 0),
                        height: 60,
                        width: 267,
                        child: ElevatedButton(
                            onPressed: () async {
                              showSpinner = true;
                              _auth.signOut();
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              pref.remove("email");
                              Fluttertoast.showToast(
                                  msg: 'Logged out Successfully!');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Landing()),
                              );
                              showSpinner = false;
                            },
                            child: Text('Logout',
                                style: GoogleFonts.exo(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4178F3),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            )),
                      ),
                    ]))));
  }
}

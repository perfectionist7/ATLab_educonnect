import 'package:educonnect/checkclass.dart';
import 'package:educonnect/dashboard.dart';
import 'package:educonnect/object_detector_view.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'landing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerContent extends StatefulWidget {
  @override
  State<DrawerContent> createState() => _DrawerContentState();
}

class _DrawerContentState extends State<DrawerContent> {
  final _auth = FirebaseAuth.instance;
  @override
  getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    print(screenWidth);
    double screenHeight = MediaQuery.of(context).size.height;
    print(screenHeight);
    return Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: (250 / 784) * screenHeight,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 0,
                      left: (120 / 384) * screenWidth,
                      right: (10 / 384) * screenWidth,
                    ),
                    child: IconButton(
                        icon: ImageIcon(
                          AssetImage('assets/sidebarcross.png'),
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: (38 / 784) * screenHeight,
                        left: (70 / 384) * screenWidth,
                        right: (70 / 384) * screenWidth),
                    // child: Image.asset('assets/images/sidebar_image.png'),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: (10 / 784) * screenHeight,
                        left: (20 / 384) * screenWidth,
                        right: (20 / 384) * screenWidth),
                    child: Text(
                      '${_auth.currentUser?.email}',
                      style: GoogleFonts.poppins(
                        fontSize: (16 / 784) * screenHeight,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(
                top: (10 / 784) * screenHeight, left: (35 / 384) * screenWidth),
            // leading: ImageIcon(
            //   AssetImage('assets/images/home_icon.png'),
            //   color: Color(0xff0A1621),
            // ),
            title: Text(
              'home',
              style: GoogleFonts.poppins(
                fontSize: (16 / 784) * screenHeight,
                fontWeight: FontWeight.w500,
                color: Color(0xff0A1621),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Dashboard()),
              );
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: (35 / 384) * screenWidth),
            // leading: ImageIcon(
            //   AssetImage('assets/images/card_icon.png'),
            //   color: Color(0xffF3940C),
            // ),
            title: Text(
              'play from videos',
              style: GoogleFonts.poppins(
                fontSize: (16 / 784) * screenHeight,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CheckClass()),
              );
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: (35 / 384) * screenWidth),
            title: Text(
              'begin identifying',
              style: GoogleFonts.poppins(
                fontSize: (16 / 784) * screenHeight,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ObjectDetectorView()),
              );
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: (35 / 384) * screenWidth),
            title: Text(
              'chat with us',
              style: GoogleFonts.poppins(
                fontSize: (16 / 784) * screenHeight,
                fontWeight: FontWeight.w500,
                color: Color(0xff0A1621),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: (35 / 384) * screenWidth),
            title: Text(
              'rhymes (motion detection)',
              style: GoogleFonts.poppins(
                fontSize: (16 / 784) * screenHeight,
                fontWeight: FontWeight.w500,
                color: Color(0xff0A1621),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: (35 / 384) * screenWidth),
            title: Text(
              'about us',
              style: GoogleFonts.poppins(
                fontSize: (16 / 784) * screenHeight,
                fontWeight: FontWeight.w500,
                color: Color(0xff0A1621),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: (35 / 384) * screenWidth),
            // leading: ImageIcon(
            //   AssetImage('assets/images/help_icon.png'),
            //   color: Color(0xff0A1621),
            // ),
            title: Text(
              'help',
              style: GoogleFonts.poppins(
                fontSize: (16 / 784) * screenHeight,
                fontWeight: FontWeight.w500,
                color: Color(0xff0A1621),
              ),
            ),
            onTap: () {
              // //add help page navigation here
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const Help_Screen()));
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: (35 / 384) * screenWidth),
            // leading: ImageIcon(
            //   AssetImage('assets/images/logout_icon.png'),
            //   color: Color(0xff0A1621),
            // ),
            title: Text(
              'log out',
              style: GoogleFonts.poppins(
                fontSize: (16 / 784) * screenHeight,
                fontWeight: FontWeight.w500,
                color: Color(0xff0A1621),
              ),
            ),
            onTap: () async {
              // showSpinner = true;
              _auth.signOut();
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.remove("email");
              Fluttertoast.showToast(msg: 'Logged out Successfully!');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Landing()),
              );
              // showSpinner = false;
            },
          ),
        ],
      ),
    );
  }
}

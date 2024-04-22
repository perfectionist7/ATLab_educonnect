import 'package:educonnect/checkclass.dart';
import 'package:educonnect/dashboard.dart';
import 'package:educonnect/help.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'editprofile.dart';
import 'package:educonnect/object_detector_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'main.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
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

  late Future<String?> fullNameFuture;
  late Future<String?> profileImageUrlFuture;

  @override
  void initState() {
    super.initState();
    fullNameFuture = fetchFullName();
    profileImageUrlFuture = fetchProfileImageUrl();
  }

  Future<String?> fetchFullName() async {
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
        return userDoc['fullname'];
      } else {
        print('Document does not exist');
      }
    }
    return null;
  }

  Future<String?> fetchProfileImageUrl() async {
    // Get current user
    User? user = _auth.currentUser;

    // Check if user is not null
    if (user != null) {
      try {
        // Get reference to the profile image in Firebase Storage
        var reference = firebase_storage.FirebaseStorage.instance
            .ref('images/${user.email}.jpg');

        // Get the download URL for the image
        String downloadURL = await reference.getDownloadURL();
        return downloadURL;
      } catch (e) {
        print('Error fetching profile image: $e');
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    print(screenWidth);
    double screenHeight = MediaQuery.of(context).size.height;
    print(screenHeight);
    return ModalProgressHUD(
      inAsyncCall: false, // Always set inAsyncCall to false
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 250,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xffe6f0ff),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 0, left: 35, right: 20),
                          child: FutureBuilder<String?>(
                            future: profileImageUrlFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else {
                                if (snapshot.hasError ||
                                    snapshot.data == null) {
                                  return CircleAvatar(
                                    radius: 60,
                                    backgroundImage:
                                        AssetImage("assets/profileimg.jpg"),
                                  );
                                } else {
                                  return CircleAvatar(
                                    radius: 60,
                                    backgroundImage:
                                        NetworkImage(snapshot.data!),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 140),
                          child: FutureBuilder<String?>(
                            future: fullNameFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else {
                                if (snapshot.hasError ||
                                    snapshot.data == null) {
                                  return Text(
                                    'Error Fetching Name',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff001F3F),
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: Text(
                                      '${snapshot.data}',
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff001F3F),
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0, left: 170, right: 5),
                          child: IconButton(
                            icon: ImageIcon(
                              AssetImage('assets/sidebarcross.png'),
                              color: Color(0xff001F3F),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(
                  top: (10 / 784) * screenHeight,
                  left: (35 / 384) * screenWidth),
              // leading: ImageIcon(
              //   AssetImage('assets/images/home_icon.png'),
              //   color: Color(0xff0A1621),
              // ),
              leading:
                  Icon(Icons.home_rounded, color: Color(0xff001F3F), size: 30),
              title: Text(
                'Home',
                style: GoogleFonts.poppins(
                  fontSize: (16 / 784) * screenHeight,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff001F3F),
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
              //   AssetImage('assets/images/home_icon.png'),
              //   color: Color(0xff0A1621),
              // ),
              leading: Icon(Icons.account_circle_rounded,
                  color: Color(0xff001F3F), size: 30),
              title: Text(
                'Edit Profile',
                style: GoogleFonts.poppins(
                  fontSize: (16 / 784) * screenHeight,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff001F3F),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfile()),
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: (35 / 384) * screenWidth),
              // leading: ImageIcon(
              //   AssetImage('assets/images/card_icon.png'),
              //   color: Color(0xffF3940C),
              // ),
              leading: Icon(Icons.document_scanner,
                  color: Color(0xff001F3F), size: 30),
              title: Text(
                'Learn \'n Scan',
                style: GoogleFonts.poppins(
                  fontSize: (16 / 784) * screenHeight,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff001F3F),
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
              contentPadding: EdgeInsets.only(left: (30 / 384) * screenWidth),
              leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Icon(Icons.library_books_rounded,
                    color: Color(0xff001F3F), size: 30),
              ),
              title: Text(
                'Learning Vault',
                style: GoogleFonts.poppins(
                  fontSize: (16 / 784) * screenHeight,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff001F3F),
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
              leading: Padding(
                padding: EdgeInsets.only(left: 0),
                child: Icon(Icons.music_note_rounded,
                    color: Color(0xff001F3F), size: 30),
              ),
              title: Text(
                'Move \'n Groove',
                style: GoogleFonts.poppins(
                  fontSize: (16 / 784) * screenHeight,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff001F3F),
                ),
              ),
              onTap: () async {},
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: (35 / 384) * screenWidth),
              leading: Padding(
                padding: EdgeInsets.only(left: 0),
                child: Icon(Icons.chat, color: Color(0xff001F3F), size: 30),
              ),
              title: Text(
                'Mood Boost Chat',
                style: GoogleFonts.poppins(
                  fontSize: (16 / 784) * screenHeight,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff001F3F),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: (35 / 384) * screenWidth),
              leading: Padding(
                padding: EdgeInsets.only(left: 0),
                child: Icon(Icons.supervisor_account_rounded,
                    color: Color(0xff001F3F), size: 30),
              ),
              title: Text(
                'about us',
                style: GoogleFonts.poppins(
                  fontSize: (16 / 784) * screenHeight,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff001F3F),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Help_Screen()),
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: (35 / 384) * screenWidth),
              // leading: ImageIcon(
              //   AssetImage('assets/images/logout_icon.png'),
              //   color: Color(0xff0A1621),
              // ),
              leading: Padding(
                padding: EdgeInsets.only(left: 0),
                child: Icon(Icons.logout_rounded,
                    color: Color(0xff001F3F), size: 30),
              ),
              title: Text(
                'log out',
                style: GoogleFonts.poppins(
                  fontSize: (16 / 784) * screenHeight,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff001F3F),
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
      ),
    );
  }
}

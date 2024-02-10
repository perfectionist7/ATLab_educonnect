import 'dart:io';
import 'package:educonnect/landing.dart';
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // print(screenHeight);
    // print(screenWidth);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
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
                        margin: EdgeInsets.fromLTRB(70, 80, 70, 0),
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
                              primary: Color(0xFF4178F3),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            )),
                      ),
                    ]))));
  }
}

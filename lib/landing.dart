import 'dart:io';

import 'package:educonnect/login.dart';
import 'package:educonnect/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  void initState() {
    super.initState();
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
                image: AssetImage("assets/onboarding.png"), fit: BoxFit.cover),
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: (71 / 384) * screenWidth,
                  top: (180 / 784) * screenHeight,
                  right: (10 / 384) * screenWidth,
                ),
                width: (370 / 384) * screenWidth,
                height: (150 / 784) * screenHeight,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Welcome to \n',
                        style: GoogleFonts.poppins(
                          fontSize: (21 / 784) * screenHeight,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xff0A1621),
                        ),
                      ),
                      TextSpan(
                        text: 'EduConnect\n',
                        style: GoogleFonts.poppins(
                            fontSize: (21 / 784) * screenHeight,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF4178F3)),
                      ),
                      TextSpan(
                        text: 'let’s start learning.',
                        style: GoogleFonts.poppins(
                          fontSize: (21 / 784) * screenHeight,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff0A1621),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 4,
                      offset: const Offset(0, 4), // changes position of shadow
                    ),
                  ],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                margin: EdgeInsets.only(
                    top: (20 / 784) * screenHeight,
                    left: (40 / 384) * screenWidth,
                    right: (40 / 384) * screenWidth),
                child: SizedBox(
                  height: (60 / 784) * screenHeight,
                  width: (240 / 384) * screenWidth,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: Text(
                      'Get Started!',
                      style: GoogleFonts.poppins(
                          fontSize: (16 / 784) * screenHeight,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xffF8F8F1)),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4178F3),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

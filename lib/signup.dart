import 'package:cloud_firestore/cloud_firestore.dart';

import 'login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String email = '';
  String phonenumber = '';
  String fullname = '';
  String password = '';
  String owltoy_token_id = '';
  String flashcards_token_id = '';
  String? errorMessage;
  int lastAccessDate = 0;
  int count = 0;
  bool showSpinner = false;
  @override
  void initState() {
    super.initState();
    email = '';
    phonenumber = '';
    fullname = '';
    password = '';
    owltoy_token_id = 'set your token';
    flashcards_token_id = 'set your token';
    lastAccessDate = 0;
    count = 0;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // print(screenWidth);
    double screenHeight = MediaQuery.of(context).size.height;
    // print(screenHeight);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/signup_page.png"),
                  fit: BoxFit.cover),
            ),
            child: ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: (96 / 384) * screenWidth,
                        top: (20 / 784) * screenHeight,
                        right: (64 / 384) * screenWidth,
                      ),
                      width: (250 / 384) * screenWidth,
                      height: (108 / 784) * screenHeight,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '    Create your \n',
                              style: GoogleFonts.poppins(
                                fontSize: (24 / 784) * screenHeight,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff0A1621),
                              ),
                            ),
                            TextSpan(
                              text: '  my',
                              style: GoogleFonts.poppins(
                                fontSize: (24 / 784) * screenHeight,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xffAD93C2),
                              ),
                            ),
                            TextSpan(
                              text: 'little',
                              style: GoogleFonts.poppins(
                                fontSize: (24 / 784) * screenHeight,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff8FB93D),
                              ),
                            ),
                            TextSpan(
                              text: 'genie\n',
                              style: GoogleFonts.poppins(
                                fontSize: (24 / 784) * screenHeight,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xffAD93C2),
                              ),
                            ),
                            TextSpan(
                              text: '         profile!',
                              style: GoogleFonts.poppins(
                                fontSize: (24 / 784) * screenHeight,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff0A1621),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: (89 / 384) * screenWidth,
                        top: (55 / 784) * screenHeight,
                        right: (201 / 384) * screenWidth,
                      ),
                      height: (25 / 784) * screenHeight,
                      width: (102 / 384) * screenWidth,
                      child: Text(
                        'your name',
                        style: GoogleFonts.poppins(
                          fontSize: (16 / 784) * screenHeight,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      height: (30 / 784) * screenHeight,
                      width: (226 / 384) * screenWidth,
                      decoration: BoxDecoration(
                        color: const Color(0xffE1E1D2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: EdgeInsets.only(
                        top: (5 / 784) * screenHeight,
                        left: (78 / 384) * screenWidth,
                        right: (70 / 384) * screenWidth,
                      ),
                      child: TextField(
                        style: GoogleFonts.poppins(
                          fontSize: (12 / 784) * screenHeight,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          fullname = value;
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: 'type name',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: (10 / 784) * screenHeight,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          ),
                          contentPadding: EdgeInsets.only(
                            left: (10 / 384) * screenWidth,
                            right: (10 / 384) * screenWidth,
                            bottom: (17 / 784) * screenHeight,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: (87 / 384) * screenWidth,
                        top: (25 / 784) * screenHeight,
                        right: (176 / 384) * screenWidth,
                      ),
                      height: (25 / 784) * screenHeight,
                      width: (120 / 384) * screenWidth,
                      child: Text(
                        'phone number',
                        style: GoogleFonts.poppins(
                          fontSize: (16 / 784) * screenHeight,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      height: (30 / 784) * screenHeight,
                      width: (226 / 384) * screenWidth,
                      decoration: BoxDecoration(
                        color: const Color(0xffE1E1D2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: EdgeInsets.only(
                        top: (5 / 784) * screenHeight,
                        left: (78 / 384) * screenWidth,
                        right: (70 / 384) * screenWidth,
                      ),
                      child: TextField(
                        style: GoogleFonts.poppins(
                          fontSize: (12 / 784) * screenHeight,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          phonenumber = value;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'type phone',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: (10 / 784) * screenHeight,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          ),
                          contentPadding: EdgeInsets.only(
                              left: (10 / 384) * screenWidth,
                              right: (10 / 384) * screenWidth,
                              bottom: (17 / 784) * screenHeight),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: (87 / 384) * screenWidth,
                        top: (25 / 784) * screenHeight,
                        right: (176 / 384) * screenWidth,
                      ),
                      height: (25 / 784) * screenHeight,
                      width: (120 / 384) * screenWidth,
                      child: Text(
                        'e-mail',
                        style: GoogleFonts.poppins(
                          fontSize: (16 / 784) * screenHeight,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      height: (30 / 784) * screenHeight,
                      width: (226 / 384) * screenWidth,
                      decoration: BoxDecoration(
                        color: const Color(0xffE1E1D2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: EdgeInsets.only(
                        top: (5 / 784) * screenHeight,
                        left: (78 / 384) * screenWidth,
                        right: (70 / 384) * screenWidth,
                      ),
                      child: TextField(
                        style: GoogleFonts.poppins(
                          fontSize: (12 / 784) * screenHeight,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          email = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'type e-mail',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: (10 / 784) * screenHeight,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          ),
                          contentPadding: EdgeInsets.only(
                            left: (10 / 384) * screenWidth,
                            right: (10 / 384) * screenWidth,
                            bottom: (17 / 784) * screenHeight,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: (87 / 384) * screenWidth,
                        top: (25 / 784) * screenHeight,
                        right: (176 / 384) * screenWidth,
                      ),
                      height: (25 / 784) * screenHeight,
                      width: (120 / 384) * screenWidth,
                      child: Text(
                        'password',
                        style: GoogleFonts.poppins(
                          fontSize: (16 / 784) * screenHeight,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      height: (30 / 784) * screenHeight,
                      width: (236 / 384) * screenWidth,
                      decoration: BoxDecoration(
                        color: const Color(0xffE1E1D2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: EdgeInsets.only(
                        top: (5 / 784) * screenHeight,
                        left: (78 / 384) * screenWidth,
                        right: (70 / 384) * screenWidth,
                      ),
                      child: TextField(
                        style: GoogleFonts.poppins(
                          fontSize: (12 / 784) * screenHeight,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          password = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'type password',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: (10 / 784) * screenHeight,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          ),
                          contentPadding: EdgeInsets.only(
                            left: (10 / 384) * screenWidth,
                            right: (10 / 384) * screenWidth,
                            bottom: (17 / 784) * screenHeight,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: (40 / 784) * screenHeight,
                        left: (89 / 384) * screenWidth,
                        right: (83 / 384) * screenWidth,
                      ),
                      height: (44 / 784) * screenHeight,
                      width: (212 / 384) * screenWidth,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 4), // changes position of shadow
                          ),
                        ],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          signUp(email, password);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff8FB93D),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        child: Text(
                          'CREATE ACCOUNT',
                          style: GoogleFonts.poppins(
                            fontSize: (16 / 784) * screenHeight,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xffF8F8F1),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                          top: (75 / 784) * screenHeight,
                          //left: (80 / 384) * screenWidth,
                          //right: (70 / 384) * screenWidth,
                        ),
                        height: (22 / 784) * screenHeight,
                        width: (310 / 384) * screenWidth,
                        child: Text(
                          'already have an account?',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: (16 / 784) * screenHeight,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        )),
                    Stack(children: [
                      // Container(
                      //   alignment: Alignment.centerLeft,
                      //   margin: EdgeInsets.fromLTRB(0.06625 * screenWidth,
                      //       (15 / 784) * screenHeight, 0, 0),
                      //   padding:
                      //       EdgeInsets.fromLTRB(screenWidth * 0.01, 0, 0, 0),
                      //   child: IconButton(
                      //     icon: Icon(Icons.arrow_back_ios_rounded),
                      //     iconSize: screenWidth * 0.08,
                      //     onPressed: () {
                      //       Navigator.pushReplacement(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => Landing()),
                      //       );
                      //     },
                      //   ),
                      // ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 0,
                          left: (85 / 384) * screenWidth,
                          right: (94 / 384) * screenWidth,
                        ),
                        child: TextButton(
                          child: Text(
                            'LOG IN',
                            style: GoogleFonts.poppins(
                              decoration: TextDecoration.underline,
                              fontSize: (16 / 784) * screenHeight,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          },
                        ),
                      ),
                    ]),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseFirestore.instance
          .collection("newUsers")
          .doc(userCredential.user!.email)
          .set({
        'fullname': fullname,
        'phonenumber': phonenumber,
        'email': email,
        'owltoy_token_id': owltoy_token_id,
        'flashcards_token_id': flashcards_token_id,
        'lastAccessDate': lastAccessDate,
        'count': count
      });
      setState(() {
        showSpinner = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const VerificationPage()),
      );
      Fluttertoast.showToast(msg: 'Verification email sent!');
    } catch (e) {
      String errorcode = '';
      errorcode = e.toString();
      // print(errorcode);
      switch (errorcode) {
        case "[firebase_auth/invalid-email] The email address is badly formatted.":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "[firebase_auth/email-already-in-use] The email address is already in use by another account.":
          errorMessage =
              "The email address is already associated with an existing account.";
          break;
        case "[firebase_auth/weak-password] Password should be at least 6 characters":
          errorMessage =
              "The password is too weak. It should atleast be 6 characters.";
          break;
        case "[firebase_auth/operation-not-allowed] Password sign-in is disabled for this project.":
          errorMessage = "Password sign-in is currently disabled.";
          break;
        case '[firebase_auth/unknown] Given String is empty or null':
          errorMessage = 'Empty fields! Enter some input to continue';
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests. Please try again later.";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined error occurred.";
      }
      Fluttertoast.showToast(msg: errorMessage!);
      setState(() {
        showSpinner = false;
      });
      errorMessage = '';
    }
  }

  // Future addUserDetails(String fullname, String email, String? tokenid,
  //     String phonenumber) async {
  //   print("Full name is $fullname");
  //   print("Email id is $email");
  //   print(tokenid);
  //   print(phonenumber);
  //   await FirebaseFirestore.instance.collection('newUsers').add({});
  //   print('Stored!');
  // }
}

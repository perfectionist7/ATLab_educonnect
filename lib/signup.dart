import 'package:educonnect/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String email = '';
  String fullname = '';
  String password = '';
  late bool _passwordVisible;
  String? errorMessage;
  bool showSpinner = false;

  @override
  void initState() {
    // TODO: implement initState
    _passwordVisible = false;
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Container(
              decoration: BoxDecoration(color: Color(0xffe6f0ff)),
              child: ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 34, top: 60, right: 63),
                    child: Text('Create a new \naccount',
                        style: GoogleFonts.exo(
                          fontSize: 36,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 50, 250, 0),
                        child: Text('Name',
                            style: GoogleFonts.exo(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff636D77),
                            )),
                      ),
                      Container(
                        height: 53,
                        width: 343,
                        decoration: new BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 6,
                              offset: const Offset(
                                  0, 7), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.fromLTRB(38, 11, 34, 0),
                        child: TextField(
                          controller: _namecontroller,
                          keyboardType: TextInputType.name,
                          onChanged: (value) {
                            fullname = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Your Name',
                            hintStyle: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 15,
                                color: Colors.blueGrey),
                            contentPadding: EdgeInsets.fromLTRB(16, 18, 19, 19),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 25, 180, 0),
                            child: Text('Email address',
                                style: GoogleFonts.exo(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff636D77),
                                )),
                          ),
                          Container(
                            height: 53,
                            width: 343,
                            decoration: new BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 6,
                                  offset: const Offset(
                                      0, 7), // changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.fromLTRB(38, 11, 34, 0),
                            child: TextField(
                              controller: _emailcontroller,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                email = value;
                              },
                              decoration: InputDecoration(
                                hintText: 'Your Email',
                                hintStyle: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 15,
                                    color: Colors.blueGrey),
                                contentPadding:
                                    EdgeInsets.fromLTRB(16, 18, 19, 19),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 25, 220, 0),
                            child: Text('Password',
                                style: GoogleFonts.exo(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff636D77),
                                )),
                          ),
                          Container(
                            height: 53,
                            width: 343,
                            decoration: new BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 6,
                                  offset: const Offset(
                                      0, 7), // changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.fromLTRB(38, 11, 34, 0),
                            child: TextField(
                              controller: _passwordcontroller,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                password = value;
                              },
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                hintText: 'Your Password',
                                hintStyle: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 15,
                                    color: Colors.blueGrey),
                                contentPadding:
                                    EdgeInsets.fromLTRB(16, 18, 19, 19),
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  padding: EdgeInsets.only(right: 10),
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Color(0xff636D77),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(70, 50, 70, 0),
                            height: 60,
                            width: 267,
                            child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  signUp(email, password);
                                  _emailcontroller.clear();
                                  _passwordcontroller.clear();
                                  _namecontroller.clear();
                                  // print(fullname);
                                  // print(phonenumber);
                                  // print(email);
                                  // print(password);
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => const LoginPage()),
                                  // );
                                },
                                child: Text('Sign Up',
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
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                20, 30, 20, 0.02551 * screenHeight),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                                _emailcontroller.clear();
                                _passwordcontroller.clear();
                                _namecontroller.clear();
                              },
                              child: Text.rich(TextSpan(children: [
                                TextSpan(
                                    text: 'Already Have An Account?',
                                    style: GoogleFonts.exo(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff636D77),
                                    )),
                                TextSpan(
                                    text: ' Login',
                                    style: GoogleFonts.exo(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Color(0xFF4178F3),
                                    ))
                              ])),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
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
        'email': email,
      });
      setState(() {
        showSpinner = false;
      });

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const VerificationPage()),
      // );
      Fluttertoast.showToast(msg: 'Successfully Registered!');
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
}

import 'package:educonnect/dashboard.dart';
import 'package:educonnect/landing.dart';

import 'signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _controller = TextEditingController();
  var _passwordcontroller = TextEditingController();
  String email = '';
  String password = '';
  String? errorMessage;
  late bool _passwordVisible;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    _passwordVisible = false;
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
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            decoration: BoxDecoration(color: Color(0xffe6f0ff)),
            child: ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Column(children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 60,
                      left: 20,
                      right: 110,
                    ),
                    child: Text(
                      'Welcome\nBack!',
                      style: GoogleFonts.exo(
                        fontSize: 44,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 47, left: 0, right: 30),
                    child: Text(
                      'Log in into your account.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.exo(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF4178F3)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 50, 180, 0),
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
                          offset:
                              const Offset(0, 7), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.fromLTRB(38, 11, 34, 0),
                    child: TextField(
                      controller: _controller,
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
                        contentPadding: EdgeInsets.fromLTRB(16, 18, 19, 19),
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
                          offset:
                              const Offset(0, 7), // changes position of shadow
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
                        contentPadding: EdgeInsets.fromLTRB(16, 18, 19, 19),
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
                    margin: EdgeInsets.only(
                      top: 0.0153061224489796 * screenHeight,
                      left: 0.47008333333333333 * screenWidth,
                    ),
                    width: 0.3786458333333333 * screenWidth,
                    height: 0.0509897959183673 * screenHeight,
                    child: TextButton(
                      child: Text(
                        'forgot password?',
                        style: GoogleFonts.exo(
                          decoration: TextDecoration.underline,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff636D77),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          showSpinner =
                              true; // Show the spinner before the async operation.
                        });
                        if (email.isNotEmpty) {
                          try {
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: email);

                            Fluttertoast.showToast(
                                msg:
                                    'A password reset email has been sent to your email address.');
                          } catch (e) {
                            Fluttertoast.showToast(
                                msg:
                                    'Failed to send password reset email. Please try again.');
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg:
                                  'Please enter your registered email address.');
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(70, 20, 70, 0),
                    height: 60,
                    width: 267,
                    child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);

                            email = '';
                            password = '';
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            pref.setString("email", email);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Dashboard()),
                            );
                            _passwordcontroller.clear();
                            _controller.clear();
                            Fluttertoast.showToast(
                                msg: 'Successfully Logged In!');
                            setState(() {
                              showSpinner = false;
                            });
                          } catch (e) {
                            // print(e);
                            String error = '';
                            error = e.toString();
                            switch (error) {
                              case '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.':
                                errorMessage = 'Invalid Password Entered.';
                                break;
                              case '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.':
                                errorMessage = 'No such user exists.';
                                break;
                              case '[firebase_auth/invalid-email] The email address is badly formatted.':
                                errorMessage = 'Invalid email address.';
                                break;
                              case '[firebase_auth/unknown] Given String is empty or null':
                                errorMessage =
                                    'Empty fields! Enter some input to continue';
                                break;
                              case '[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.':
                                errorMessage =
                                    'Too many attempts, try again later';
                                break;
                              case '[firebase_auth/user-disabled] The user account has been disabled by an administrator.':
                                errorMessage =
                                    'Account blocked by Administrator';
                                break;
                              default:
                                errorMessage = 'An undefined error occurred.';
                                break;
                            }
                          }
                          Fluttertoast.showToast(msg: errorMessage!);
                          setState(() {
                            showSpinner = false;
                          });
                          errorMessage = '';
                        },
                        child: Text('Login',
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
                    margin:
                        EdgeInsets.fromLTRB(20, 30, 20, 0.02551 * screenHeight),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupPage()),
                        );
                        _passwordcontroller.clear();
                        _controller.clear();
                      },
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'Don\'t have an account?',
                            style: GoogleFonts.exo(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff636D77),
                            )),
                        TextSpan(
                            text: ' Register',
                            style: GoogleFonts.exo(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xFF4178F3),
                            ))
                      ])),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
      //   ),
      // ),
    );
  }
}

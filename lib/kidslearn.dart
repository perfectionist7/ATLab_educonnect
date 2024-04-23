import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:devotai/landing.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
// import 'package:devotai/selectionpage.dart';
// import 'package:devotai/text_detector_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SplashScreenText extends StatefulWidget {
  const SplashScreenText({
    Key? key,
    required this.name,
  }) : super(key: key);
  // final int category;
  // final int product;
  final String name;

  @override
  State<SplashScreenText> createState() => SplashScreenTextState();
}

class SplashScreenTextState extends State<SplashScreenText> {
  // int category = -1;
  // int product = -1;
  var userData;
  String _name = '';
  String _link = '';
  String value = '';
  String barcode_text = '';
  String _imageLink = '';
  bool _isLoading = true;
  String previousvalue = '';
  String selectedlanguage = '';
  late bool isScreenLock = false;
  // String _productname = '';
  bool _isDisposed = false;
  final FlutterTts textspeak = FlutterTts();

  Future<void> speak(String text) async {
    await textspeak.setLanguage("en-US");
    await textspeak.setPitch(1);
    await textspeak.speak(text);
  }

  @override
  void initState() {
    super.initState();
    _name = widget.name;
    if (_name != '') {
      _fetchImageLink();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchImageLink() async {
    String apiKey = 'AIzaSyC36rolxGXnJxXAzFmWr6J9Y_WfJ3OUcpg';
    String searchEngineId = '54664cb890784456f';
    String query = _name;
    String url =
        'https://www.googleapis.com/customsearch/v1?q=$query&cx=$searchEngineId&searchType=image&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          _imageLink = data['items'][0]['link'];
          print(_imageLink);
          _isLoading = false;
          speak(_name);
        });
      } else {
        // Handle error

        print('Failed to load image link: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      print('Error fetching image link: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: _imageLink.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: 0.100765306122449 * screenHeight,
                                  left: 0.1432291666666667 * screenWidth,
                                  right: 0.1432291666666667 * screenWidth),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white,
                                      style: BorderStyle.solid,
                                      width: 1)),
                              child: Image.network(
                                '$_imageLink',
                                width: 0.78125 * screenWidth,
                                height: 0.3826530612244898 * screenHeight,
                              ),
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    25, screenHeight * 0.10, 25, 0),
                                child: Text(
                                  _name,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff001F3F),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          margin: EdgeInsets.fromLTRB((30 / 384) * screenWidth,
                              screenHeight * 0.18, 0, 0),
                          padding: const EdgeInsets.all(1),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_rounded),
                            iconSize: screenWidth * 0.08,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ])));
  }
}

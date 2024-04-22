import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'drawer_content.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  File? _imageFile;
  String fullname = '';
  var _controller = TextEditingController();
  String password = '';
  var _passwordcontroller = TextEditingController();
  late Future<String?> profileImageUrlFuture;
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
  void initState() {
    super.initState();
    profileImageUrlFuture = fetchProfileImageUrl();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    // Request permission to access the camera
    var cameraStatus = await Permission.camera.request();
    // Request permission to access the photo library
    var photoLibraryStatus = await Permission.photos.request();

    if (!cameraStatus.isGranted || !photoLibraryStatus.isGranted) {
      // Permissions denied, handle accordingly (e.g., show error message)
      print('Permissions denied. Cannot access camera or photo library.');
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
    _uploadImage();
  }

  Future<void> _uploadImage() async {
    Fluttertoast.showToast(msg: "Uploading Image");
    // Get current user
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        // Create a reference to the profile image in Firebase Storage
        var reference = firebase_storage.FirebaseStorage.instance
            .ref('images/${user.email}.jpg');

        // Upload the image file to Firebase Storage
        await reference.putFile(_imageFile!);

        // Retrieve the download URL for the image
        String downloadURL = await reference.getDownloadURL();

        // Do something with the download URL (e.g., save it to user profile)
        // For now, print the download URL
        print('Image uploaded successfully. Download URL: $downloadURL');
        Fluttertoast.showToast(msg: "Image uploaded Successfully");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EditProfile()),
        );
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
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
    double screenHeight = MediaQuery.of(context).size.height;
    // print(screenHeight);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xffe6f0ff),
          toolbarHeight: 70,
          actions: [
            Container(
              // padding: EdgeInsets.only(
              //   left: (10 / 411.42857142857144) * screenWidth,
              // ), // Add some margin here
              margin: EdgeInsets.only(left: 10),
              child: IconButton(
                icon: Icon(
                  Icons.menu_sharp,
                  size: 30,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    _scaffoldKey.currentState?.openDrawer();
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 185),
              child: Text(
                'Edit Profile',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff001F3F),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        drawer: Container(
          width: 240,
          child: Drawer(
            child: DrawerContent(),
          ),
        ),
        body: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              Stack(
                children: [],
              ),
              Container(
                margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                child: FutureBuilder<String?>(
                  future: profileImageUrlFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      if (snapshot.hasError || snapshot.data == null) {
                        return CircleAvatar(
                          radius: 80,
                          backgroundImage: AssetImage("assets/profileimg.jpg"),
                        );
                      } else {
                        return CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage(snapshot.data!),
                        );
                      }
                    }
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () => _showOptionsDialog(context),
                    child: Text(
                      'Change Picture',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: const Color(0xff001F3F),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 180, 0),
                    child: Text('Full Name',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff001F3F),
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
                        border: Border.all(color: Color(0xff001F3F), width: 1)),
                    margin: EdgeInsets.fromLTRB(38, 11, 34, 0),
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        fullname = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'New Name',
                        hintStyle: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 15,
                            color: Colors.blueGrey),
                        contentPadding: EdgeInsets.fromLTRB(16, 18, 19, 15),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 190, 0),
                    child: Text('Password',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff001F3F),
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
                        border: Border.all(color: Color(0xff001F3F), width: 1)),
                    margin: EdgeInsets.fromLTRB(38, 11, 34, 0),
                    child: TextField(
                      controller: _passwordcontroller,
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'New Password',
                        hintStyle: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 15,
                            color: Colors.blueGrey),
                        contentPadding: EdgeInsets.fromLTRB(16, 18, 19, 15),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    margin: EdgeInsets.only(
                        top: (50 / 784) * screenHeight,
                        left: (40 / 384) * screenWidth,
                        right: (40 / 384) * screenWidth),
                    child: SizedBox(
                      height: (50 / 784) * screenHeight,
                      width: (283 / 384) * screenWidth,
                      child: ElevatedButton(
                        onPressed: () async {
                          Fluttertoast.showToast(msg: "Updating information");
                          updateDetails();
                          Fluttertoast.showToast(
                              msg: "Information updated successfully!");
                        },
                        child: Text(
                          'Update Details',
                          style: GoogleFonts.poppins(
                              fontSize: (16 / 784) * screenHeight,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff001F3F),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(
                        (40 / 411.42857142857144) * screenWidth, 45, 0, 0),
                    padding: const EdgeInsets.all(1),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Color(0xff001F3F),
                      ),
                      iconSize: screenWidth * 0.08,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff001F3F),
          title: Text(
            'Where would you like to upload from?',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop('Option 1');
                  },
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            14), // Adjust the radius as needed
                      ),
                    ),
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(Icons.camera_alt_rounded,
                          color: Color(0xff001F3F)),
                    ), // Icon for Camera
                    label: Text(
                      'Camera',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff001F3F),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {},
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            14), // Adjust the radius as needed
                      ),
                    ),
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: Padding(
                      padding: EdgeInsets.only(right: 0),
                      child: Icon(Icons.image, color: Color(0xff001F3F)),
                    ), // Icon for Gallery
                    label: Text(
                      'Gallery',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff001F3F),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) {
      // Handle the result here
      if (value != null) {
        print("Selected Option: $value");
      }
    });
  }

  void updateDetails() async {
    try {
      // Get the current user
      User? user = _auth.currentUser;
      print(user);

      print(fullname);
      print(password);
      if (user != null) {
        await _updateFirebaseAuth(user);
        await _updateFirestore(user);
        // Show success message

        // Clear text fields
        _controller.clear();
        _passwordcontroller.clear();
      }
    } catch (e) {
      // Show error message if update fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile: $e'),
        ),
      );
    }
  }

  Future<void> _updateFirebaseAuth(User user) async {
    if (password.isNotEmpty) {
      await user.updatePassword(password);
    }
  }

  Future<void> _updateFirestore(User user) async {
    print(user.email);
    await _firestore.collection('newUsers').doc(user.email).update({
      'fullname': fullname.isNotEmpty ? fullname : user.displayName,
      // You can add more fields to update here
    });
    print("after");
  }
}

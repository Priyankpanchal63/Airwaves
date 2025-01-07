import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irwaves/view/home_screen.dart';  // Import your home screen
import 'package:irwaves/view/login_screen.dart';

import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile/profile_event.dart';
import '../bloc/profile/profile_state.dart';

class ProfileSetupScreen extends StatefulWidget {
  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController bioController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedGender;
  String? photoPath;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.redAccent, Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: BlocProvider(
              create: (context) => ProfileBloc(),
              child: BlocConsumer<ProfileBloc, ProfileState>(
                listener: (context, state) {
                  if (state is ProfileSubmissionSuccess) {

                    // Navigate to HomeScreen with a fade animation
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return HomeScreen();  // Replace with your HomeScreen widget
                        },
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0); // Start from the right
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;

                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(position: offsetAnimation, child: child);
                        },
                      ),

                    );
                  } else if (state is ProfileSubmissionFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage)),
                    );
                  }
                },
                builder: (context, state) {
                  // Save photo path when photo is uploaded
                  if (state is PhotoUploadedState) {
                    photoPath = state.photoPath;
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Top Logos
                      Container(
                        width: 400,
                        height: 98,
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Positioned(
                              bottom: -screenHeight * 0.28,
                              child: Image.asset(
                                'assets/si.png',
                                width: 400,
                                height: screenHeight * 0.51,
                              ),

                            ),

                            Positioned(
                              left: 21.17,
                              top: 54.66,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                  );
                                },child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => LoginScreen()),
                                      );
                                    },
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  // This text area is no longer wrapped in a GestureDetector
                                ],
                              )
                              ),
                            ),
                            SizedBox(width: 76,),
                            Container(
                                height: 51.68,
                                width: 240,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "SetUp your Profile",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Metropolis',
                                      ),
                                    ),
                                  ],
                                ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 1),
                      // White foreground
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 29),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(27),
                            topRight: Radius.circular(27),
                          ),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Container(
                            width: 375,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 35.14),
                                // Profile Photo
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<ProfileBloc>()
                                        .add(UploadPhotoEvent());
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 60,
                                    backgroundImage: photoPath != null
                                        ? FileImage(File(photoPath!))
                                        : null,
                                    child: photoPath == null
                                        ? Image.asset('assets/photoU.png', color: Colors.redAccent,)
                                        : null,
                                  ),
                                ),
                                SizedBox(height: 41),
                                Text(
                                  'Are you male/female ?',
                                  style: TextStyle(fontFamily: 'Metropolis', fontWeight: FontWeight.w400, fontSize: 13),
                                ),
                                // Gender Selector
                                SizedBox(height: 12),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _genderButton(context, "Male", state),
                                      SizedBox(width: 13.86,),
                                      _genderButton(context, "Female", state),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 29),
                                // Bio Input
                                Container(
                                  width: 316,
                                  height: 143,
                                  child: TextFormField(
                                    controller: bioController,
                                    decoration: InputDecoration(
                                      labelText: "Bio",alignLabelWithHint: true,
                                        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                        borderSide: BorderSide(color: Color(0xFFDFDFDF)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                        borderSide: BorderSide(color: Color(0xFFDFDFDF), width: 1),
                                      ),
                                    ),
                                    maxLines: 6,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a bio';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(height: 181),
                                // Submit Button
                                ElevatedButton(
                                  onPressed: state is ProfileSubmissionLoading
                                      ? null
                                      : () {
                                    if (_formKey.currentState!.validate() && photoPath != null && selectedGender != null) {
                                      context.read<ProfileBloc>().add(
                                        SubmitProfileEvent(
                                          bio: bioController.text,
                                          gender: selectedGender!,
                                          photoPath: photoPath!,
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Please complete all fields')),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(27),
                                    ),
                                  ),
                                  child: Container(
                                    width: 316,
                                    height: 47,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.deepOrangeAccent,
                                          Colors.redAccent
                                        ],
                                        begin: Alignment.topRight,
                                        end: Alignment.topLeft,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.redAccent
                                              .withOpacity(0.1),
                                          offset: Offset(0.1, 0),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        ),
                                        BoxShadow(
                                          color: Colors.redAccent
                                              .withOpacity(0.3),
                                          offset: Offset(4, 4),
                                          blurRadius: 10,
                                          spreadRadius: 6,
                                        ),
                                      ],
                                    ),

                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                        child: state is ProfileSubmissionLoading
                                            ? SizedBox(
                                          height: 21,
                                          width: 21,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                            : Text(
                                          'Continue',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Gender Button Widget
  Widget _genderButton(BuildContext context, String gender, ProfileState state) {
    bool isSelected = selectedGender == gender;

    return Container(
      width: 113.32,
      height: 36,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedGender = gender;
          });
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          backgroundColor: Colors.white, // Set the background as transparent to apply gradient below
        ),
        child: Container(
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: isSelected
                ? Border.all(color: Colors.white, width: 1)
                : Border.all(color: Colors.black26, width: 1), // White border when selected
            gradient: LinearGradient(
              colors: [
                isSelected ? Colors.deepOrangeAccent : Colors.white!,
                isSelected ? Colors.redAccent : Colors.white!
              ],
              begin: Alignment.topRight,
              end: Alignment.topLeft,
            ),
          ),
          child: Center(
            child: Text(
              gender,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

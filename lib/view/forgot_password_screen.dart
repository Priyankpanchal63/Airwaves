import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:irwaves/view/login_screen.dart';

import '../bloc/forgotPassword/forgot_bloc.dart';
import '../bloc/forgotPassword/forgot_event.dart';
import '../bloc/forgotPassword/forgot_state.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
        child: BlocProvider(
          create: (context) => ForgotPasswordBloc(),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.redAccent, Colors.red.shade900],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(0),
                child: BlocProvider(
                  create: (_) => ForgotPasswordBloc(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.05),
                      Container(
                        width: double.maxFinite,
                        height: screenHeight * 0.2,
                        // Adjust the height as needed
                        child: Stack(
                          alignment: Alignment.center,
                          // Center align both images
                          children: [
                            Positioned(
                              top: -1,
                              // Position the first image at the top
                              child: Image.asset('assets/namelogo.png',
                                  width: 214.58, height: 137),
                            ),
                            Positioned(
                              bottom: -screenHeight * 0.29,
                              child: Image.asset('assets/si.png',
                                  width: screenWidth * 0.98,
                                  height: screenHeight * 0.51),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.001),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 29),
                        decoration: BoxDecoration(
                          color: Color(0xFFF9F9F9),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Container(
                            width: 375,
                            height: 545,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 42),
                                Text(
                                  'Forgot your password ?',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: 'Metropolis',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 16.14,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: 276,
                                  height: 48,
                                  //padding: EdgeInsets.symmetric(horizontal: 11,vertical: 0),
                                  child: Text(
                                    '\    Don’t worry ! just enter your email and we will send \n        you verification link on your registered email \n     address and you can reset the password easily.',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black45,
                                      fontFamily: 'Metropolis',
                                      fontWeight: FontWeight.w400,
                                    ), // Optional: Adds ellipsis if text exceeds the limit
                                  ),
                                ),
                                SizedBox(height: 21),
                                Container(
                                  width: 316,
                                  child: BlocBuilder<ForgotPasswordBloc,
                                      ForgotPasswordState>(
                                    builder: (context, state) {
                                      return TextFormField(
                                        controller: emailController,
                                        onChanged: (value) {
                                          context
                                              .read<ForgotPasswordBloc>()
                                              .add(EmailChanged(value));
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          labelText: 'Email',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(27)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(27)),
                                            borderSide: BorderSide(
                                                color: Color(0xFFDFDFDF)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(27)),
                                            borderSide: BorderSide(
                                                color: Color(0xFFDFDFDF),
                                                width: 1),
                                          ),
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your email';
                                          } else if (RegExp(
                                                  r'^[^@\s]+@[^@\s]+\.[^@\s]+\$')
                                              .hasMatch(value)) {
                                            return 'Please enter a valid email';
                                          }
                                          return null;
                                        },
                                        style: TextStyle(fontSize: 16),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 32.55),
                                BlocConsumer<ForgotPasswordBloc,
                                    ForgotPasswordState>(
                                  listener: (context, state) {
                                    if (state is ForgotPasswordSuccess) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Password reset email sent!')),
                                      );
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation, secondaryAnimation) {
                                            return LoginScreen(); // Your target screen
                                          },
                                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                            const begin = Offset(0.0, 1.0); // Start position (bottom of the screen)
                                            const end = Offset.zero;        // End position (original position)
                                            const curve = Curves.easeInOut; // Smooth animation curve

                                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                            var offsetAnimation = animation.drive(tween);

                                            return FadeTransition(
                                              opacity: animation, // Fade effect
                                              child: SlideTransition(
                                                position: offsetAnimation, // Slide effect
                                                child: child,
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    } else if (state is ForgotPasswordFailure) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(state.errorMessage)),
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    return ElevatedButton(
                                      onPressed: state is ForgotPasswordLoading
                                          ? null
                                          : () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                context
                                                    .read<ForgotPasswordBloc>()
                                                    .add(
                                                      SubmitEmail(
                                                        email: emailController
                                                            .text,
                                                      ),
                                                    );
                                              }
                                            },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      ),
                                      child: Container(
                                        width: 316,
                                        height: 49,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
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
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 15),
                                            child: state
                                                    is ForgotPasswordLoading
                                                ? SizedBox(
                                                    height: 21,
                                                    width: 21,
                                                    child: SpinKitFadingCircle(
                                                      color: Colors.white,
                                                      size: 25,
                                                    ),
                                                  )
                                                : Text(
                                                    'Update',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 35,
                                ),
                                WillPopScope(
                                    onWillPop: () async {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                      return false;
                                    },
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                secondaryAnimation) {
                                              return LoginScreen(); // Your target screen
                                            },
                                            transitionsBuilder: (context,
                                                animation,
                                                secondaryAnimation,
                                                child) {
                                              // Simple fade transition
                                              const begin = Offset(0.0, 1.0);
                                              const end = Offset.zero;
                                              const curve = Curves.easeInOut;

                                              var tween = Tween(
                                                      begin: begin, end: end)
                                                  .chain(
                                                      CurveTween(curve: curve));
                                              var offsetAnimation =
                                                  animation.drive(tween);

                                              return SlideTransition(
                                                  position: offsetAnimation,
                                                  child: child);
                                            },
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Login in now",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Metropolis',
                                          fontSize: 16,
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

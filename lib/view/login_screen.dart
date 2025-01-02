import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irwaves/view/SignUp_screen.dart';
import 'package:irwaves/view/home_screen.dart';

import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background with red and orange gradient
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.redAccent, Colors.redAccent.shade700],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 120),
                // Logo Image on top, with a full-width constraint
                Container(
                  width: double.infinity,
                  height: 150, // Adjust the height as needed
                  child: Stack(
                    alignment: Alignment.center, // Center align both images
                    children: [
                      // First Image
                      Positioned(
                        top: -65, // Position the first image at the top
                        child: Image.asset('assets/namelogo.png',
                            width: 240, height: 240),
                      ),
                      // Second Image (sp.png)
                      Positioned(
                        bottom: -225,
                        // Adjust this value to control how much of the second image is visible
                        child: Image.asset('assets/sp.png',
                            width: 400, height: 400),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                // Heading Text
                // White Form Background
                Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      )),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Log in into your account',
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Metropolis',
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 30),
                        // Email Input Field
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              borderSide: BorderSide(
                                  color: Color(
                                      0xFFDFDFDF)), // Border color for inactive state
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              borderSide: BorderSide(
                                  color: Color(0xFFDFDFDF),
                                  width:
                                      2), // Border color for active (focused) state
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        // Password Input Field
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              borderSide: BorderSide(
                                  color: Color(
                                      0xFFDFDFDF)), // Border color for inactive state
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              borderSide: BorderSide(
                                  color: Color(0xFFDFDFDF),
                                  width:
                                      2), // Border color for active (focused) state
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        // Login Button with Bloc
                        BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state is LoginSuccess) {
                              // Show success message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Login successful!')),
                                //FlushbarHelper.flushBarSuccessMessage("Login Successful", context);
                                //FlushbarHelper.flushBarLoadingMessage("Submitting...", context);
                              );
                              // Navigate to the Home Screen
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                              );
                            } else if (state is LoginFailure) {
                              // Show error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.errorMessage)),
                                //String errorMessage = state.errorMessage ?? "An error occurred";
                                //FlushbarHelper.flushBarErrorMessage(errorMessage, context);
                              );
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: state is LoginLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        context
                                            .read<LoginBloc>()
                                            .add(LoginSubmitted(
                                              email: emailController.text,
                                              password: passwordController.text,
                                            ));
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                // Remove default padding for decoration
                                backgroundColor: Colors.transparent,
                                // Transparent to show custom decoration
                                shadowColor: Colors.transparent,
                                // Remove default shadow
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.deepOrangeAccent,
                                      Colors.redAccent
                                    ], // Gradient background
                                    begin: Alignment.topRight,
                                    end: Alignment.topLeft,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.redAccent.withOpacity(0.1),
                                      offset: Offset(0.1, 0),
                                      // Orange shadow at the top-left
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                    BoxShadow(
                                      color: Colors.redAccent.withOpacity(0.3),
                                      offset: Offset(5, 5),
                                      // Red shadow at the bottom-right
                                      blurRadius: 10,
                                      spreadRadius: 6,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    // Adjust padding for text/loader
                                    child: state is LoginLoading
                                        ? CircularProgressIndicator(
                                            color: Colors.white)
                                        : Text(
                                            'Log in',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10),
                        // Forgot Password Link
                        TextButton(
                          onPressed: () {},
                          child: Text('Forgot your password?',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Metropolis',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14)),
                        ),
                        SizedBox(height: 10),
                        Image.asset('assets/or.png'),
                        SizedBox(height: 10),
                        Container(
                          height: 60,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // iPhone Button
                                IconButton(
                                  icon: Image.asset('assets/iphone.jpg'),
                                  iconSize: 20, // Small size for the icon
                                  onPressed: () {
                                    print('iPhone button pressed');
                                  },
                                ),
                                SizedBox(width: 30), // Space between buttons

                                // Google Button
                                IconButton(
                                  icon: Image.asset('assets/google.png'),
                                  iconSize: 20, // Small size for the icon
                                  onPressed: () {
                                    print('Google button pressed');
                                  },
                                ),
                                SizedBox(width: 30), // Space between buttons

                                // Spotify Button
                                IconButton(
                                  icon: Image.asset('assets/spotify.png'),
                                  iconSize: 20, // Small size for the icon
                                  onPressed: () {
                                    print('Spotify button pressed');
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Sign Up Link
                        SizedBox(
                          height: 120,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              " ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Metropolis',
                                  fontSize: 16),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()),
                                );
                              },
                              child: Text(
                                "Sign up.",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Metropolis',
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

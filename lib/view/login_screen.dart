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
            colors: [Colors.redAccent, Colors.orange],
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
                SizedBox(height:120),
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
                        child: Image.asset('assets/namelogo.png', width: 240, height: 240),
                      ),
                      // Second Image (sp.png)
                      Positioned(
                        bottom: -225, // Adjust this value to control how much of the second image is visible
                        child: Image.asset('assets/sp.png', width: 400, height: 400),
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
                    )
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height:20 ,),
                        Text(
                          'Log in into your account',
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        SizedBox(height: 30),
                        // Email Input Field
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(25)),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
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
                              borderRadius: BorderRadius.all(
                                  Radius.circular(25)),
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
                              );
                              // Navigate to the Home Screen
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen()),
                              );
                            } else if (state is LoginFailure) {
                              // Show error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.errorMessage)),
                              );
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: state is LoginLoading
                                  ? null
                                  : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<LoginBloc>().add(LoginSubmitted(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 161, vertical: 15),
                                backgroundColor: Colors.redAccent, // Remove the default color
                                shadowColor: Colors.orange, // Remove shadow
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: state is LoginLoading
                                  ? CircularProgressIndicator(color: Colors.white)
                                  : Text('Log in', style: TextStyle(fontSize: 16,color: Colors.white)),
                            );
                          },
                        ),
                        SizedBox(height: 10),
                        // Forgot Password Link
                        TextButton(
                          onPressed: () {},
                          child: Text('Forgot your password?', style: TextStyle(color: Colors.black,fontFamily: 'Metropolis',fontWeight:FontWeight.w400,fontSize: 15)),
                        ),
                        SizedBox(height: 10),
                        Text('-------------------------------OR-----------------------------',style: TextStyle(fontSize: 20,fontWeight:FontWeight.w100 ),),
                        SizedBox(height: 10),
                        Container(
                          height: 56,
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
                                  icon: Image.asset('assets/spotify.webp'),
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
                        SizedBox(height: 150,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don’t have an account? ",style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400,fontFamily: 'Metropolis',fontSize: 16),),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                                );
                              },
                              child: Text(
                                "Sign up",
                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.w400,fontFamily: 'Metropolis',fontSize: 16),
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

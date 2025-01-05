import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:irwaves/view/login_screen.dart';

import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
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
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.05),
                    Container(
                      width: double.maxFinite,
                      height: screenHeight * 0.2,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top:-1,
                            child: Image.asset(
                              'assets/namelogo.png',
                              width: 214.58,
                              height: 137,
                            ),
                          ),
                          Positioned(
                            bottom: -screenHeight * 0.290,
                            child: Image.asset(
                              'assets/si.png',
                              width: screenWidth * 0.98,
                              height: screenHeight * 0.51,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.001),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical:29 ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Container(
                          width: 375,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 41),
                              Text(
                                'Create Your Account',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.06,
                                  fontFamily: 'Metropolis',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 35),
                              _buildTextField(
                                controller: firstNameController,
                                label: 'First Name',
                                validator: (value) {
                                  if(value==null || value.isEmpty){
                                    return 'Please enter your first name';
                                  }
                                },
                              ),
                              SizedBox(height: 9.55),
                              _buildTextField(
                                controller: lastNameController,
                                label: 'Last Name',
                                validator: (value) {

                                  if(value==null || value.isEmpty){
                                    return 'Please enter your last name';
                                  }
                                },
                              ),
                              SizedBox(height: 9.55),
                              _buildTextField(
                                controller: emailController,
                                label: 'Enter your Email',
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
                              SizedBox(height: 9.55),
                              _buildTextField(
                                controller: passwordController,
                                label: 'Password',
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
                              SizedBox(height: 9.55),
                              _buildTextField(
                                controller: confirmPasswordController,
                                label: 'Confirm Password',
                                obscureText: true,
                                validator: (value) {
                                  if(value==null || value.isEmpty){
                                    return 'Please enter your Confirm password';
                                  }
                                },
                              ),
                              SizedBox(height: 15.55),
                              _buildTermsAndConditions(),
                              SizedBox(height: 18),
                              _buildSignUpButton(),
                              SizedBox(height: 21.84),
                              _buildLoginLink(),
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
    );
  }

  // Helper method to build TextFormFields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 10.0),
      child: Container(
        width: 316,
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(27)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(27)),
              borderSide: BorderSide(color: Color(0xFFDFDFDF)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(27)),
              borderSide: BorderSide(color: Color(0xFFDFDFDF), width: 1),
            ),
          ),
          validator: validator,
        ),
      ),
    );
  }

  // Helper method for Terms and Conditions text
  Widget _buildTermsAndConditions() {
    return Container(
      width: 294,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'by clicking on "Create account" button you\'re agree with our ',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Metropolis',
                fontWeight: FontWeight.w400,
                fontSize: 11,
              ),
              children: [
                TextSpan(
                  text: '\nterms and conditions',
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'Metropolis',
                    fontWeight: FontWeight.w400,
                    fontSize: 11,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print("Terms and Conditions Clicked");
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create the Sign Up Button
  Widget _buildSignUpButton() {
    return  BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login successful!')),
            );
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => HomeScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
                transitionDuration: Duration(milliseconds: 500),
              ),
            );
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          } else if (state is LoginLoading) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Loading..')),
            );
          }
        },
        builder: (context, state) {
          return ElevatedButton(
            onPressed: state is LoginLoading
                ? null
                : () {
              if (_formKey.currentState!.validate()) {
                context.read<LoginBloc>().add(
                  LoginSubmitted(
                    email: emailController.text,
                    password: passwordController.text,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(3),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Container(
              width: 316,
              height: 47.45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  colors: [Colors.deepOrangeAccent, Colors.redAccent],
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.redAccent.withOpacity(0.1),
                    offset: Offset(0.1, 0),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.redAccent.withOpacity(0.3),
                    offset: Offset(4, 4),
                    blurRadius: 10,
                    spreadRadius: 6,
                  ),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: state is LoginLoading
                      ? SizedBox(
                    height: 21,
                    width: 21,
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 25,
                    ),
                  )
                      : Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontFamily: 'Metropolis',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
    );
  }
  // Helper method for the Login link
  Widget _buildLoginLink() {
    return Container(
      height: 23,
      width: 232,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account? ",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontFamily: 'Metropolis',
                fontSize: 15),
          ),
          WillPopScope(
            onWillPop: ()async{
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              return false;
            },
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              },
              child: Text(
                "Login.",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Metropolis',
                    fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

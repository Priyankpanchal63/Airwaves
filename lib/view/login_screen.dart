import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:irwaves/view/SignUp_screen.dart';
import 'package:irwaves/view/home_screen.dart';
import 'package:irwaves/view/profileSetUp_screen.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';
import 'forgot_password_screen.dart';

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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      // Background with red and orange gradient
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
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
                create: (_) => LoginBloc(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.05),
                    // Logo Image on top, with a full-width constraint
                    Container(
                      width: double.maxFinite,
                      height: screenHeight * 0.2, // Adjust the height as needed
                      child: Stack(
                        alignment: Alignment.center, // Center align both images
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
                    // Heading Text
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
                          //height: 550,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 42,
                              ),
                              Text(
                                'Log in into your account',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'Metropolis',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 35.14),
                              // Email Input Field
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(27)
                                ),
                                width: 316,
                                child: BlocBuilder<LoginBloc, LoginState>(
                                  builder: (context, state) {
                                    return TextFormField(
                                      controller: emailController,
                                      onChanged: (value) {
                                        context
                                            .read<LoginBloc>()
                                            .add(EmailChanged(value));
                                      },
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your email';
                                        } else if (!RegExp(
                                                r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                                            .hasMatch(value)) {
                                          return 'Please enter a valid email';
                                        }
                                        return null;
                                      },
                                      style: TextStyle(fontSize: 16),
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 16.32),
                              // Password Input Field
                              Container(
                                width: 316,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                    borderRadius: BorderRadius.circular(27)
                                ),
                                child: BlocBuilder<LoginBloc, LoginState>(
                                  builder: (context, state) {
                                    return TextFormField(
                                      controller: passwordController,
                                      onChanged: (value) {
                                        context
                                            .read<LoginBloc>()
                                            .add(PasswordChanged(value));
                                      },
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.fromLTRB(20, 10, 20, 10),
                                        labelText: 'Password',
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
                                      obscureText: true,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your password';
                                        } else if (value.length < 6) {
                                          return 'Password must be at least 6 characters';
                                        }
                                        return null;
                                      },
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 16.78),
                              // Login Button with Bloc
                              BlocConsumer<LoginBloc, LoginState>(
                                listener: (context, state) {
                                  if (state is LoginSuccess) {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Login successful!')),
                                    );
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation, secondaryAnimation) {
                                          return HomeScreen(); // Your target screen
                                        },
                                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                          return FadeTransition(
                                            opacity: animation, // Instant fade effect
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                  } else if (state is LoginFailure) {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(state.errorMessage)),
                                    );
                                  } else if (state is LoginLoading) {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
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
                                            if (_formKey.currentState!
                                                .validate()) {
                                              context.read<LoginBloc>().add(
                                                    LoginSubmitted(
                                                      email:
                                                          emailController.text,
                                                      password:
                                                          passwordController
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
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    child: Container(
                                      width: 316,
                                      height: 48,
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 15),
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
                                                  'Log in',
                                                  style: TextStyle(
                                                    fontSize: 15,
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
                              SizedBox(height: 17.67),
                              // Forgot Password Link
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) {
                                        return ForgotPasswordScreen(); // Your target screen
                                      },
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
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
                                            child: child
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  'Forgot your password?',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Metropolis',
                                    fontWeight: FontWeight.w400,
                                    fontSize: screenWidth * 0.04,
                                  ),
                                ),
                              ),
                              SizedBox(height: 21.08),
                              Container(
                                  width: screenWidth * 1,
                                  child: Image.asset('assets/or.png',
                                      width: 375, height: 20.25)),
                              SizedBox(height: 16.62),
                              Container(
                                width: 215.25,
                                height: 54,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildIconButton(context, 'assets/Apple.png'),
                                      SizedBox(width: 30),
                                      _buildIconButton(context, 'assets/Group 824.png'),
                                      SizedBox(width: 30),
                                      _buildIconButton(context, 'assets/Facebook.png'),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 58.98),
                              Container(
                                width: 230,
                                height: 23,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don’t have an account? ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Metropolis',
                                        fontSize: screenWidth * 0.04,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                secondaryAnimation) {
                                              return SignUpScreen(); // Your target screen
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
                                        "Sign up.",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Metropolis',
                                          fontSize: screenWidth * 0.04,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
}
Widget _buildIconButton(BuildContext context, String assetPath) {
  return IconButton(
    icon: Image.asset(assetPath),
    iconSize: 30,
    onPressed: () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return ProfileSetupScreen(); // Target screen
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Simple fade transition
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    },
  );
}

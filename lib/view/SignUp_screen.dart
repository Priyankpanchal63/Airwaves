import 'package:flutter/material.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('SignUp Screen',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
      ),
      body: Text('Sign Up Screen',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irwaves/view/splash_screen.dart';
import 'bloc/login/login_bloc.dart';
import 'view/login_screen.dart';
// Make sure to import your LoginBloc file

void main() {
  runApp(MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IRWaves',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(), // Set the initial screen here
      ),
    );
  }
}
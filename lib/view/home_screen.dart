import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Home Screen',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
      ),
      body: Text('Home Screen',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
    );
  }
}

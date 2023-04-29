import 'package:flutter/material.dart';

import 'home_todo.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  nextScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false,
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    nextScreen();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: Text('To Do\n App',
            style: TextStyle(
                fontSize: 50, fontWeight: FontWeight.bold, color: Colors.blue)),
      ),
    );
  }
}

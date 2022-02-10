import 'dart:async';

import 'package:conectemos/instructions.dart';
import 'package:conectemos/screen0.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => Instructions())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                //Colors.blue,
                //Colors.red,
                Color(0xFF971585),
                Color(0xFFE6514A),
                Color(0xFFF7AA48),
                Color(0xFFF48D49),
                Color(0xFF61C7D4),
              ],
            ),
          ),
          child: Center(
            child: Image.asset(
              'assets/logo.png',
              fit: BoxFit.contain,
              height: 96,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Instructions extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Instructions> {
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
                Colors.blue,
                Colors.red,
              ],
            ),
          ),
          child: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/screen0', arguments: {});
              },
              child: Image.asset(
                'assets/modos_de_juego.png',
                fit: BoxFit.contain,
                height: 550,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Screen0 extends StatefulWidget {
  @override
  _Screen0State createState() {
    return _Screen0State();
  }
}

class _Screen0State extends State<Screen0> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Partida')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/screen1',
                    arguments: {'nueva_partida': true});
              },
              child: const Text('Crear nueva partida',
                  style: TextStyle(fontSize: 20)),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/screen1',
                    arguments: {'nueva_partida': false});
              },
              child: const Text('Unirse a una partida',
                  style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}

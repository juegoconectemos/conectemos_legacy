import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conectemos/session.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

String nombreJugador = Session.nombreJugador;

List<dynamic> jugadores;
String pregunta = "";
String responde = "";
String textoPregunta = "";
bool iguales = false;

class Screen5 extends StatefulWidget {
  @override
  _Screen5State createState() {
    return _Screen5State();
  }
}

class _Screen5State extends State<Screen5> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      FirebaseFirestore.instance
          .collection('partidas')
          .doc(Session.codigoPartida)
          .snapshots()
          .listen((doc) {
        responde = doc.get('responde');
        pregunta = doc.get('pregunta');
        textoPregunta = doc.get('textoPregunta');

        if (responde.isEmpty && pregunta.isEmpty && textoPregunta.isEmpty) {
          // Ocurre, cuando el usuario que pregunta, está conforme con la respuesta y presionado OK
          Navigator.pushReplacementNamed(context, '/screen3');
        } else {
          if (nombreJugador == pregunta) {
            iguales = true;
          } else {
            iguales = false;
          }
        }
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen5')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Responde: ' + responde),
          Text(textoPregunta),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                onPressed: iguales
                    ? () {
                        FirebaseFirestore.instance
                            .collection('partidas')
                            .doc(Session.codigoPartida)
                            .get()
                            .then((doc) {
                          jugadores = doc.get('jugadores');
                          print(jugadores.toString());
                          int turno = Random().nextInt(jugadores.length);

                          DocumentReference partidaRef = FirebaseFirestore
                              .instance
                              .collection('partidas')
                              .doc(Session.codigoPartida);

                          partidaRef.update({
                            'pregunta': '',
                            'responde': '',
                            'textoPregunta': '',
                            'turno': turno
                          })
                              //.then((value) => Navigator.pushReplacementNamed(
                              //    context, '/screen3'))
                              .catchError((error) => print("$error"));
                        });
                      }
                    : null,
                child: const Text('OK', style: TextStyle(fontSize: 20)),
              ),
            ],
          )
        ],
      ),
    );
  }
}

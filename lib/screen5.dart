import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conectemos/session.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

String nombreJugador = '';

List<dynamic> jugadores;
List<dynamic> colores;
String pregunta = "";
String responde = "";
String nombreJugadorTurno = '';

String textoPregunta = "";
String colorTurno = '';

bool iguales = false;

String imagenBarraJugador = 'assets/barra_nombre.png';

class Screen5 extends StatefulWidget {
  @override
  _Screen5State createState() {
    return _Screen5State();
  }
}

class _Screen5State extends State<Screen5> {
  bool iconoCorazonSelected = false;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      FirebaseFirestore.instance
          .collection('partidas')
          .doc(Session.codigoPartida)
          .snapshots()
          .listen((doc) {
        jugadores = doc.get('jugadores');
        colores = doc.get('colores');
        int turno = doc.get('turno');

        responde = doc.get('responde');
        pregunta = doc.get('pregunta');
        textoPregunta = doc.get('textoPregunta');

        nombreJugador = Session.nombreJugador;
        nombreJugadorTurno = jugadores[turno];
        colorTurno = colores[turno];

        if (responde.isEmpty && pregunta.isEmpty && textoPregunta.isEmpty) {
          // Ocurre cuando el usuario que pregunta está conforme con la respuesta y presionado OK
          Navigator.pushReplacementNamed(context, '/screen3');
          // Hace que se cierre el screen5 a todos los jugadores
        } else {
          if (nombreJugador == pregunta) {
            iguales = true;
          } else {
            iguales = false;
          }
        }

        print('Screen5 - iguales: ' + iguales.toString());

        switch (colorTurno) {
          case 'amarillo':
            imagenBarraJugador = 'assets/barra_jugador_amarillo.png';
            break;

          case 'azul':
            imagenBarraJugador = 'assets/barra_jugador_azul.png';
            break;

          case 'calipso':
            imagenBarraJugador = 'assets/barra_jugador_calipso.png';
            break;

          case 'naranjo':
            imagenBarraJugador = 'assets/barra_jugador_naranjo.png';
            break;

          case 'negro':
            imagenBarraJugador = 'assets/barra_jugador_negro.png';
            break;

          case 'pistacho':
            imagenBarraJugador = 'assets/barra_jugador_pistacho.png';
            break;

          case 'rojo':
            imagenBarraJugador = 'assets/barra_jugador_rojo.png';
            break;

          case 'rosado':
            imagenBarraJugador = 'assets/barra_jugador_rosado.png';
            break;

          case 'verde_musgo':
            imagenBarraJugador = 'assets/barra_jugador_verde_musgo.png';
            break;

          case 'verde':
            imagenBarraJugador = 'assets/barra_jugador_verde.png';
            break;

          case 'violeta':
            imagenBarraJugador = 'assets/barra_jugador_violeta.png';
            break;

          case 'morado':
            imagenBarraJugador = 'assets/barra_jugador_morado.png';
            break;
        }

        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Screen5 - $nombreJugador')),
      body: Container(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Text('Responde: ' + responde),
            Column(
              children: [
                (responde == 'TODOS')
                    ? Text(
                        'RESPONDEN',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 15),
                      )
                    : Text(
                        'RESPONDE',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 15),
                      ),
                Stack(alignment: Alignment.center, children: <Widget>[
                  (responde == 'TODOS')
                      ? Image.asset(
                          'assets/barra_con_color_todos_responden.png',
                          width: 200,
                        )
                      : (responde == nombreJugadorTurno)
                          ? Image.asset(
                              imagenBarraJugador,
                              width: 200,
                            )
                          : Image.asset(
                              'assets/barra_nombre.png',
                              width: 200,
                            ),
                  Text(
                    responde,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: iconoCorazonSelected
                          ? Image.asset('assets/icono_corazon_pintado.png')
                          : Image.asset('assets/icono_corazon.png'),
                      onPressed: () {
                        setState(() {
                          iconoCorazonSelected = !iconoCorazonSelected;
                        });
                      },
                    ),
                    SizedBox(
                      width: 90,
                    ),
                  ],
                ),
              ],
            ),

            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/circulo_preguntas.png',
                  width: 300,
                ),
                Container(
                  width: 200,
                  child: Text(
                    textoPregunta,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            //Text(textoPregunta),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Image.asset('assets/icono_ok.png'),
                  iconSize: 70,
                  onPressed: iguales
                      ? () {
                          FirebaseFirestore.instance
                              .collection('partidas')
                              .doc(Session.codigoPartida)
                              .get()
                              .then((doc) {
                            jugadores = doc.get('jugadores');
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
                                .catchError((error) =>
                                    print("Screen5 - Error: $error"));
                          });
                        }
                      : null,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

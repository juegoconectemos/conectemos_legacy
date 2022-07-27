import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conectemos/session.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:circle_list/circle_list.dart';
//import 'package:flutter_svg/flutter_svg.dart';

String nombreJugador = '';

List<dynamic> jugadores;
List<dynamic> colores;
String responde = '';
String pregunta = '';
String nombreJugadorTurno = '';
String colorTurno = '';
bool iguales = false;

String imagenBarraJugador = 'assets/barra_nombre.png';

List<Image> circulos = [];

class Screen3 extends StatefulWidget {
  @override
  _Screen3State createState() {
    return _Screen3State();
  }
}

class _Screen3State extends State<Screen3> {
  /*List<Image> circulos = [
    Image.asset(
      'assets/jugador_amarillo.png',
      width: 70,
    ),
    Image.asset(
      'assets/jugador_azul.png',
      width: 70,
    ),
    Image.asset(
      'assets/jugador_calipso.png',
      width: 70,
    ),
    Image.asset(
      'assets/jugador_naranjo.png',
      width: 70,
    ),
    Image.asset(
      'assets/jugador_negro.png',
      width: 70,
    ),
    Image.asset(
      'assets/jugador_pistacho.png',
      width: 70,
    ),
    Image.asset(
      'assets/jugador_rojo.png',
      width: 70,
    ),
    Image.asset(
      'assets/jugador_rosado.png',
      width: 70,
    ),
    Image.asset(
      'assets/jugador_verde_musgo.png',
      width: 70,
    ),
    Image.asset(
      'assets/jugador_verde.png',
      width: 70,
    ),
    Image.asset(
      'assets/jugador_violeta.png',
      width: 70,
    ),
    Image.asset(
      'assets/jugador_morado.png',
      width: 70,
    )
  ];*/

  CollectionReference users;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print('Screen3 - código de la partida: ' + Session.codigoPartida);

      FirebaseFirestore.instance
          .collection('partidas')
          .doc(Session.codigoPartida)
          .snapshots()
          .listen((doc) {
        jugadores = doc.get('jugadores');
        colores = doc.get('colores');

        print('Screen3 - Listado de jugadores actualizado: ' +
            jugadores.toString());
        print(
            'Screen3 - Listado de colores actualizado: ' + colores.toString());

        int turno = doc.get('turno');

        nombreJugador = Session.nombreJugador;
        nombreJugadorTurno = jugadores[turno];
        colorTurno = colores[turno];

        if (nombreJugador.isNotEmpty &&
            nombreJugadorTurno.isNotEmpty &&
            nombreJugador == nombreJugadorTurno) {
          iguales = true;
        } else {
          iguales = false;
        }

        print('Screen3 - nombreJugador: ' + nombreJugador.toString());
        print('Screen3 - nombreJugadorTurno: ' + nombreJugadorTurno.toString());
        print('Screen3 - iguales: ' + iguales.toString());

        responde = doc.get('responde');
        pregunta = doc.get('pregunta');

        if (responde.isNotEmpty && pregunta.isNotEmpty) {
          Navigator.pushReplacementNamed(context, '/screen4');
        } else {
          print('Screen3 - responde no está definido aún');
          print('Screen3 - pregunta no está definido aún');
        }

        circulos = List<Image>.generate(
            colores.length,
            (index) => Image.asset('assets/jugador_' + colores[index] + '.png',
                width: 70));

        print('Screen3: ' + circulos.toString());

        switch (colorTurno) {
          case 'amarillo':
            circulos[turno] = Image.asset(
              'assets/jugador_amarillo_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_amarillo.png';
            break;
          case 'azul':
            circulos[turno] = Image.asset(
              'assets/jugador_azul_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_azul.png';

            break;
          case 'calipso':
            circulos[turno] = Image.asset(
              'assets/jugador_calipso_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_calipso.png';

            break;
          case 'naranjo':
            circulos[turno] = Image.asset(
              'assets/jugador_naranjo_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_naranjo.png';

            break;
          case 'negro':
            circulos[turno] = Image.asset(
              'assets/jugador_negro_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_negro.png';

            break;
          case 'pistacho':
            circulos[turno] = Image.asset(
              'assets/jugador_pistacho_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_pistacho.png';

            break;
          case 'rojo':
            circulos[turno] = Image.asset(
              'assets/jugador_rojo_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_rojo.png';

            break;
          case 'rosado':
            circulos[turno] = Image.asset(
              'assets/jugador_rosado_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_rosado.png';

            break;
          case 'verde_musgo':
            circulos[turno] = Image.asset(
              'assets/jugador_verde_musgo_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_verde_musgo.png';

            break;
          case 'verde':
            circulos[turno] = Image.asset(
              'assets/jugador_verde_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_verde.png';

            break;
          case 'violeta':
            circulos[turno] = Image.asset(
              'assets/jugador_violeta_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_violeta.png';

            break;
          case 'morado':
            circulos[turno] = Image.asset(
              'assets/jugador_morado_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_morado.png';

            break;
        }

        if (Session.comodin1ocupado == true &&
            Session.comodin2ocupado == true &&
            Session.comodin3ocupado == true) {
          Session.comodin1ocupado = false;
          Session.comodin2ocupado = false;
          Session.comodin3ocupado = false;
        }

        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Screen3 - $nombreJugador')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              //Colors.blue,
              //Colors.red,
              Color(0xFF00003C),
              Color(0xFF091855),
              Color(0xFF1D5E7F),
              Color(0xFF635783),
              Color(0xFFB2656C),
              Color(0xFFFDD793),
            ],
          ),
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  'TURNO',
                  style: TextStyle(
                    fontFamily: "GillSans",
                    fontSize: 21,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Stack(alignment: Alignment.center, children: <Widget>[
                  Image.asset(
                    //'assets/barra_jugador_amarillo.png',
                    imagenBarraJugador,
                    width: 300,
                  ),
                  Text(
                    nombreJugadorTurno,
                    style: TextStyle(
                      fontFamily: "GillSans",
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Image.asset('assets/icono_boton_off_salir.png'),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('partidas')
                            .doc(Session.codigoPartida)
                            .get()
                            .then((doc) {
                          jugadores = doc.get('jugadores');

                          int turnoActual = doc.get('turno');

                          int turnoSiguiente = turnoActual + 1;

                          if (turnoSiguiente > jugadores.length - 1) {
                            turnoSiguiente = 0;
                          }

                          DocumentReference partidaRef = FirebaseFirestore
                              .instance
                              .collection('partidas')
                              .doc(Session.codigoPartida);

                          partidaRef
                              .update({
                                'colores': FieldValue.arrayRemove(
                                    [Session.colorSeleccionado]),
                                'jugadores': FieldValue.arrayRemove(
                                    [Session.nombreJugador]),
                                'turno': turnoSiguiente
                              })
                              .then((value) => Navigator.pushReplacementNamed(
                                  context, '/screen0'))
                              .catchError(
                                  (error) => print("Screen3 - Error: $error"));
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
            CircleList(
              origin: Offset(0, 0),
              innerRadius: 100,
              outerRadius: 180,
              rotateMode: RotateMode.stopRotate,
              children: circulos,
              centerWidget: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/disco_elige_tu_comodin.png',
                    width: 200,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: false
                      ? Visibility(
                          child: Image.asset('assets/icono_tus_cartas.png'),
                          visible: false)
                      : Visibility(
                          child:
                              Image.asset('assets/icono_tus_cartas_opaco.png'),
                          visible: false),
                  iconSize: 70,
                  onPressed: null,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: (iguales && Session.comodin1ocupado == false)
                      ? Image.asset('assets/icono_respondo.png')
                      : Image.asset('assets/icono_respondo_opaco.png'),
                  iconSize: 70,
                  onPressed: (iguales && Session.comodin1ocupado == false)
                      ? () {
                          Random random = Random();
                          int jugadorAleatorio =
                              random.nextInt(jugadores.length);

                          print("Total jugadores: " +
                              (jugadores.length).toString());
                          print("Jugador aleatorio: " +
                              jugadorAleatorio.toString());
                          print("Nombre del jugador: " +
                              jugadores[jugadorAleatorio]);

                          Navigator.pop(
                              context); // quita el alertdialog antes de pasar a
                          //la siguiente ventana
                          FirebaseFirestore.instance
                              .collection('partidas')
                              .doc(Session.codigoPartida)
                              .update({
                            'responde': nombreJugadorTurno,
                            'pregunta': jugadores[jugadorAleatorio]
                          }).then((value) => Session.comodin1ocupado = true);
                        }
                      : null,
                ),
                IconButton(
                  icon: (iguales && Session.comodin2ocupado == false)
                      ? Image.asset('assets/icono_todos.png')
                      : Image.asset('assets/icono_todos_opaco.png'),
                  iconSize: 70,
                  onPressed: (iguales && Session.comodin2ocupado == false)
                      ? () {
                          FirebaseFirestore.instance
                              .collection('partidas')
                              //.doc('zwdlumIJuXKNVTXHiRYP')
                              .doc(Session.codigoPartida)
                              .update({
                            'responde': 'TODOS',
                            'pregunta': nombreJugadorTurno
                          }).then((value) => Session.comodin2ocupado = true);
                        }
                      : null,
                ),
                IconButton(
                  icon: (iguales && Session.comodin3ocupado == false)
                      ? Image.asset('assets/icono_pregunto.png')
                      : Image.asset('assets/icono_pregunto_opaco.png'),
                  iconSize: 70,
                  onPressed: (iguales && Session.comodin3ocupado == false)
                      ? () {
                          _showMessageDialogPregunto(
                              context, 'Elige quién responde');
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

  Widget setupAlertDialoadContainerRespondo() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: jugadores.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(jugadores[index]),
            onTap: () {
              Navigator.pop(context); // quita el alertdialog antes de pasar a

              FirebaseFirestore.instance
                  .collection('partidas')
                  //.doc('zwdlumIJuXKNVTXHiRYP')
                  .doc(Session.codigoPartida)
                  .update({
                'responde': nombreJugadorTurno,
                'pregunta': jugadores[index]
              }).then((value) => Session.comodin1ocupado = true);
            },
          );
        },
      ),
    );
  }

  _showMessageDialogRespondo(BuildContext context, String titulo) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(titulo),
          content: setupAlertDialoadContainerRespondo(),
        ),
      );

  Widget setupAlertDialoadContainerPregunto() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: jugadores.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(jugadores[index]),
            onTap: () {
              Navigator.pop(context); // quita el alertdialog antes de pasar a
              //la siguiente ventana

              FirebaseFirestore.instance
                  .collection('partidas')
                  //.doc('zwdlumIJuXKNVTXHiRYP')
                  .doc(Session.codigoPartida)
                  .update({
                'responde': jugadores[index],
                'pregunta': nombreJugadorTurno
              }).then((value) => Session.comodin3ocupado = true);
            },
          );
        },
      ),
    );
  }

  _showMessageDialogPregunto(BuildContext context, String titulo) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(titulo),
          content: setupAlertDialoadContainerPregunto(),
        ),
      );
}

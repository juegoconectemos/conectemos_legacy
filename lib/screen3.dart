import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conectemos/session.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

String nombreJugador = Session.nombreJugador;

List<dynamic> jugadores;
String responde = '';
String pregunta = '';
String nombreJugadorTurno = '';
bool iguales = false;

class Screen3 extends StatefulWidget {
  @override
  _Screen3State createState() {
    return _Screen3State();
  }
}

class _Screen3State extends State<Screen3> {
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
        print('Screen3 - Listado de jugadores actualizado: ' +
            jugadores.toString());
        int turno = doc.get('turno');

        nombreJugadorTurno = jugadores[turno];

        if (nombreJugador.isNotEmpty &&
            nombreJugadorTurno.isNotEmpty &&
            nombreJugador == nombreJugadorTurno) {
          iguales = true;
        } else {
          iguales = false;
        }

        responde = doc.get('responde');
        pregunta = doc.get('pregunta');

        if (responde.isNotEmpty && pregunta.isNotEmpty) {
          Navigator.pushReplacementNamed(context, '/screen4');
        } else {
          print('Screen3 - responde no está definido aún');
          print('Screen3 - pregunta no está definido aún');
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
              Colors.blue,
              Colors.red,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Text('Turno: ' + nombreJugadorTurno),
            Column(
              children: [
                Text(
                  'TURNO',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 15),
                ),
                Stack(alignment: Alignment.center, children: <Widget>[
                  Image.asset(
                    'assets/barra_jugador_verde.png',
                    width: 200,
                  ),
                  Text(
                    nombreJugadorTurno,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ]),
              ],
            ),

            //Text('Elige tu comodín'),

            Stack(alignment: Alignment.center, children: <Widget>[
              Image.asset(
                'assets/disco_central_para_texto2.png',
                width: 200,
              ),
              Text(
                'ELIJE TU\nCOMODÍN',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
              ),
            ]),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: iguales
                      ? Image.asset('assets/icono_respondo.png')
                      : Image.asset('assets/icono_respondo_opaco.png'),
                  iconSize: 100,
                  onPressed: iguales
                      ? () {
                          _showMessageDialogRespondo(
                              context, 'Elige quién pregunta');
                        }
                      : null,
                ),
                IconButton(
                  icon: iguales
                      ? Image.asset('assets/icono_todos.png')
                      : Image.asset('assets/icono_todos_opaco.png'),
                  iconSize: 100,
                  onPressed: iguales
                      ? () {
                          FirebaseFirestore.instance
                              .collection('partidas')
                              //.doc('zwdlumIJuXKNVTXHiRYP')
                              .doc(Session.codigoPartida)
                              .update({
                            'responde': 'TODOS',
                            'pregunta': nombreJugadorTurno
                          });
                        }
                      : null,
                ),
                IconButton(
                  icon: iguales
                      ? Image.asset('assets/icono_pregunto.png')
                      : Image.asset('assets/icono_pregunto_opaco.png'),
                  iconSize: 100,
                  onPressed: iguales
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
              });
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
              });
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

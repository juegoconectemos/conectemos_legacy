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
      print(Session.codigoPartida);

      FirebaseFirestore.instance
          .collection('partidas')
          .doc(Session.codigoPartida)
          .snapshots()
          .listen((doc) {
        jugadores = doc.get('jugadores');
        print(jugadores.toString());
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
          print("responde no está definido aún");
          print("pregunta no está definido aún");
        }

        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen3')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Turno: ' + nombreJugadorTurno),
          Text('Elige tu comodín'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                onPressed: iguales
                    ? () {
                        _showMessageDialogRespondo(
                            context, 'Elige quién pregunta');
                      }
                    : null,
                child: const Text('R', style: TextStyle(fontSize: 20)),
              ),
              RaisedButton(
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
                child: const Text('T', style: TextStyle(fontSize: 20)),
              ),
              RaisedButton(
                onPressed: iguales
                    ? () {
                        _showMessageDialogPregunto(
                            context, 'Elige quién responde');
                      }
                    : null,
                child: const Text('P', style: TextStyle(fontSize: 20)),
              ),
            ],
          )
        ],
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

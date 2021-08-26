import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conectemos/screen5.dart';
import 'package:conectemos/session.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

String nombreJugador = Session.nombreJugador;

/*List<String> preguntas = [
  '¿Quién es tu mejor amigo?',
  '¿Cuál es tu color favorito?',
  '¿Cuál es tu fruta favorita?'
];*/
List<String> preguntas = [
  '¿Te gustan los cambios o te resistes?',
  '¿Que tanto te conoce la gente que te rodea?',
  '¿Sueles vivir más en el presente, pasado o futuro?',
  '¿El desafío más complejo?',
  '¿Te gustaría viajar en astral y salir de tu cuerpo, o preferirías no vivir esa experiencia?',
  '¿De qué dudas?',
  '¿Quién es la mejor persona que conoces?',
  '¿La aventura es parte de tu vida?',
  '¿La mejor noticia que has recibido?',
  '¿Que extrañas del pasado?',
  '¿Cómo es la relación con tu madre?',
  '¿Si todo es posible, que te gustaría se hiciera realidad?',
  '¿Te gusta lo que estás viviendo?',
  '¿Cómo imaginas lo que viene después de la muerte?',
  '¿Qué te inspira?',
  '¿Qué te intriga?',
  '¿Tienes alguna conversación pendiente?',
  '¿Quién o qué te alegra la vida?',
  'Un libro o una película significativa para ti',
  '¿Qué es imprescindible para ti?',
];

String pregunta = "";
String responde = "";

class Screen4 extends StatefulWidget {
  @override
  _Screen4State createState() {
    return _Screen4State();
  }
}

class _Screen4State extends State<Screen4> {
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
        print('Screen4 - responde: ' + responde);
        pregunta = doc.get('pregunta');
        print('Screen4 - pregunta: ' + pregunta);

        if (nombreJugador == pregunta) {
          iguales = true;
        } else {
          iguales = false;
        }

        textoPregunta = doc.get('textoPregunta');

        if (textoPregunta.isNotEmpty) {
          Navigator.pushReplacementNamed(context, '/screen5');
        } else {
          print('Screen4 - textoPregunta no está definido aún');
        }
      });
      setState(() {}); // NO SE SI VA DENTRO DEL {} anterior o no
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen4 - $nombreJugador')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Responde: ' + responde),
          Text('Pregunta: ' + pregunta),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                onPressed: iguales
                    ? () {
                        _showMessageDialog(context, 'Elige la pregunta');
                      }
                    : null,
                child: const Text('Elegir pregunta',
                    style: TextStyle(fontSize: 20)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget setupAlertDialoadContainer() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: preguntas.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(preguntas[index]),
            onTap: () {
              Navigator.pop(context); // quita el alertdialog antes de pasar a
              //la siguiente ventana
              FirebaseFirestore.instance
                  .collection('partidas')
                  .doc(Session.codigoPartida)
                  .update({'textoPregunta': preguntas[index]});
            },
          );
        },
      ),
    );
  }

  _showMessageDialog(BuildContext context, String titulo) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(titulo),
          content: setupAlertDialoadContainer(),
        ),
      );
}

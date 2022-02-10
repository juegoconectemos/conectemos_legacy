import 'package:circle_list/circle_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conectemos/screen5.dart';
import 'package:conectemos/session.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

String nombreJugador = '';

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

List<dynamic> jugadores;
List<dynamic> colores;
String pregunta = '';
String responde = '';
String nombreJugadorTurno = '';
String colorTurno = '';

String imagenBarraJugador = 'assets/barra_nombre.png';

class Screen4 extends StatefulWidget {
  @override
  _Screen4State createState() {
    return _Screen4State();
  }
}

class _Screen4State extends State<Screen4> {
  List<Image> circulos = [
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
  ];

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
        print('Screen4 - responde: ' + responde);
        pregunta = doc.get('pregunta');
        print('Screen4 - pregunta: ' + pregunta);

        nombreJugador = Session.nombreJugador;
        nombreJugadorTurno = jugadores[turno];
        colorTurno = colores[turno];

        if (nombreJugador == pregunta) {
          iguales = true;
        } else {
          iguales = false;
        }
        print('Screen4 - iguales: ' + iguales.toString());

        textoPregunta = doc.get('textoPregunta');

        if (textoPregunta.isNotEmpty) {
          Navigator.pushReplacementNamed(context, '/screen5');
        } else {
          print('Screen4 - textoPregunta no está definido aún');
        }

        switch (colorTurno) {
          case 'amarillo':
            circulos[0] = Image.asset(
              'assets/jugador_amarillo_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_amarillo.png';
            break;
          case 'azul':
            circulos[1] = Image.asset(
              'assets/jugador_azul_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_azul.png';

            break;
          case 'calipso':
            circulos[2] = Image.asset(
              'assets/jugador_calipso_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_calipso.png';

            break;
          case 'naranjo':
            circulos[3] = Image.asset(
              'assets/jugador_naranjo_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_naranjo.png';

            break;
          case 'negro':
            circulos[4] = Image.asset(
              'assets/jugador_negro_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_negro.png';

            break;
          case 'pistacho':
            circulos[5] = Image.asset(
              'assets/jugador_pistacho_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_pistacho.png';

            break;
          case 'rojo':
            circulos[6] = Image.asset(
              'assets/jugador_rojo_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_rojo.png';

            break;
          case 'rosado':
            circulos[7] = Image.asset(
              'assets/jugador_rosado_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_rosado.png';

            break;
          case 'verde_musgo':
            circulos[8] = Image.asset(
              'assets/jugador_verde_musgo_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_verde_musgo.png';

            break;
          case 'verde':
            circulos[9] = Image.asset(
              'assets/jugador_verde_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_verde.png';

            break;
          case 'violeta':
            circulos[10] = Image.asset(
              'assets/jugador_violeta_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_violeta.png';

            break;
          case 'morado':
            circulos[11] = Image.asset(
              'assets/jugador_morado_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_morado.png';

            break;
        }
        setState(() {}); // NO SE SI VA DENTRO DEL {} anterior o no
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Screen4 - $nombreJugador')),
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
                            fontFamily: 'GillSans',
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 21),
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
                  (responde == 'TODOS')
                      ? Image.asset(
                          'assets/disco_central_para_todos.png',
                          width: 200,
                        )
                      : Image.asset(
                          'assets/disco_central_para_uno.png',
                          width: 200,
                        ),
                ],
              ),
            ),
            //Text('Pregunta: ' + pregunta),
            Column(
              children: [
                Text(
                  'PREGUNTA',
                  style: TextStyle(
                      fontFamily: "GillSans",
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 21),
                ),
                Stack(alignment: Alignment.center, children: <Widget>[
                  (pregunta == nombreJugadorTurno)
                      ? Image.asset(
                          imagenBarraJugador,
                          width: 200,
                        )
                      : Image.asset(
                          'assets/barra_nombre.png',
                          width: 200,
                        ),
                  Text(
                    pregunta,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ]),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: iguales
                      ? Image.asset('assets/icono_tus_cartas.png')
                      : Image.asset('assets/icono_tus_cartas_opaco.png'),
                  iconSize: 70,
                  onPressed: iguales
                      ? () {
                          _showMessageDialog(context, 'Elige la pregunta');
                        }
                      : null,
                )
              ],
            )
          ],
        ),
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

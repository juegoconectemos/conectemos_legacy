import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conectemos/session.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:circle_list/circle_list.dart';
//import 'package:flutter_svg/flutter_svg.dart';

String nombreJugador = '';

List<dynamic> jugadores;
String responde = '';
String pregunta = '';
String nombreJugadorTurno = '';
bool iguales = false;

String imagenBarraJugador =
    'assets/barra_jugador_amarillo.png'; // por defecto cargará la barra con la ficha amarilla pero luego cambiara a la seleccionada por el usuario

class Screen3 extends StatefulWidget {
  @override
  _Screen3State createState() {
    return _Screen3State();
  }
}

class _Screen3State extends State<Screen3> {
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

        nombreJugador = Session.nombreJugador;
        nombreJugadorTurno = jugadores[turno];

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

        switch (Session.colorSeleccionado) {
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
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                    //'assets/barra_jugador_amarillo.png',
                    imagenBarraJugador,
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
            CircleList(
              origin: Offset(0, 0),
              innerRadius: 80,
              outerRadius: 180,
              rotateMode: RotateMode.stopRotate,
              children: circulos,
              centerWidget: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/disco_central_para_texto2.png',
                    width: 200,
                  ),
                  Text(
                    'ELIGE TU\nCOMODÍN',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: false
                      ? Image.asset('assets/icono_tus_cartas.png')
                      : Image.asset('assets/icono_tus_cartas_opaco.png'),
                  iconSize: 70,
                  onPressed: null,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: iguales
                      ? Image.asset('assets/icono_respondo.png')
                      : Image.asset('assets/icono_respondo_opaco.png'),
                  iconSize: 70,
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
                  iconSize: 70,
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
                  iconSize: 70,
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

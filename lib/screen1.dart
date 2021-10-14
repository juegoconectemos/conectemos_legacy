import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conectemos/session.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() {
    return _Screen1State();
  }
}

class _Screen1State extends State<Screen1> {
  bool amarilloSeleccionado = false;
  bool azulSeleccionado = false;
  bool calipsoSeleccionado = false;
  bool naranjoSeleccionado = false;
  bool negroSeleccionado = false;
  bool pistachoSeleccionado = false;
  bool rojoSeleccionado = false;
  bool rosadoSeleccionado = false;
  bool verdeMusgoSeleccionado = false;
  bool verdeSeleccionado = false;
  bool violetaSeleccionado = false;
  bool moradoSeleccionado = false;

  bool esNuevaPartida;

  TextEditingController codigoPartidaController = TextEditingController()
    ..text = '';
  TextEditingController nombreJugadorController = TextEditingController()
    ..text = '';

  void createPartida() async {
    DocumentReference documentRef =
        await FirebaseFirestore.instance.collection('partidas').add({
      'pregunta': '',
      'responde': '',
      'textoPregunta': '',
      'timestamp': FieldValue.serverTimestamp(),
      'turno': 0,
    });
    Session.codigoPartida = documentRef.id;
    print("Screen1 - Partida nueva creada: " + Session.codigoPartida);
    print("Screen1 - Nombre del jugador: " + Session.nombreJugador);
    codigoPartidaController.text = Session.codigoPartida;
  }

  @override
  void initState() {
    super.initState();
    //No aseguramos de resetear estas dos variables de sesión
    Session.codigoPartida = '';
    Session.nombreJugador = '';
    Session.colorSeleccionado = '';

    Firebase.initializeApp().whenComplete(() {
      print("Screen1 - Firebase Iniciado");
      Map args = ModalRoute.of(context).settings.arguments;
      if (args['nueva_partida'] != null) {
        esNuevaPartida = args['nueva_partida'];
        if (esNuevaPartida == true) {
          print('Screen1 - Creando nueva partida...');
          createPartida();
        } else {
          print('Screen1 - No es nueva partida');
        }
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> circulos = [
      IconButton(
        icon: amarilloSeleccionado
            ? Image.asset(
                'assets/jugador_amarillo_con_circulo.png',
              )
            : Image.asset('assets/jugador_amarillo.png'),
        iconSize: 60,
        onPressed: () {
          setState(
            () {
              amarilloSeleccionado = true;
              azulSeleccionado = false;
              calipsoSeleccionado = false;
              naranjoSeleccionado = false;
              negroSeleccionado = false;
              pistachoSeleccionado = false;
              rojoSeleccionado = false;
              rosadoSeleccionado = false;
              verdeMusgoSeleccionado = false;
              verdeSeleccionado = false;
              violetaSeleccionado = false;
              moradoSeleccionado = false;

              Session.colorSeleccionado = 'amarillo';
            },
          );
        },
      ),
      IconButton(
        icon: azulSeleccionado
            ? Image.asset(
                'assets/jugador_azul_con_circulo.png',
              )
            : Image.asset('assets/jugador_azul.png'),
        iconSize: 60,
        onPressed: () {
          setState(
            () {
              amarilloSeleccionado = false;
              azulSeleccionado = true;
              calipsoSeleccionado = false;
              naranjoSeleccionado = false;
              negroSeleccionado = false;
              pistachoSeleccionado = false;
              rojoSeleccionado = false;
              rosadoSeleccionado = false;
              verdeMusgoSeleccionado = false;
              verdeSeleccionado = false;
              violetaSeleccionado = false;
              moradoSeleccionado = false;

              Session.colorSeleccionado = 'azul';
            },
          );
        },
      ),
      IconButton(
        icon: calipsoSeleccionado
            ? Image.asset(
                'assets/jugador_calipso_con_circulo.png',
              )
            : Image.asset('assets/jugador_calipso.png'),
        iconSize: 60,
        onPressed: () {
          setState(
            () {
              amarilloSeleccionado = false;
              azulSeleccionado = false;
              calipsoSeleccionado = true;
              naranjoSeleccionado = false;
              negroSeleccionado = false;
              pistachoSeleccionado = false;
              rojoSeleccionado = false;
              rosadoSeleccionado = false;
              verdeMusgoSeleccionado = false;
              verdeSeleccionado = false;
              violetaSeleccionado = false;
              moradoSeleccionado = false;

              Session.colorSeleccionado = 'calipso';
            },
          );
        },
      ),
      IconButton(
        icon: naranjoSeleccionado
            ? Image.asset(
                'assets/jugador_naranjo_con_circulo.png',
              )
            : Image.asset('assets/jugador_naranjo.png'),
        iconSize: 60,
        onPressed: () {
          setState(
            () {
              amarilloSeleccionado = false;
              azulSeleccionado = false;
              calipsoSeleccionado = false;
              naranjoSeleccionado = true;
              negroSeleccionado = false;
              pistachoSeleccionado = false;
              rojoSeleccionado = false;
              rosadoSeleccionado = false;
              verdeMusgoSeleccionado = false;
              verdeSeleccionado = false;
              violetaSeleccionado = false;
              moradoSeleccionado = false;

              Session.colorSeleccionado = 'naranjo';
            },
          );
        },
      ),
      IconButton(
        icon: negroSeleccionado
            ? Image.asset(
                'assets/jugador_negro_con_circulo.png',
              )
            : Image.asset('assets/jugador_negro.png'),
        iconSize: 60,
        onPressed: () {
          setState(
            () {
              amarilloSeleccionado = false;
              azulSeleccionado = false;
              calipsoSeleccionado = false;
              naranjoSeleccionado = false;
              negroSeleccionado = true;
              pistachoSeleccionado = false;
              rojoSeleccionado = false;
              rosadoSeleccionado = false;
              verdeMusgoSeleccionado = false;
              verdeSeleccionado = false;
              violetaSeleccionado = false;
              moradoSeleccionado = false;

              Session.colorSeleccionado = 'negro';
            },
          );
        },
      ),
      IconButton(
        icon: pistachoSeleccionado
            ? Image.asset(
                'assets/jugador_pistacho_con_circulo.png',
              )
            : Image.asset('assets/jugador_pistacho.png'),
        iconSize: 60,
        onPressed: () {
          setState(
            () {
              amarilloSeleccionado = false;
              azulSeleccionado = false;
              calipsoSeleccionado = false;
              naranjoSeleccionado = false;
              negroSeleccionado = false;
              pistachoSeleccionado = true;
              rojoSeleccionado = false;
              rosadoSeleccionado = false;
              verdeMusgoSeleccionado = false;
              verdeSeleccionado = false;
              violetaSeleccionado = false;
              moradoSeleccionado = false;

              Session.colorSeleccionado = 'pistacho';
            },
          );
        },
      ),
      IconButton(
        icon: rojoSeleccionado
            ? Image.asset(
                'assets/jugador_rojo_con_circulo.png',
              )
            : Image.asset('assets/jugador_rojo.png'),
        iconSize: 60,
        onPressed: () {
          setState(
            () {
              amarilloSeleccionado = false;
              azulSeleccionado = false;
              calipsoSeleccionado = false;
              naranjoSeleccionado = false;
              negroSeleccionado = false;
              pistachoSeleccionado = false;
              rojoSeleccionado = true;
              rosadoSeleccionado = false;
              verdeMusgoSeleccionado = false;
              verdeSeleccionado = false;
              violetaSeleccionado = false;
              moradoSeleccionado = false;

              Session.colorSeleccionado = 'rojo';
            },
          );
        },
      ),
      IconButton(
        icon: rosadoSeleccionado
            ? Image.asset(
                'assets/jugador_rosado_con_circulo.png',
              )
            : Image.asset('assets/jugador_rosado.png'),
        iconSize: 60,
        onPressed: () {
          setState(
            () {
              amarilloSeleccionado = false;
              azulSeleccionado = false;
              calipsoSeleccionado = false;
              naranjoSeleccionado = false;
              negroSeleccionado = false;
              pistachoSeleccionado = false;
              rojoSeleccionado = false;
              rosadoSeleccionado = true;
              verdeMusgoSeleccionado = false;
              verdeSeleccionado = false;
              violetaSeleccionado = false;
              moradoSeleccionado = false;
            },
          );
        },
      ),
      IconButton(
        icon: verdeMusgoSeleccionado
            ? Image.asset(
                'assets/jugador_verde_musgo_con_circulo.png',
              )
            : Image.asset('assets/jugador_verde_musgo.png'),
        iconSize: 60,
        onPressed: () {
          setState(
            () {
              amarilloSeleccionado = false;
              azulSeleccionado = false;
              calipsoSeleccionado = false;
              naranjoSeleccionado = false;
              negroSeleccionado = false;
              pistachoSeleccionado = false;
              rojoSeleccionado = false;
              rosadoSeleccionado = false;
              verdeMusgoSeleccionado = true;
              verdeSeleccionado = false;
              violetaSeleccionado = false;
              moradoSeleccionado = false;

              Session.colorSeleccionado = "verde_musgo";
            },
          );
        },
      ),
      IconButton(
        icon: verdeSeleccionado
            ? Image.asset(
                'assets/jugador_verde_con_circulo.png',
              )
            : Image.asset('assets/jugador_verde.png'),
        iconSize: 60,
        onPressed: () {
          setState(
            () {
              amarilloSeleccionado = false;
              azulSeleccionado = false;
              calipsoSeleccionado = false;
              naranjoSeleccionado = false;
              negroSeleccionado = false;
              pistachoSeleccionado = false;
              rojoSeleccionado = false;
              rosadoSeleccionado = false;
              verdeMusgoSeleccionado = false;
              verdeSeleccionado = true;
              violetaSeleccionado = false;
              moradoSeleccionado = false;

              Session.colorSeleccionado = "verde";
            },
          );
        },
      ),
      IconButton(
        icon: violetaSeleccionado
            ? Image.asset(
                'assets/jugador_violeta_con_circulo.png',
              )
            : Image.asset('assets/jugador_violeta.png'),
        iconSize: 60,
        onPressed: () {
          setState(
            () {
              amarilloSeleccionado = false;
              azulSeleccionado = false;
              calipsoSeleccionado = false;
              naranjoSeleccionado = false;
              negroSeleccionado = false;
              pistachoSeleccionado = false;
              rojoSeleccionado = false;
              rosadoSeleccionado = false;
              verdeMusgoSeleccionado = false;
              verdeSeleccionado = false;
              violetaSeleccionado = true;
              moradoSeleccionado = false;

              Session.colorSeleccionado = "violeta";
            },
          );
        },
      ),
      IconButton(
        icon: moradoSeleccionado
            ? Image.asset(
                'assets/jugador_morado_con_circulo.png',
              )
            : Image.asset('assets/jugador_morado.png'),
        iconSize: 60,
        onPressed: () {
          setState(
            () {
              amarilloSeleccionado = false;
              azulSeleccionado = false;
              calipsoSeleccionado = false;
              naranjoSeleccionado = false;
              negroSeleccionado = false;
              pistachoSeleccionado = false;
              rojoSeleccionado = false;
              rosadoSeleccionado = false;
              verdeMusgoSeleccionado = false;
              verdeSeleccionado = false;
              violetaSeleccionado = false;
              moradoSeleccionado = true;

              Session.colorSeleccionado = "morado";
            },
          );
        },
      ),
    ];

    return Scaffold(
      //appBar: AppBar(
      //    title: esNuevaPartida
      //        ? Text('Partida Nueva')
      //        : Text('Unirse a una Partida')),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue.shade900,
                Colors.red,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icono_reglas.png',
                width: 80,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "CÓDIGO DE LA PARTIDA",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
                child: GestureDetector(
                  child: TextField(
                    controller: codigoPartidaController,
                    autofocus: true,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    enabled: esNuevaPartida ? false : true,
                    decoration: InputDecoration(
                        //hintText: '',
                        //hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.blueGrey[400],
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                        contentPadding: const EdgeInsets.all(12)),
                  ),
                  onLongPress: () {
                    Clipboard.setData(
                        ClipboardData(text: Session.codigoPartida));
                    print('Screen1 - Texto copiado');
                  },
                ),
              ),
              Text(
                "NOMBRE",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
                child: GestureDetector(
                  child: TextField(
                    controller: nombreJugadorController,
                    autofocus: true,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        //hintText: '',
                        //hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.blueGrey[400],
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        contentPadding: const EdgeInsets.all(12)),
                  ),
                  /*onLongPress: () {
                    Clipboard.setData(ClipboardData(text: Session.codigoPartida));
                    print('Screen1 - Texto copiado');
                  },*/
                ),
              ),
              Text(
                "ELIGE TU COLOR",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: circulos.sublist(0, 4),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: circulos.sublist(4, 8),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: circulos.sublist(8, 12),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // Botón Entrar
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Botón invitar
                  IconButton(
                    icon: Image.asset('assets/compartir_icono.png'),
                    iconSize: 60,
                    onPressed: () {
                      // Falta chequear que la partida existe (código es válido)
                      String codPart = codigoPartidaController.text;
                      if (codPart != null && codPart != '') {
                        FirebaseFirestore.instance
                            .collection('partidas')
                            .doc(codPart)
                            .get()
                            .then((doc) {
                          if (doc.exists) {
                            print('Screen1 - Sí existe la partida $codPart');
                            Share.share(
                                "¡Hola, te invito a jugar Conectemos! el código de la partida es $codPart");
                          } else {
                            print('Screen1 - No existe la partida $codPart');
                          }
                        });
                      } else {
                        print('Screen1 - La partida $codPart es inválida');
                      }
                    },
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  // Botón OK
                  IconButton(
                    icon: Image.asset('assets/icono_ok_sin_texto.png'),
                    iconSize: 60,
                    onPressed: () {
                      // Falta chequear que la partida existe (código es válido)
                      /*if (codigoPartida != null && codigoPartida != '') {
                        FirebaseFirestore.instance
                            .collection('partidas')
                            .doc(codigoPartida)
                            .collection('jugadores')
                            .add({'nombre': 'Anisa'}).then((documentRef) => print(
                                'Screen1 - Ingresado en la partida $codigoPartida jugador ' +
                                    documentRef.id));

                        Navigator.pushNamed(context, '/screen2',
                            arguments: codigoPartida);
                      } else {
                        print(
                            'Screen1 - La partida con código $codigoPartida no es válido');
                      }*/
                      //Navigator.pushNamed(context, '/screen2',
                      //    arguments: codigoPartida);

                      if (codigoPartidaController.text != null &&
                          nombreJugadorController.text != null &&
                          codigoPartidaController.text != '' &&
                          nombreJugadorController.text != '' &&
                          Session.colorSeleccionado != null &&
                          Session.colorSeleccionado != '') {
                        // FALTA VALIDAR EL NOMBRE DEL JUGADOR Y QUE NO ESTE OCUPADO POR OTRO JUGADOR EN LA MISMA PARTIDA
                        // FALTA VALIDAR QUE EL COLOR SELECCIONADO NO ESTE UTILIZADO POR OTRO JUGADOR

                        Session.nombreJugador = nombreJugadorController.text;
                        Session.codigoPartida = codigoPartidaController.text;

                        FirebaseFirestore.instance
                            .collection('partidas')
                            .doc(codigoPartidaController.text)
                            .update({
                              'jugadores': FieldValue.arrayUnion(
                                [nombreJugadorController.text],
                              ),
                              'colores': FieldValue.arrayUnion(
                                [Session.colorSeleccionado],
                              ),
                            })
                            .then(
                              (value) => {
                                Navigator.pushReplacementNamed(
                                    context, '/screen3'),
                              },
                            )
                            .catchError((error) => print("$error"));

                        // ME ESTOY SALTANDO EL SCREEN2
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

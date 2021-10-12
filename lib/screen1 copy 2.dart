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
              Image.asset('assets/icono_reglas.png'),
              SizedBox(
                height: 20,
              ),
              Text(
                "CÓDIGO DE LA PARTIDA",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 50),
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
                    ),
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
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 50),
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
                    ),
                  ),
                  /*onLongPress: () {
                    Clipboard.setData(ClipboardData(text: Session.codigoPartida));
                    print('Screen1 - Texto copiado');
                  },*/
                ),
              ),
              // Botón Entrar
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Botón invitar
                  IconButton(
                    icon: Image.asset('assets/compartir_icono.png'),
                    iconSize: 70,
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
                    iconSize: 70,
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
                          nombreJugadorController.text != '') {
                        // FALTA VALIDAR EL NOMBRE DEL JUGADOR Y QUE NO ESTE OCUPADO POR OTRO JUGADOR EN LA MISMA PARTIDA

                        Session.nombreJugador = nombreJugadorController.text;
                        Session.codigoPartida = codigoPartidaController.text;

                        FirebaseFirestore.instance
                            .collection('partidas')
                            .doc(codigoPartidaController.text)
                            .update({
                          'jugadores': FieldValue.arrayUnion(
                              [nombreJugadorController.text])
                        }).then(
                          (value) => {
                            Navigator.pushReplacementNamed(context, '/screen3'),
                          },
                        );
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

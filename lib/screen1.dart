import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() {
    return _Screen1State();
  }
}

class _Screen1State extends State<Screen1> {
  bool esNuevaPartida;
  String codigoPartida = '';

  TextEditingController myController = TextEditingController()..text = '';

  void createPartida() async {
    DocumentReference documentRef = await FirebaseFirestore.instance
        .collection('partidas')
        .add({'timestamp': FieldValue.serverTimestamp()});
    print(documentRef.documentID);
    codigoPartida = documentRef.documentID;
    myController.text = codigoPartida;
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    if (args['nueva_partida'] != null) {
      esNuevaPartida = args['nueva_partida'];
      if (esNuevaPartida == true) {
        print('nueva partida');
        createPartida();
      } else {
        print('no es nueva partida');
      }
    }

    return Scaffold(
      appBar: AppBar(
          title: esNuevaPartida
              ? Text('Partida Nueva')
              : Text('Unirse a una Partida')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Código de la partida",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 50),
              child: GestureDetector(
                child: TextField(
                  controller: myController,

                  onChanged: (value) {
                    codigoPartida = value;
                  },
                  autofocus: true,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  //inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  enabled: esNuevaPartida ? false : true,
                  //focusNode: FocusNode(),
                  //enableInteractiveSelection: false,
                ),
                onLongPress: () {
                  Clipboard.setData(ClipboardData(text: codigoPartida));
                  print('Texto copiado');
                },
              ),
            ),
            RaisedButton(
              onPressed: () {
                // Falta chequear que la partida existe (código es válido)
                if (codigoPartida != null && codigoPartida != '') {
                  FirebaseFirestore.instance
                      .collection('partidas')
                      .document(codigoPartida)
                      .collection('jugadores')
                      .add({'nombre': 'Anisa'});

                  Navigator.pushNamed(context, '/screen2',
                      arguments: codigoPartida);
                }
              },
              child: const Text('Entrar', style: TextStyle(fontSize: 20)),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {},
              child: const Text('Invitar', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() {
    return _Screen2State();
  }
}

class _Screen2State extends State<Screen2> {
  String codigoPartida;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("Screen2 - Firebase Iniciado");
      codigoPartida = ModalRoute.of(context).settings.arguments;
      if (codigoPartida != null) {
        print('Screen2 - codigoPartida ' + codigoPartida);
      } else {
        print('Screen2 - codigoPartida NULL');
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Partida Iniciada')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    //return _buildList(context, dummySnapshot);
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('partidas/' + codigoPartida + '/jugadores')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final jugador = Jugador.fromSnapshot(data);

    return Padding(
      //key: ValueKey(jugador.name), <--investigar para qué sirve esto
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(jugador.name),
          trailing: Text('X'),
          onTap: () => print(jugador.toString()),
        ),
      ),
    );
  }
}

class Jugador {
  final String name;
  final DocumentReference reference;

  Jugador.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['nombre'] != null),
        name = map['nombre'];

  Jugador.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Jugador<$name>";
}

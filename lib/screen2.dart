import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conectemos/session.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() {
    return _Screen2State();
  }
}

class _Screen2State extends State<Screen2> with WidgetsBindingObserver {
  String codigoJugador;

  StreamSubscription<Event> subscription;
  //Contiene a todos los UIDs de los usuarios que están actualmente conectados
  //a realtime database
  DatabaseReference connectedlistRef =
      FirebaseDatabase.instance.reference().child('.info/connected');
  DatabaseReference myidRef =
      FirebaseDatabase.instance.reference().child('users/mymobilenumber');

  //DatabaseReference myidRef;

  bool localIOnlineIndicator = false;
  //just to indicate you are online or offline on your Homepage

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print(
          'Screen2 - user returned to our app'); // según yo es equivalente a onResumen
      FirebaseDatabase.instance.goOnline();
    } else if (state == AppLifecycleState.inactive) {
      print('Screen2 - app is inactive'); // según yo es equivalente a onPause
      FirebaseDatabase.instance.goOffline();
      //subscription?.cancel();
    } else if (state == AppLifecycleState.paused) {
      print(
          'Screen2 - user is about quit our app temporally'); // según yo es equivalente
      // a onStop
    } else if (state == AppLifecycleState.detached) {
      print('Screen2 - app detached'); // según yo es equivalente a onDestroy
    }
  }

  void agregarJugadorPartida() {
    // Falta chequear que la partida existe (código es válido)
    if (Session.codigoPartida != null && Session.codigoPartida != '') {
      FirebaseFirestore.instance
          .collection('partidas')
          .doc(Session.codigoPartida)
          .collection('jugadores')
          .add({'nombre': Session.nombreJugador}).then((documentRef) {
        codigoJugador = documentRef.id;
        print(
            'Screen2 - Ingresado en la partida ${Session.codigoPartida} jugador ' +
                codigoJugador);
      });
    } else {
      print(
          'Screen2 - La partida con código ${Session.codigoPartida} no es válido');
    }
  }

  void eliminarJugadorPartida() {
    // Falta chequear que la partida existe (código es válido)
    if (Session.codigoPartida != null && Session.codigoPartida != '') {
      FirebaseFirestore.instance
          .collection('partidas')
          .doc(Session.codigoPartida)
          .collection('jugadores')
          .doc(codigoJugador)
          .delete();
    } else {
      print(
          'Screen2 - La partida con código ${Session.codigoPartida} no es válido');
    }
  }

  // Para obtener un id único del dispositivo
  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  @override
  void initState() {
    print('Screen2 - initState');

    super.initState();

    Firebase.initializeApp().whenComplete(() {
      print("Screen2 - Firebase Iniciado");

      //String deviceId = await _getId();
      //print('Screen2 - id único del dispositivo: ' + deviceId);
      //myidRef = FirebaseDatabase.instance.reference().child('users/$deviceId');

      WidgetsBinding.instance.addObserver(this);

      // Se comienza a escuchar el estado de (.info/connected)
      // Cada vez que cambie el estado de la conexión se llama al handlerFunction
      subscription = connectedlistRef.onValue.listen(handlerFunction);
      FirebaseDatabase.instance.goOnline();
      setState(() {});
    });
  }

  @override
  void dispose() {
    print('Screen2 - dispose');

    eliminarJugadorPartida();
    FirebaseDatabase.instance.goOffline(); // AGREGADO POR QUE AL PRESIONAR
    //BACK NO SE DESCONECTA

    // Se deja de escuchar el estado de (.info/connected)
    subscription.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Partida Iniciada')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('partidas/' + Session.codigoPartida + '/jugadores')
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
          onTap: () => eliminarJugadorPartida(),
        ),
      ),
    );
  }

  // AL PARECER LOS PROBLEMAS CON LA DETECCION DE LA DESCONEXION ESTAN AQUI
  // Al parecer tienen que ver con que el
  // bool myStatus = dataSnapshot.value;
  // a veces no es tan rápido de obtener el valor true, por lo que al retornar
  // false se elimina el jugador de la partida
  // Revisar si sacando el myidRed.onDisconnect del if-else se soluciona
  void handlerFunction(Event event) {
    DataSnapshot dataSnapshot = event.snapshot;
    // Si (.info/connected) retorna true si hay conexión y false si no hay
    bool myStatus = dataSnapshot.value;
    print('Screen2 - myStatus: ' + myStatus.toString());

    if (myStatus == false) {
      eliminarJugadorPartida();

      setState(() {
        localIOnlineIndicator = false;
      });
    } else {
      agregarJugadorPartida();

      // Para reducir la data que se baja/sube se usa "o" en vez de "online" y "ls" en vez de "last seen"
      // En caso de que se desconecte queremos que Firebase automáticamente setee o = false y ls = 1601925017345 (timestamp)
      myidRef.onDisconnect().set({
        'o': false,
        'ls': ServerValue.timestamp,
      }).then((a) {
        //Una vez que firebase reconoce la declaración anterior, entonces le decimo a firebase que estamos online
        myidRef.update({'o': true, 'ls': ServerValue.timestamp});
      });

      setState(() {
        localIOnlineIndicator = true;
      });
    }
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

// https://github.com/cgustav/dart_rut_validator/issues/2

import 'package:conectemos/screen1.dart';
import 'package:conectemos/screen3.dart';
import 'package:conectemos/screen4.dart';
import 'package:conectemos/screen5.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screen0.dart';
import 'screen2.dart';

void main() {
  // Para que la app entera funcione sólo en portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conectemos',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Screen0(),
        '/screen1': (context) => Screen1(),
        '/screen2': (context) => Screen2(),
        '/screen3': (context) => Screen3(),
        '/screen4': (context) => Screen4(),
        '/screen5': (context) => Screen5(),
      },
    );
  }
}

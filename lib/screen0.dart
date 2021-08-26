// https://www.digitalocean.com/community/tutorials/flutter-flutter-gradient

import 'package:flutter/material.dart';

class Screen0 extends StatefulWidget {
  @override
  _Screen0State createState() {
    return _Screen0State();
  }
}

class _Screen0State extends State<Screen0> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Partida')),
      body: Center(
        child: Container(
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset('assets/icono_crear_grupo.png'),
                  iconSize: 100,
                  onPressed: () {
                    Navigator.pushNamed(context, '/screen1',
                        arguments: {'nueva_partida': true});
                  },
                ),
                // RaisedButton(
                //   onPressed: () {
                //     Navigator.pushNamed(context, '/screen1',
                //         arguments: {'nueva_partida': true});
                //   },
                //   child: const Text('Crear nueva partida',
                //       style: TextStyle(fontSize: 20)),
                // ),

                IconButton(
                  icon: Image.asset('assets/reglas_con_texto.png'),
                  iconSize: 100,
                  onPressed: () {},
                ),
                // RaisedButton(
                //   onPressed: () {
                //     Navigator.pushNamed(context, '/instructions', arguments: {});
                //   },
                //   child:
                //       const Text('Instrucciones', style: TextStyle(fontSize: 20)),
                // ),
                IconButton(
                  icon: Image.asset('assets/icono_entrar.png'),
                  iconSize: 100,
                  onPressed: () {
                    Navigator.pushNamed(context, '/screen1',
                        arguments: {'nueva_partida': false});
                  },
                ),
                // RaisedButton(
                //   onPressed: () {
                //     Navigator.pushNamed(context, '/screen1',
                //         arguments: {'nueva_partida': false});
                //   },
                //   child: const Text('Unirse a una partida',
                //       style: TextStyle(fontSize: 20)),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

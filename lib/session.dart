class Session {
  // singleton
  static final Session _singleton = Session._internal();
  static String _codigoPartida;
  static String _nombreJugador;
  static String _colorSeleccionado;

  static int _carta1;
  static int _carta2;
  static int _carta3;

  factory Session() => _singleton;

  static String get codigoPartida => _codigoPartida;
  static set codigoPartida(String valor) => _codigoPartida = valor;

  static String get nombreJugador => _nombreJugador;
  static set nombreJugador(String valor) => _nombreJugador = valor;

  static String get colorSeleccionado => _colorSeleccionado;
  static set colorSeleccionado(String valor) => _colorSeleccionado = valor;

  static int get carta1 => _carta1;
  static set carta1(int valor) => _carta1 = valor;

  static int get carta2 => _carta2;
  static set carta2(int valor) => _carta2 = valor;

  static int get carta3 => _carta3;
  static set carta3(int valor) => _carta3 = valor;

  Session._internal();
}

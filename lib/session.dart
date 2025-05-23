class Session {
  // singleton
  static final Session _singleton = Session._internal();
  static String _codigoPartida;
  static String _nombreJugador;
  static String _colorSeleccionado;

  static int _carta1;
  static int _carta2;
  static int _carta3;

  static bool _comodin1ocupado;
  static bool _comodin2ocupado;
  static bool _comodin3ocupado;

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

  static bool get comodin1ocupado => _comodin1ocupado;
  static set comodin1ocupado(bool valor) => _comodin1ocupado = valor;

  static bool get comodin2ocupado => _comodin2ocupado;
  static set comodin2ocupado(bool valor) => _comodin2ocupado = valor;

  static bool get comodin3ocupado => _comodin3ocupado;
  static set comodin3ocupado(bool valor) => _comodin3ocupado = valor;

  Session._internal();
}

class Session {
  // singleton
  static final Session _singleton = Session._internal();
  static String _codigoPartida;
  static String _nombreJugador;
  static String _colorSeleccionado;

  factory Session() => _singleton;

  static String get codigoPartida => _codigoPartida;
  static set codigoPartida(String valor) => _codigoPartida = valor;

  static String get nombreJugador => _nombreJugador;
  static set nombreJugador(String valor) => _nombreJugador = valor;

  static String get colorSeleccionado => _colorSeleccionado;
  static set colorSeleccionado(String valor) => _colorSeleccionado = valor;

  Session._internal();
}

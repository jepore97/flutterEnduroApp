class BotonPanico {
  final String us_cdgo;
  final String latitud;
  final String longitud;

  BotonPanico({this.us_cdgo, this.latitud, this.longitud});

  factory BotonPanico.fromJson(dynamic parsedJson) {
    return BotonPanico(
        latitud: parsedJson['latitud'],
        us_cdgo: parsedJson['us_cdgo'],
        longitud: parsedJson['longitud']);
  }
}

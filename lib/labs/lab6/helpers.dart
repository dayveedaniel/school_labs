String latDpToDms(double latitude) {
  int latSeconds = (latitude * 3600).round();
  int latDegrees = latSeconds ~/ 3600;
  latSeconds = (latSeconds % 3600).abs();
  int latMinutes = latSeconds ~/ 60;
  latSeconds %= 60;

  return '${latDegrees.abs()}° $latMinutes\' $latSeconds" ${latDegrees >= 0 ? "N" : "S"}';
}

String longDpToDms(double longitude) {
  int longSeconds = (longitude * 3600).round();
  int longDegrees = longSeconds ~/ 3600;
  longSeconds = (longSeconds % 3600).abs();
  int longMinutes = longSeconds ~/ 60;
  longSeconds %= 60;

  return '${longDegrees.abs()}° $longMinutes\' $longSeconds" ${longDegrees >= 0 ? "E" : "W"}';
}

(String lat, String long) ddToDms(double latitude, double longitude) =>
    (latDpToDms(latitude), longDpToDms(longitude));

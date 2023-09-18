import 'package:geolocator/geolocator.dart';

final class CroppedPosition extends Position {
  const CroppedPosition({
    required this.name,
    required super.longitude,
    required super.latitude,
  }) : super(
          timestamp: null,
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
        );

  final String name;
}

final List<CroppedPosition> mockedPositions = [
  const CroppedPosition(
    latitude: 56.475986881065545,
    longitude: 84.97270666545107,
    name: 'Fix Price Frunze 61',
  ),
  const CroppedPosition(
    latitude: 56.47572470018775,
    longitude: 84.96313149829001,
    name: 'Home',
  ),
  const CroppedPosition(
      latitude: 56.46540659559621,
      longitude: 84.95059629167314,
      name: 'Main TPU Building'),
];

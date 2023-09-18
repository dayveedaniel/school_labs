// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  Future<Stream<Position>?> initCoords(BuildContext context) async {
    final hasPermission = await handleLocationPermission(context);

    if (!hasPermission) return null;
    return Geolocator.getPositionStream(
        locationSettings: const LocationSettings(distanceFilter: 10));
  }

  Future<bool> handleLocationPermission(BuildContext context) async {
    LocationPermission permission;

    await Geolocator.isLocationServiceEnabled().then(
      (value) {
        if (!value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Location services are disabled. Please enable the services'),
            ),
          );
          return false;
        }
      },
    );

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permissions are denied'),
          ),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.'),
        ),
      );
      return false;
    }
    return true;
  }
}

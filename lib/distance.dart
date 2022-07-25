import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

double distanceToZoom(double distance) {
  // 591657550.500000 / 2^(zoom) = distance
  final zoom = log(591657550.500000 / distance);
  return zoom + 1;
}

double distanceBetween(LatLng start, LatLng end) {
  final startLatitude = start.latitude;
  final startLongitude = start.longitude;

  final endLatitude = end.latitude;
  final endLongitude = end.longitude;

  const earthRadius = 6378137.0;
  final dLat = _toRadians(end.latitude - startLatitude);
  final dLon = _toRadians(endLongitude - startLongitude);

  final a = pow(sin(dLat / 2), 2) +
      pow(sin(dLon / 2), 2) *
          cos(_toRadians(startLatitude)) *
          cos(_toRadians(endLatitude));
  final c = 2 * asin(sqrt(a));

  return earthRadius * c;
}

double _toRadians(double degree) {
  return degree * pi / 180;
}

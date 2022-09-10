import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_utils/map_utils.dart';

extension on Random {
  double uniformDouble(double start, double end) {
    return nextDouble() * (end - start) + start;
  }
}

LatLng getRandomPointInPolygon(Polygon polygon) {
  final bounds = polygon.bounds;
  while (true) {
    final point = LatLng(
      Random().uniformDouble(
        bounds.northeast.latitude,
        bounds.southwest.latitude,
      ),
      Random().uniformDouble(
        bounds.northeast.longitude,
        bounds.southwest.longitude,
      ),
    );

    if (polygon.contains(point)) return point;
  }
}

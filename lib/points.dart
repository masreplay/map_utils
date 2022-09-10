import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_utils/distance.dart';

LatLng calculateCenter(List<LatLng> points) {
  final longitudes = points.map((i) => i.longitude).toList();
  final latitudes = points.map((i) => i.latitude).toList();

  latitudes.sort();
  longitudes.sort();

  final lowX = latitudes.first;
  final highX = latitudes.last;
  final lowY = longitudes.first;
  final highY = longitudes.last;

  final centerX = lowX + ((highX - lowX) / 2);
  final centerY = lowY + ((highY - lowY) / 2);

  return LatLng(centerX, centerY);
}

CameraPosition cameraPosition({
  required List<LatLng> points,
  double padding = 0,
  double correctness = 1,
}) {
  final bounds = farthestBounds(points);
  return CameraPosition(
    target: calculateCenter(points),
    zoom: distanceToZoom(
          distanceBetween(bounds.northeast, bounds.southwest),
        ) +
        correctness +
        padding,
  );
}

LatLngBounds farthestBounds(List<LatLng> points) {
  double? x0, y0, x1, y1;
  for (LatLng latLng in points) {
    if (x0 == null) {
      x0 = x1 = latLng.latitude;
      y0 = y1 = latLng.longitude;
    } else {
      if (latLng.latitude > x1!) x1 = latLng.latitude;
      if (latLng.latitude < x0) x0 = latLng.latitude;
      if (latLng.longitude > y1!) y1 = latLng.longitude;
      if (latLng.longitude < y0!) y0 = latLng.longitude;
    }
  }
  return LatLngBounds(northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
}

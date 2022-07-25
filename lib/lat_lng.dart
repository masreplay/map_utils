import 'package:google_maps_flutter/google_maps_flutter.dart';

List<LatLng> lngLatListToLatLngList(List<List<double>> points) =>
    points.map((point) => LatLng(point.last, point.first)).toList();

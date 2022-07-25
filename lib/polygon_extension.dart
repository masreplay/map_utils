import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_utils/map_utils.dart';

class Path {
  final LatLng a;
  final LatLng b;

  Path(this.a, this.b);
}

extension PolygonExtension on Polygon {
  int get edgesCount => points.length - 1;

  List<LatLng> get vertices => points;

  Path getPath(int i) {
    return Path(vertices[i], vertices[i + 1]);
  }

  LatLngBounds get bounds => farthestBounds(points);

  CameraPosition getCameraPosition({double padding = 0}) {
    return cameraPosition(points: points, padding: padding);
  }

  LatLng get getCenter => calculateCenter(points);

  bool checkIfValidMarker(LatLng point) {
    int intersectCount = 0;

    for (int i = 0; i < edgesCount; i++) {
      if (rayCastIntersect(point, getPath(i))) {
        intersectCount++;
      }
    }

    return (intersectCount % 2) == 1; // odd = inside, even = outside;
  }

  bool rayCastIntersect(LatLng point, Path path) {
    double x1 = path.a.longitude;
    double y1 = path.a.latitude;

    double x2 = path.b.longitude;
    double y2 = path.b.latitude;

    double x3 = point.longitude;
    double y3 = point.latitude;

    // a and b can't both be above or below y3, and a or b must be east of x3
    if ((y1 > y3 && y2 > y3) || (y1 < y3 && y2 < y3) || (x1 < x3 && x2 < x3)) {
      return false;
    }

    final double m = (y1 - y2) / (x1 - x2); // Rise over run
    final double y = (-x1) * m + y1; // y = mx + b
    final double x = (y3 - y) / m; // algebra is neat!

    return x > x3;
  }
}

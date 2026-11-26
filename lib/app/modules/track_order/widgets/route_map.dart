import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteMap extends StatelessWidget {
  final double progress;
  const RouteMap({super.key, required this.progress});

  static const _route = <LatLng>[
    LatLng(28.4252, 70.3052), // restaurant
    LatLng(28.4245, 70.3020),
    LatLng(28.4228, 70.3000),
    LatLng(28.4215, 70.2975),
    LatLng(28.4200, 70.2950),
    LatLng(28.4188, 70.2925),
    LatLng(28.4178, 70.2900), // customer
  ];

  double _dist(LatLng a, LatLng b) {
    final dx = a.latitude - b.latitude;
    final dy = a.longitude - b.longitude;
    return (dx * dx + dy * dy);
  }

  LatLng _riderAt(double p) {
    final lens = <double>[];
    double total = 0;
    for (var i = 0; i < _route.length - 1; i++) {
      final d = _dist(_route[i], _route[i + 1]);
      lens.add(d);
      total += d;
    }
    var target = total * p.clamp(0.0, 1.0);
    for (var i = 0; i < lens.length; i++) {
      if (target <= lens[i]) {
        final t = lens[i] == 0 ? 0.0 : target / lens[i];
        return LatLng(
          _route[i].latitude +
              (_route[i + 1].latitude - _route[i].latitude) * t,
          _route[i].longitude +
              (_route[i + 1].longitude - _route[i].longitude) * t,
        );
      }
      target -= lens[i];
    }
    return _route.last;
  }

  @override
  Widget build(BuildContext context) {
    final rider = _riderAt(progress);

    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(28.4215, 70.2976),
        zoom: 15.2,
      ),
      padding: const EdgeInsets.only(bottom: 220),
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      mapToolbarEnabled: false,
      polylines: {
        Polyline(
          polylineId: const PolylineId('route'),
          points: _route,
          color: const Color(0xFFFF8A00),
          width: 5,
        ),
      },
      markers: {
        Marker(
          markerId: const MarkerId('restaurant'),
          position: _route.first,
          infoWindow: const InfoWindow(title: 'Restaurant'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueOrange),
        ),
        Marker(
          markerId: const MarkerId('customer'),
          position: _route.last,
          infoWindow: const InfoWindow(title: 'Your location'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
        Marker(
          markerId: const MarkerId('rider'),
          position: rider,
          infoWindow: const InfoWindow(title: 'Courier'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueYellow),
        ),
      },
    );
  }
}
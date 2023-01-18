import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarker extends Marker {
  final String name;

  const CustomMarker({
    required MarkerId markerId,
    required LatLng position,
    required this.name,
    required BitmapDescriptor icon,
    required InfoWindow infoWindow,
    required void Function() onTap,
  }) : super(
          markerId: markerId,
          position: position,
          icon: icon,
          infoWindow: infoWindow,
          onTap: onTap,
        );
}

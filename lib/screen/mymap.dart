import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

class MyMapScreen extends StatefulWidget {
  const MyMapScreen({Key? key}) : super(key: key);

  @override
  State<MyMapScreen> createState() => _MyMapScreenState();
}

class _MyMapScreenState extends State<MyMapScreen> {
  GoogleMapController? mapController;

  Set<Marker> markers = {};
  LatLng myLocation = const LatLng(27.7047139, 85.3295421);
  LatLng myLocation1 = const LatLng(-7.247483, -55.108848);

  @override
  void initState() {
    getLocation();
    // markers.add(
    //   Marker(
    //     markerId: MarkerId(
    //       myLocation.toString(),
    //     ),
    //     position: myLocation,
    //     infoWindow: const InfoWindow(
    //       title: "Guitar Shop",
    //       snippet: "Shop",
    //     ),
    //     icon: BitmapDescriptor.defaultMarker,
    //   ),
    // );
    // markers.add(
    //   Marker(
    //     markerId: MarkerId(
    //       myLocation1.toString(),
    //     ),
    //     position: myLocation1,
    //     infoWindow: const InfoWindow(
    //       title: "Brazil Branch",
    //       snippet: "Guitar Shop",
    //     ),
    //     icon: BitmapDescriptor.defaultMarker,
    //   ),
    // );
    super.initState();
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  void getLocation() async {
    Position? currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    CameraPosition cameraPosition = CameraPosition(
        target: LatLng(currentPosition.latitude, currentPosition.longitude),
        zoom: 14);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //       icon: const Icon(Icons.arrow_back_ios),
      //       onPressed: () => Navigator.popAndPushNamed(context, "/layout")),
      // ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: myLocation,
          // zoom: 10,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        // zoomControlsEnabled: false,
        // zoomGesturesEnabled: false,
      ),
    );
  }
}

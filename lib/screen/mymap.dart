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

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

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

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  // Location location = Location();

  // Future<bool> _checkPermission() async {
  //   final permission = await location.hasPermission();
  //   if (permission == PermissionStatus.granted) {
  //     return true;
  //   } else {
  //     final permissionRequest = await location.requestPermission();
  //     if (permissionRequest == PermissionStatus.granted) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   }
  // }

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
          zoom: 10,
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

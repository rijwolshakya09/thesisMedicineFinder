import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medicine_finder/components/search_bar.dart';
import 'package:medicine_finder/repository/medicine_repository.dart';
import 'package:medicine_finder/response/medicine_response.dart';
// import 'package:location/location.dart';

class MyMapScreen extends StatefulWidget {
  const MyMapScreen({Key? key}) : super(key: key);

  @override
  State<MyMapScreen> createState() => _MyMapScreenState();
}

class _MyMapScreenState extends State<MyMapScreen> {
  GoogleMapController? mapController;

  final Set<Marker> _markers = {};
  LatLng myLocation = const LatLng(27.7047139, 85.3295421);

  BitmapDescriptor? markerImage;

  @override
  void initState() {
    getLocation();
    markericon();
    super.initState();
  }

  void markericon() async {
    BitmapDescriptor? markerImage1 = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(50, 50)),
        'assets/images/locationmain.png');
    setState(() {
      markerImage = markerImage1;
    });
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
    const outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
      borderSide: BorderSide.none,
    );
    return Scaffold(
      body: FutureBuilder<MedicineResponse?>(
        future: MedicineRepository().getMedicines(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              // ProductResponse productResponse = snapshot.data!;
              for (int i = 0; i < snapshot.data!.data!.length; i++) {
                _markers.add(
                  Marker(
                    markerId: MarkerId(snapshot.data!.data![i].toString()),
                    position: LatLng(snapshot.data!.data![i].pharmacyId!.lat!,
                        snapshot.data!.data![i].pharmacyId!.lng!),
                    infoWindow: InfoWindow(
                      onTap: () {
                        _showModalBottomSheet(context);
                      },
                      title: snapshot.data!.data![i].pharmacyId!.pharmacy_name!,
                      snippet:
                          'lat:${snapshot.data!.data![i].pharmacyId!.lat!} lng:${snapshot.data!.data![i].pharmacyId!.lng!}',
                    ),
                    icon: markerImage!,
                  ),
                );
              }
              return GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: myLocation,
                  // zoom: 10,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: _markers,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              );
            } else {
              return const Center(
                child: Text("No data"),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            );
          }
        },
      ),
      floatingActionButton: const Padding(
        padding: EdgeInsets.fromLTRB(0, 8, 80, 0),
        child: SizedBox(
          height: 100,
          child: SearchBar(outlineInputBorder: outlineInputBorder),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            child: const Text("Modal Bottom Sheet"),
          );
        });
  }
}

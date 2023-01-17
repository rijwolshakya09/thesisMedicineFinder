import 'dart:async';

import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';
import 'package:medicine_finder/api/http_services.dart';
import 'package:medicine_finder/response/pharmacy_response.dart';
import 'package:medicine_finder/utils/url.dart';

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  GoogleMapController? controller;
  final Set<Marker> _markers = {};
  LatLng myLocation = const LatLng(27.7047139, 85.3295421);

  @override
  void initState() {
    getLocation();
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
    return FutureBuilder<PharmacyResponse?>(
        future: getPharmacy(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            for (int i = 0; i < snapshot.data!.data!.length; i++) {
              _markers.add(
                Marker(
                  markerId: MarkerId(snapshot.data!.data![i].toString()),
                  position: LatLng(snapshot.data!.data![i].lat!,
                      snapshot.data!.data![i].lng!),
                  infoWindow: InfoWindow(
                    onTap: () => {
                      debugPrint("Hello!!!"),
// de                      const SizedBox(
//                         height: 65,
//                         child: Text("Hello"),
//                       )
                    },
                    title: snapshot.data!.data![i].pharmacy_name!,
                    snippet:
                        'lat:${snapshot.data!.data![i].lat!} lng:${snapshot.data!.data![i].lng!}',
                  ),
                  icon: BitmapDescriptor.defaultMarker,
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
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const CircularProgressIndicator();
        });
  }

  Future<PharmacyResponse?> getPharmacy() async {
    Future.delayed(const Duration(seconds: 2), () {});
    PharmacyResponse? pharmacyResponse;
    try {
      var dio = HttpServices().getDioInstance();
      dio.interceptors
          .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
      Response response = await dio.get(
        pharmacyUrl,
        options: buildCacheOptions(const Duration(days: 7)),
      );
      // debugPrint("........${response.data!}");
      if (response.statusCode == 201) {
        pharmacyResponse = PharmacyResponse.fromJson(response.data);
      } else {
        pharmacyResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return pharmacyResponse;
  }
}

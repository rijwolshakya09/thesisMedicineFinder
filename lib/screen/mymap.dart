import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:medicine_finder/model/medicine.dart';
import 'package:medicine_finder/repository/medicine_repository.dart';
import 'package:medicine_finder/response/medicine_response.dart';
import 'package:medicine_finder/utils/url.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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
  String searchsave = "";

  @override
  void initState() {
    getLocation();
    markericon();
    super.initState();
  }

  // Custom Marker Code
  void markericon() async {
    BitmapDescriptor? markerImage1 = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(50, 50)),
        'assets/images/locationmain.png');
    setState(() {
      markerImage = markerImage1;
    });
  }

  // Google Map Controller
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  // Get My Location Code
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

  void getNewLocation() async {
    // Position? currentPosition = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    CameraPosition cameraPosition =
        const CameraPosition(target: LatLng(58.5645464, 85.654541), zoom: 20);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {});
  }

  // Medicine Location
  void getMedicineLocation() async {
    Position? currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    CameraPosition cameraPosition = CameraPosition(
        target: LatLng(currentPosition.latitude, currentPosition.longitude),
        zoom: 14);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {});
  }

  // Search Bar Controller
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();

  int _medQuantity = 1;

  void _incrementCount() {
    setState(() {
      _medQuantity++;
    });
  }

  void _decrementCount() {
    setState(() {
      _medQuantity--;
    });
  }

  // // Book Medicine Controller
  // final _quantity = TextEditingController();
  // final _total_price = TextEditingController();

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
                debugPrint(
                    "${snapshot.data!.data![i].pharmacyId!.id!}Phjarmacy");
                _markers.add(
                  Marker(
                    markerId: MarkerId(snapshot.data!.data![i].toString()),
                    position: LatLng(snapshot.data!.data![i].pharmacyId!.lat!,
                        snapshot.data!.data![i].pharmacyId!.lng!),
                    infoWindow: InfoWindow(
                      onTap: () => showMaterialModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (BuildContext context,
                              StateSetter setStateSheet) {
                            return _showModalBottomSheet(setStateSheet,
                                snapshot.data!.data![i].pharmacyId!.id!);
                          });
                        },
                      ),
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 80, 0),
        child: Form(
          key: _formKey,
          child: TextFormField(
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 14,
              fontFamily: 'Merienda',
            ),
            controller: _searchController,
            decoration: InputDecoration(
              labelText: "Medicine or Pharmacy",
              labelStyle: const TextStyle(color: Color(0xFFFFFFFF)),
              filled: true,
              fillColor: const Color(0xFF6BB3ED),
              border: outlineInputBorder,
              enabledBorder: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              prefixIcon: const Padding(
                padding: EdgeInsets.fromLTRB(14, 6, 14, 6),
                child: Iconify(
                  Ep.search,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.popAndPushNamed(context, "/nxtmap");
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                    ),
                    child: const Iconify(
                      Ep.search,
                      size: 50,
                      color: Color(0xFF6BB3ED),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  Widget _showModalBottomSheet(StateSetter setStateSheet, String pharmacyId) {
    debugPrint("Pharmacy ID:$pharmacyId");
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 0),
        child: Column(
          children: [
            const Text(
              "Medicines",
              style: TextStyle(
                color: Color(0xFF6BB3ED),
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Merienda',
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FutureBuilder<MedicineResponse?>(
                future: MedicineRepository().getMedByPharmacy(pharmacyId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    debugPrint("........${snapshot.data}");
                    if (snapshot.data != null) {
                      // ProductResponse productResponse = snapshot.data!;
                      List<Medicine> lstMedicine = snapshot.data!.data!;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          // childAspectRatio: 50 / 60,
                          crossAxisCount: 1,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 20,
                          mainAxisExtent: 180,
                        ),
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              // key: ValueKey("singleguitar$index"),
                              onTap: () {
                                setState(() {
                                  // Navigator.pushNamed(context, "/singleguitar",
                                  //     arguments: lstMedicine[index].id);
                                });
                              },
                              child: medicinemain(lstMedicine[index]));
                        },
                      );
                    } else {
                      return const Center(
                        child: Text("No data"),
                      );
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
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
            ),
          ],
        ),
      ),
    );
  }

  Widget medicinemain(Medicine medicine) {
    return Center(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            // height: double.infinity,
            // width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFF6BB3ED),
            ),
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 52,
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  // backgroundImage:
                  //     NetworkImage("$baseUrl${guitar.guitar_image!}"),
                  child: ClipRect(
                    child: Image.network("$baseUrl${medicine.medicine_image!}",
                        height: 74, width: 74),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      medicine.medicine_name!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        // fontSize: 20,
                        fontFamily: 'Merienda',
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Rs. ${medicine.medicine_price!}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        // fontSize: 20,
                        fontFamily: 'Merienda',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 4, 30, 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 140, 255),
                            ),
                            onPressed: _decrementCount,
                            child: const Icon(Icons.remove),
                          ),
                          Text(
                            " $_medQuantity",
                            style: const TextStyle(
                              fontFamily: "Merienda",
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 21,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 140, 255),
                            ),
                            onPressed: _incrementCount,
                            child: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 2,
              right: 70,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 136, 255),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                child: const Text("Book Medicine"),
              )),
        ],
      ),
    );
  }
}

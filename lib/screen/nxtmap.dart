import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:medicine_finder/api/http_services.dart';
import 'package:medicine_finder/model/medicine.dart';
import 'package:medicine_finder/repository/book_medicine_repository.dart';
import 'package:medicine_finder/repository/medicine_repository.dart';
import 'package:medicine_finder/response/medicine_response.dart';
import 'package:medicine_finder/utils/url.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:motion_toast/motion_toast.dart';

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  int totalPrice = 0;
  GoogleMapController? controller;
  final Set<Marker> _markers = {};
  LatLng myLocation = const LatLng(27.7047139, 85.3295421);

  @override
  void initState() {
    getLocation();
    markericon();
    super.initState();
  }

  Map<String, dynamic> selectedMed = {};
  int itemCount = 0;

  BitmapDescriptor? markerImage;
  // Custom Marker Code
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
    // Position? currentPosition = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    CameraPosition cameraPosition =
        const CameraPosition(target: LatLng(27.629882, 85.523381), zoom: 18);
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

  void _incrementCount(StateSetter setStateSheet) {
    setStateSheet(() {
      _medQuantity++;
    });
    // setState(() {
    //   // _medQuantity++;
    // });
  }

  void _decrementCount(StateSetter setStateSheet) {
    setStateSheet(() {
      _medQuantity--;
    });
    // setState(() {
    //   // _medQuantity--;
    // });
  }

  int counter = 1;

  _bookMedicine(
    Medicine medicine,
    int quantity,
    int totalPrice,
    String status,
  ) async {
    bool isAdded = await BookedMedicineRepository().bookMedicine(
      medicine,
      quantity,
      totalPrice,
      status,
    );
    if (isAdded) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: counter,
          channelKey: 'basic_channel',
          title: 'Order Success',
          body: 'Your Order Has Been Placed Successfully',
        ),
      );
      setState(() {
        counter++;
      });
      Navigator.pushNamed(context, "/layout");
      _displayMessage(isAdded);
    } else {
      _displayMessage(isAdded);
    }
  }

  _displayMessage(bool isAdded) {
    if (isAdded) {
      MotionToast.success(
        description: const Text("Medicine Booked Successfully"),
      ).show(context);
    } else {
      MotionToast.error(
        description: const Text("Something Went Wrong!!! Please Try Again!!!"),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    const outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
      borderSide: BorderSide.none,
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.popAndPushNamed(context, "/layout")),
        ),
        body: FutureBuilder<MedicineResponse?>(
          future: getMedicines(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              for (int i = 0; i < snapshot.data!.data!.length; i++) {
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
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();
          },
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(0, 80, 80, 0),
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
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
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
      ),
    );
  }

  Future<MedicineResponse?> getMedicines() async {
    Future.delayed(const Duration(seconds: 2), () {});
    MedicineResponse? medicineResponse;
    try {
      var dio = HttpServices().getDioInstance();
      dio.interceptors
          .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
      Response response = await dio.get(
        medicineUrl,
        options: buildCacheOptions(const Duration(days: 7)),
      );
      debugPrint("MedicineAPI........${response.data!}");
      if (response.statusCode == 200) {
        medicineResponse = MedicineResponse.fromJson(response.data);
      } else {
        medicineResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return medicineResponse;
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
                          return medicinemain(
                              setStateSheet, lstMedicine[index], index);
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

  List<Medicine?>? lstMed;

  Widget medicinemain(StateSetter setStateSheet, Medicine medicine, int index) {
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
                    selectedMed.containsKey(index.toString())
                        ? Text(
                            "TotalPrice: " + selectedMed[index.toString()][3],
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Merienda",
                            ),
                          )
                        : const Text("0"),
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
                            onPressed: () => setState(() {
                              _decrementCount(setStateSheet);
                              if (selectedMed.containsKey(index.toString()) &&
                                  int.parse(selectedMed[index.toString()][1]) >
                                      0) {
                                int newCakePound = int.parse(
                                        selectedMed[index.toString()][1]) -
                                    1;

                                int newCakePrice = int.parse(
                                        selectedMed[index.toString()][3]) -
                                    int.parse(
                                        medicine.medicine_price.toString());
                                // setStateSheet(() {

                                // });
                                selectedMed[index.toString()][1] =
                                    newCakePound.toString();

                                selectedMed[index.toString()][3] =
                                    "$newCakePrice";

                                if (selectedMed.containsKey(index.toString()) &&
                                    int.parse(
                                            selectedMed[index.toString()][1]) <
                                        1) {
                                  itemCount = 0;
                                  selectedMed.remove(index.toString());
                                }

                                // setStateSheet(() {
                                //   totalPrice -= int.parse(
                                //       medicine.medicine_price.toString());
                                // });
                              }
                              debugPrint(
                                  "Selected Pounds : ${selectedMed.toString()}");
                            }),
                            child: const Icon(Icons.remove),
                          ),
                          selectedMed.containsKey(index.toString())
                              ? Text(selectedMed[index.toString()][1])
                              : const Text("0"),
                          // Text(
                          //   " $_medQuantity",
                          //   style: const TextStyle(
                          //     fontFamily: "Merienda",
                          //     color: Color.fromARGB(255, 255, 255, 255),
                          //     fontSize: 21,
                          //     fontWeight: FontWeight.w400,
                          //   ),
                          // ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 140, 255),
                            ),
                            onPressed: () => setState(() {
                              _incrementCount(setStateSheet);
                              if (selectedMed.containsKey(index.toString()) &&
                                  int.parse(selectedMed[index.toString()][1]) >
                                      0) {
                                int newCakePound = int.parse(
                                        selectedMed[index.toString()][1]) +
                                    1;

                                int newCakePrice = int.parse(
                                        selectedMed[index.toString()][3]) +
                                    int.parse(
                                        medicine.medicine_price.toString());
                                debugPrint("NewCake: $newCakePound");
                                // setStateSheet(() {
                                selectedMed[index.toString()][1] =
                                    "$newCakePound";
                                selectedMed[index.toString()][3] =
                                    "$newCakePrice";
                                // });
                              } else {
                                itemCount = 1;
                                int newCakePound = 1;
                                int newTotalPrice = int.parse(
                                    medicine.medicine_price.toString());

                                final cakePound = <String, dynamic>{
                                  index.toString(): [
                                    medicine.medicine_name,
                                    "$newCakePound",
                                    medicine.id,
                                    "$newTotalPrice",
                                  ]
                                };
                                selectedMed.addEntries(cakePound.entries);
                              }
                              // setStateSheet(() {
                              //   totalPrice += int.parse(
                              //       medicine.medicine_price.toString());
                              // });
                            }),
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _bookMedicine(
                    medicine,
                    int.parse(selectedMed[index.toString()][1]),
                    int.parse(selectedMed[index.toString()][3]),
                    "Pending",
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 136, 255),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              child: const Text("Book Medicine"),
            ),
          ),
        ],
      ),
    );
  }
}

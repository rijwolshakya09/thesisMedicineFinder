import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:medicine_finder/model/medicine.dart';
import 'package:medicine_finder/model/pharmacy.dart';
import 'package:medicine_finder/repository/medicine_repository.dart';
import 'package:medicine_finder/repository/pharmacy_repository.dart';
import 'package:medicine_finder/response/medicine_response.dart';
import 'package:medicine_finder/response/pharmacy_response.dart';
import 'package:medicine_finder/utils/url.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
            child: Column(
              children: [
                const Text("Home Screen"),
                ElevatedButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/mymap');
                  },
                  child: const Text("Open Map"),
                ),
                const Text(
                  "Pharmacies",
                  style: TextStyle(
                    color: Color(0xFF535699),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Merienda',
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        child: FutureBuilder<PharmacyResponse?>(
                          future: PharmacyRepository().getPharmacy(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.data != null) {
                                // ProductResponse productResponse = snapshot.data!;
                                List<Pharmacy> pharmacyList =
                                    snapshot.data!.data!;
                                return ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          Navigator.pushNamed(
                                              context, '/profile');
                                        });
                                      },
                                      child: pharmacy(
                                        pharmacyList[index],
                                      ),
                                    );
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
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.blue),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                //==============================Medicines Section================================
                const Text(
                  "Medicines",
                  style: TextStyle(
                    color: Color(0xFF535699),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Merienda',
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: FutureBuilder<MedicineResponse?>(
                    future: MedicineRepository().getMedicines(),
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
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 20,
                              mainAxisExtent: 220,
                            ),
                            itemCount: snapshot.data!.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  key: ValueKey("singleguitar$index"),
                                  onTap: () {
                                    setState(() {
                                      Navigator.pushNamed(
                                          context, "/singleguitar",
                                          arguments: lstMedicine[index].id);
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
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //===================Widget For Pharmacy Section================================
  Widget pharmacy(Pharmacy pharmacy) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundImage: NetworkImage("$baseUrl${pharmacy.pharmacy_pic!}"),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            pharmacy.pharmacy_name!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              fontFamily: 'Merienda',
            ),
          )
        ],
      ),
    );
  }

  //===================Widget For Guitars Section=================================
  Widget medicinemain(Medicine medicine) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          // height: double.infinity,
          // width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFF535699),
          ),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: const Color(0xFFbdbfe9),
                // backgroundImage:
                //     NetworkImage("$baseUrl${guitar.guitar_image!}"),
                child: ClipRect(
                  child: Image.network("$baseUrl${medicine.medicine_image!}",
                      height: 120, width: 120),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
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
                "Rs.${medicine.medicine_price!}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  // fontSize: 20,
                  fontFamily: 'Merienda',
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () {
              setState(() {
                // _wishlist(guitar.id);
              });
            },
            child: const Iconify(
              Ph.heart_fill,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}

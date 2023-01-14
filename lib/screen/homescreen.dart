import 'package:flutter/material.dart';
import 'package:medicine_finder/model/pharmacy.dart';
import 'package:medicine_finder/repository/pharmacy_repository.dart';
import 'package:medicine_finder/response/pharmacy_response.dart';
import 'package:medicine_finder/utils/url.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
                  "Categories",
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  //===================Widget For Category Section================================
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
}

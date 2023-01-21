import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:medicine_finder/model/bookmed.dart';
import 'package:medicine_finder/repository/book_medicine_repository.dart';
import 'package:medicine_finder/utils/url.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({Key? key}) : super(key: key);

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: const Size.fromHeight(80.0),
        //   child: AppBar(
        //     title: const Text(
        //       "Add To Cart",
        //       style: TextStyle(
        //         color: Color(0xFF535699),
        //         fontFamily: "Merienda",
        //         fontWeight: FontWeight.bold,
        //       ),
        //       key: ValueKey("addtocarttitle"),
        //     ),
        //     centerTitle: true,
        //     leading: Padding(
        //       padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
        //       child: CircleAvatar(
        //         radius: 26,
        //         backgroundColor: const Color(0xFF535699),
        //         child: IconButton(
        //           icon: const Iconify(
        //             Ic.round_arrow_back_ios_new,
        //             color: Colors.white,
        //             size: 100,
        //           ),
        //           iconSize: 100,
        //           onPressed: () {
        //             // Navigator.of(context).pop();
        //             Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                     builder: (context) => const LayoutScreen()));
        //           },
        //         ),
        //       ),
        //     ),
        //     // leadingWidth: 100,
        //     toolbarHeight: 100,
        //     backgroundColor: Colors.transparent,
        //     elevation: 0.0,
        //   ),
        // ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF6BB3ED),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    width: double.infinity,
                    child: FutureBuilder<List<BookMedicine?>>(
                      future: BookedMedicineRepository().getBookedMedicine(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data != null) {
                            if (snapshot.data!.isNotEmpty) {
                              List<BookMedicine?> lstBookedMedicine =
                                  snapshot.data!;
                              return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          bookedMed(lstBookedMedicine[index]!),
                                    );
                                  });
                            } else {
                              return const Center(
                                child: Text("My Booking Is Empty"),
                              );
                            }
                            // ProductResponse productResponse = snapshot.data!;

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
        // bottomNavigationBar: Container(
        //   padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
        //   height: 72,
        //   decoration: const BoxDecoration(
        //     borderRadius: BorderRadius.only(
        //         topRight: Radius.circular(22.0),
        //         topLeft: Radius.circular(22.0)),
        //     color: Color(0xFF535699),
        //   ),
        //   width: double.infinity,
        //   child: FutureBuilder<List<AddToCart?>>(
        //     future: AddToCartRepository().getCart(),
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.done) {
        //         // debugPrint(snapshot.data.toString());
        //         if (snapshot.data != null) {
        //           // ProductResponse productResponse = snapshot.data!;
        //           lstCart = snapshot.data!;
        //           return bottomnav();
        //         } else {
        //           return const Center(
        //             child: Text("No data"),
        //           );
        //         }
        //       } else if (snapshot.connectionState == ConnectionState.waiting) {
        //         return const Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       } else if (snapshot.hasError) {
        //         return Text("${snapshot.error}");
        //       } else {
        //         return const Center(
        //           child: CircularProgressIndicator(
        //             valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        //           ),
        //         );
        //       }
        //     },
        //   ),
        // ),
      ),
    );
  }

  //Add To Cart Main Widget Design
  Widget bookedMed(BookMedicine bookedMedicine) {
    return Container(
      padding: const EdgeInsets.fromLTRB(2, 4, 2, 4),
      height: 100,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 35, 110, 171),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            const SizedBox(
              width: 6,
            ),
            CircleAvatar(
              radius: 40,
              backgroundColor: const Color(0xFFbdbfe9),
              // backgroundImage:
              //     NetworkImage("$baseUrl${guitar.guitar_image!}"),
              child: ClipRect(
                child: Image.network(
                    "$baseUrl${bookedMedicine.medicine!.medicine_image}",
                    height: 120,
                    width: 120),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookedMedicine.medicine!.medicine_name!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Merienda',
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Rs. ${bookedMedicine.total_price!}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: 'Merienda',
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Quantity: ${bookedMedicine.status!}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontFamily: 'Merienda',
                    ),
                  ),
                ],
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
            child: Row(
              children: [
                const VerticalDivider(
                  color: Colors.white,
                  indent: 0,
                  endIndent: 0,
                  thickness: 2,
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        // _deleteCart(cart.id!);
                      });
                    },
                    icon: const Iconify(
                      Ion.md_trash,
                      color: Color(0xFF6BB3ED),
                      size: 40,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

// //BottomCard Design
//   Widget bottomnav() {
//     var totalprice = lstCart!.fold(
//         0,
//         (int sum, item) =>
//             sum +
//             int.parse(item!.guitar_id["guitar_price"].toString()) *
//                 item.quantity!);

//     return Padding(
//       padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "Rs.$totalprice",
//             style: const TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//               fontFamily: 'Merienda',
//             ),
//           ),
//           SizedBox(
//             height: 54,
//             child: ElevatedButton.icon(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/order');
//               },
//               icon: const Iconify(
//                 Fluent.cart_24_filled,
//                 color: Color(0xFF535699),
//                 size: 40,
//               ),
//               label: const Text(
//                 "Checkout",
//                 style: TextStyle(
//                     color: Color(0xFF535699),
//                     fontFamily: "Merienda",
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold),
//               ),
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
}

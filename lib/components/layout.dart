import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/fa_solid.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:iconify_flutter/icons/simple_icons.dart';
import 'package:medicine_finder/model/customappbarlogin.dart';
import 'package:medicine_finder/model/showprofile.dart';
import 'package:medicine_finder/repository/profile_repository.dart';
import 'package:medicine_finder/response/profile_response.dart';
import 'package:medicine_finder/screen/homescreen.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:medicine_finder/screen/mybooking.dart';
import 'package:medicine_finder/screen/mymap.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../model/customappbarlogin.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int _selectedIndex = 0;

  List<Widget> lstWidget = [
    const HomeScreen(),
    const MyMapScreen(),
    const MyBookingScreen(),
  ];

  _removeDataFromSharedPref() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("token");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _logoutUser() {
    setState(() {
      _removeDataFromSharedPref();
      Navigator.pushNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: lstWidget[_selectedIndex],
      ),
      //=====================Bottom Navigation Section================================
      bottomNavigationBar: CurvedNavigationBar(
        key: const ValueKey("navbar"),
        height: 60,
        backgroundColor: Colors.transparent,
        color: const Color(0xFF6BB3ED),
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          Iconify(
            MaterialSymbols.home_rounded,
            color: Colors.white,
            size: 30,
          ),
          Iconify(
            SimpleIcons.googlemaps,
            color: Colors.white,
            size: 30,
          ),
          Iconify(
            MaterialSymbols.medical_information,
            color: Colors.white,
            size: 30,
          ),
        ],
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              key: const ValueKey("opendrawer"),
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              icon: const Iconify(
                FaSolid.bars,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Image.asset(
            'assets/images/logo2.png',
            width: 120,
            fit: BoxFit.fill,
          ),
        ),
        titleSpacing: 10,
        centerTitle: true,
        actions: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Iconify(
                Ri.user_4_fill,
                color: Color(0xFF6BB3ED),
                size: 70,
              ),
              iconSize: 100,
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ),
          const SizedBox(
            width: 16,
          )
        ],
        // automaticallyImplyLeading: false,
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: CustomAppBar(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFF6BB3ED),
            child: const Center(
                // child: SizedBox(
                //   width: MediaQuery.of(context).size.width,
                //   height: 70,
                //   child: Image.asset(
                //     'assets/images/MainGuitarLogo.png',
                //   ),
                // ),
                ),
          ),
        ),
      ),

//=====================Navigation Drawer Section================================
      drawer: Drawer(
        key: const ValueKey("navbar"),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            FutureBuilder<ProfileResponse?>(
              future: ProfileRepository().getProfile(),
              builder: (context, snapshot) {
                // debugPrint(snapshot.data!.data!.address.toString());
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != null) {
                    // ProductResponse productResponse = snapshot.data!;
                    ShowProfile lstProfile = snapshot.data!.data!;
                    return UserAccountsDrawerHeader(
                      accountName: Text(
                        lstProfile.first_name! + lstProfile.last_name!,
                        style: const TextStyle(
                          // color: Color(0xFF535699),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Merienda',
                        ),
                      ),
                      accountEmail: Text(
                        lstProfile.email!,
                        style: const TextStyle(
                          // color: Color(0xFF535699),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          fontFamily: 'Merienda',
                        ),
                      ),
                      currentAccountPicture: CircleAvatar(
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/profilepic.jpg',
                            width: 80,
                            height: 80,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 51, 149, 228),
                      ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    leading: const Iconify(
                      Ri.user_4_fill,
                      color: Color.fromARGB(255, 51, 149, 228),
                      size: 34,
                    ),
                    title: const Text(
                      'My Profile',
                      style: TextStyle(
                        color: Color.fromARGB(255, 51, 149, 228),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: 'Merienda',
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "/profile");
                    },
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 51, 149, 228),
                    indent: 5,
                    endIndent: 5,
                    thickness: 2,
                  ),
                  // ListTile(
                  //   key: const ValueKey("aboutusbtn"),
                  //   leading: const Iconify(
                  //     Ph.info_fill,
                  //     color: Color.fromARGB(255, 51, 149, 228),
                  //     size: 34,
                  //   ),
                  //   title: const Text(
                  //     'About Us',
                  //     style: TextStyle(
                  //       color: Color.fromARGB(255, 51, 149, 228),
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 14,
                  //       fontFamily: 'Merienda',
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     setState(() {
                  //       Navigator.pushNamed(context, '/about');
                  //     });
                  //   },
                  // ),
                  // const Divider(
                  //   color: Color.fromARGB(255, 51, 149, 228),
                  //   indent: 5,
                  //   endIndent: 5,
                  //   thickness: 2,
                  // ),
                  // ListTile(
                  //   leading: const Iconify(
                  //     Ph.heart_fill,
                  //     color: Color.fromARGB(255, 51, 149, 228),
                  //     size: 34,
                  //   ),
                  //   title: const Text(
                  //     'Wishlist',
                  //     style: TextStyle(
                  //       color: Color.fromARGB(255, 51, 149, 228),
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 14,
                  //       fontFamily: 'Merienda',
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     setState(() {
                  //       Navigator.pushNamed(context, '/mybooking');
                  //     });
                  //   },
                  // ),
                  // const Divider(
                  //   color: Color.fromARGB(255, 51, 149, 228),
                  //   indent: 5,
                  //   endIndent: 5,
                  //   thickness: 2,
                  // ),
                  ListTile(
                    leading: const Iconify(
                      Majesticons.clipboard_list,
                      color: Color.fromARGB(255, 51, 149, 228),
                      size: 34,
                    ),
                    title: const Text(
                      'My Booking',
                      style: TextStyle(
                        color: Color.fromARGB(255, 51, 149, 228),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: 'Merienda',
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "/mybooking");
                    },
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 51, 149, 228),
                    indent: 5,
                    endIndent: 5,
                    thickness: 2,
                  ),
                  ListTile(
                    leading: const Iconify(
                      MaterialSymbols.settings_outline,
                      color: Color.fromARGB(255, 51, 149, 228),
                      size: 34,
                    ),
                    title: const Text(
                      'Settings',
                      style: TextStyle(
                        color: Color.fromARGB(255, 51, 149, 228),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: 'Merienda',
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        Navigator.pushNamed(context, '/settings');
                      });
                    },
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 51, 149, 228),
                    indent: 5,
                    endIndent: 5,
                    thickness: 2,
                  ),
                  ListTile(
                    leading: const Iconify(
                      Majesticons.door_exit,
                      color: Color.fromARGB(255, 51, 149, 228),
                      size: 34,
                    ),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Color.fromARGB(255, 51, 149, 228),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: 'Merienda',
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _logoutUser();
                        Navigator.pushNamed(context, "/login");
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:medicine_finder/screen/loginscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController? _controller;
  bool? isLoggedIn;

  @override
  void initState() {
    super.initState();
    startAnimation();
    Timer(
        const Duration(seconds: 5),
        () => {
              if (isLoggedIn == false)
                {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  ),
                }
              else
                {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  ),
                }
            });
  }

  startAnimation() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  loginRoute() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: ((context) => const LoginScreen())));
  }

  String data = '';

  // _getDataFromSharedPref() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? value = prefs.getString("token");
  //   token = value;

  //   if (value != null) {
  //     setState(() {
  //       isLoggedIn = true;
  //       data = value;
  //     });
  //   } else {
  //     setState(() {
  //       isLoggedIn = false;
  //       data = "No Data Found";
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              gradient: LinearGradient(
                  colors: [(Color(0xFF5E35B1)), (Color(0xFF7B1FA2))],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _controller!,
                  child: Image.asset('assets/images/MainGuitarLogo.png'),
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _controller!.value * 2.0 * pi,
                      child: child,
                    );
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Medicine Finder",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    fontFamily: 'Merienda',
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

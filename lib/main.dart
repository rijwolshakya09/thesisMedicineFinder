import 'package:flutter/material.dart';
import 'package:medicine_finder/components/layout.dart';
import 'package:medicine_finder/screen/loginscreen.dart';
import 'package:medicine_finder/screen/splashscreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const SplashScreen(),
      '/layout': (context) => const LayoutScreen(),
      '/login': (context) => const LoginScreen(),
    },
  ));
}

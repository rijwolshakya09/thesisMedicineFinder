import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:medicine_finder/components/layout.dart';
import 'package:medicine_finder/screen/loginscreen.dart';
import 'package:medicine_finder/screen/registerscreen.dart';
import 'package:medicine_finder/screen/splashscreen.dart';

void main() {
  AwesomeNotifications().initialize(
    'resource://drawable/ic_applogo',
    [
      NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color(0xFF6BB3ED),
        importance: NotificationImportance.Max,
        ledColor: Colors.white,
        channelShowBadge: true,
      ),
    ],
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const SplashScreen(),
      '/layout': (context) => const LayoutScreen(),
      '/login': (context) => const LoginScreen(),
      '/register': (context) => const RegisterScreen(),
    },
  ));
}

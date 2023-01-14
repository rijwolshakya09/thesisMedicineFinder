import 'package:flutter/material.dart';

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
        body: Center(
          child: Column(
            children: [
              Container(
                child: const Text("Home Screen"),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/mymap');
                  },
                  child: const Text("Open Map"))
            ],
          ),
        ),
      ),
    );
  }
}

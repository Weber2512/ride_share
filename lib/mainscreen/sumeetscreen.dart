import 'package:flutter/material.dart';
import 'package:ride_share/drawerscreen/drawer.dart';
import 'package:ride_share/mainscreen/input.dart';

class Sumeet extends StatelessWidget {
  const Sumeet({super.key});
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to RideShare!'),
        backgroundColor: const Color.fromARGB(255, 161, 190, 203),
      ),
      drawer: const DrawerList(),
      body: const InputScreen(),
    );
  }
}

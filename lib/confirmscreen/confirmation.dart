import 'package:flutter/material.dart';
import 'package:ride_share/mainscreen/sumeetscreen.dart';
import 'package:ride_share/model/carinfo.dart';

class Confirmation extends StatefulWidget {
  const Confirmation({super.key,required this.car, required this.dropdown});
  final CarInfo car;
  final dropdown;

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confimation Page'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Image.asset(
              'assets/images/confirm-1.png',
              width: 200,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Your Ride is successfully booked!',
              style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => const Sumeet()));
                },
                child: const Text('Home')),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

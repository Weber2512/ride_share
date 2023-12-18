// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ride_share/confirmscreen/FareBreakUp.dart';
import 'package:ride_share/model/carinfo.dart';
import 'package:transparent_image/transparent_image.dart';

String formattedDate = DateFormat.yMMMd().format(DateTime.now());
String formattedTime = DateFormat('h:mm a').format(DateTime.now());

class CarDetailsScreen extends StatelessWidget {
  const CarDetailsScreen({
    super.key,
    required this.car,
    required this.dropdown,
  });

  final CarInfo car;
  final dropdown;

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride Details'),
      ),
      body: ListView(
        children: [
          FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: AssetImage(car.url),
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Car Model: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Text(
                      car.carName,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'Car No: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Text(
                      car.carNo,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'Driver: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Text(
                      car.driverName,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text(
                      'Pickup Location: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Text(
                      car.start.toUpperCase(),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'Drop-off Location: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Text(
                      car.end.toUpperCase(),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text(
                      'Booking Date: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Text(
                      formattedDate,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'Booking Time: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Text(
                      formattedTime,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text(
                      'Total Fare:  ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Text(
                      '₹${car.fare}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                FareBreakUp(
                  car: car,
                  dropdown: dropdown,
                  date: formattedDate,
                  time: formattedTime,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

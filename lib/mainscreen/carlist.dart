// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:ride_share/mainscreen/cardetails.dart';
import 'package:ride_share/model/carinfo.dart';

class CarList extends StatelessWidget {
  const CarList({super.key, required this.car, required this.dropDownValue});

  final CarInfo car;
  final dropDownValue;

  void detailsScreen(BuildContext context, CarInfo car) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CarDetailsScreen(
          car: car,
          dropdown: dropDownValue,
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: InkWell(
        onTap: () {
          detailsScreen(context, car);
        },
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.directions_car,
                color: Colors.blueGrey[600],
              ),
              title: Text(
                car.carNo,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(car.carName),
              trailing: Icon(
                Icons.circle,
                color: car.color,
                size: 40,
              ),
            ),
            const Divider(),
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.person),
                  const SizedBox(width: 15),
                  Text(car.driverName),
                  const Spacer(),
                  const Icon(Icons.chair_rounded),
                  const SizedBox(width: 10),
                  Text(car.seats.toString()),
                  const Spacer(),
                  const Icon(Icons.currency_rupee_sharp),
                  Text(car.fare),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

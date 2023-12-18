import 'package:flutter/material.dart';
import 'package:ride_share/data/history_data.dart';
import 'package:ride_share/history/favoritecarlist.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    if (dummyHistoryData.isEmpty) {
      return Scaffold(
          appBar: AppBar(
        title: const Text("Ride's History"),
      ));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Ride's History"),
        ),
        body: FavoriteCarsList(favoriteCars: dummyHistoryData),
      );
    }
  }
}

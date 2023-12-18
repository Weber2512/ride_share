// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:ride_share/history/history_car_details.dart';
import 'package:ride_share/model/history_model.dart';
import 'package:transparent_image/transparent_image.dart';

class FavoriteCarsList extends StatefulWidget {
  final List<HistoryInfo> favoriteCars;

  const FavoriteCarsList({super.key, required this.favoriteCars});

  @override
  _FavoriteCarsListState createState() => _FavoriteCarsListState();
}

class _FavoriteCarsListState extends State<FavoriteCarsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.favoriteCars.length,
      itemBuilder: (context, index) {
        HistoryInfo car = widget.favoriteCars[index];
        return ListTile(
          leading: FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: AssetImage(car.url),
            fit: BoxFit.cover,
            height: 100,
            width: 100,
          ),
          title: Text(car.carName),
          subtitle: Text(car.fare),
          trailing: Text(
            car.date,
            style: const TextStyle(color: Colors.red),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CarDetails(car: car),
              ),
            );
          },
        );
      },
    );
  }
}

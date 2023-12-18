// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:ride_share/mainscreen/carlist.dart';
import 'package:ride_share/model/carinfo.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    super.key,
    required this.fliterList,
    required this.dropdown,
  });

  final List<CarInfo> fliterList;
  final dropdown;

  @override
  Widget build(context) {
    Widget content = const Center(
      child: Text('No rides found, try again later.'),
    );
    if (fliterList.isNotEmpty) {
      content = ListView(
        children: [
          for (final car in fliterList)
            CarList(car: car, dropDownValue: dropdown),
        ],
      );
    }
    return Scaffold(appBar: AppBar(), body: content);
  }
}

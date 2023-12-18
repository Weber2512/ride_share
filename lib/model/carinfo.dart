import 'package:flutter/material.dart';

class CarInfo {
  CarInfo({
    required this.carNo,
    required this.carName,
    required this.fare,
    required this.driverName,
    required this.color,
    required this.start,
    required this.end,
    required this.url,
    required this.seats,
    required this.base,
    required this.peak,
    required this.main,
    required this.dis,
    required this.timeFare,
    required this.tax,
    required this.fuel,
  });
  final String carNo;
  final String carName;
  final String fare;
  final Color color;
  final String driverName;
  final String start;
  final String end;
  final String url;
  int seats;
  final int base;
  final int peak;
  final int main;
  final int dis;
  final int timeFare;
  final int tax;
  final int fuel;
}

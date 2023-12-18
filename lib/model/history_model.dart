import 'package:flutter/material.dart';

class HistoryInfo {
  HistoryInfo({
    required this.carNo,
    required this.carName,
    required this.fare,
    required this.driverName,
    required this.color,
    required this.start,
    required this.end,
    required this.url,
    required this.seats,
    required this.date,
    required this.time,
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
  final String date;
  final String time;
}

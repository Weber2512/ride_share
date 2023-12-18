//ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:ride_share/data/history_data.dart';
import 'package:ride_share/model/carinfo.dart';
import 'package:ride_share/model/history_model.dart';
import 'confirmation.dart';

class FareBreakUp extends StatefulWidget {
  const FareBreakUp(
      {super.key,
      required this.car,
      required this.dropdown,
      required this.date,
      required this.time});
  final CarInfo car;
  final dropdown;
  final String date;
  final String time;

  @override
  State<FareBreakUp> createState() => _FareBreakUpState();
}

class _FareBreakUpState extends State<FareBreakUp> {
  void breakup() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return ListView(
            children: <Widget>[
              const Center(
                  child: Text(
                'Fare Break up',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )),
              DataTable(
                columns: const [
                  DataColumn(
                      label: Text('Sr. No.',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Parameters',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Fare',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                ],
                rows: [
                  DataRow(cells: [
                    const DataCell(Text(
                      '1',
                      style: TextStyle(fontSize: 16),
                    )),
                    const DataCell(Text(
                      'Base Fare',
                      style: TextStyle(fontSize: 16),
                    )),
                    DataCell(Text(
                      widget.car.base.toString(),
                      style: const TextStyle(fontSize: 16),
                    )),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text(
                      '2',
                      style: TextStyle(fontSize: 16),
                    )),
                    const DataCell(Text(
                      'Peak Pricing',
                      style: TextStyle(fontSize: 16),
                    )),
                    DataCell(Text(
                      widget.car.peak.toString(),
                      style: const TextStyle(fontSize: 16),
                    )),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text(
                      '3',
                      style: TextStyle(fontSize: 16),
                    )),
                    const DataCell(Text(
                      'Maintainance',
                      style: TextStyle(fontSize: 16),
                    )),
                    DataCell(Text(
                      widget.car.main.toString(),
                      style: const TextStyle(fontSize: 16),
                    )),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text(
                      '4',
                      style: TextStyle(fontSize: 16),
                    )),
                    const DataCell(Text(
                      'Distance Fare',
                      style: TextStyle(fontSize: 16),
                    )),
                    DataCell(Text(
                      widget.car.dis.toString(),
                      style: const TextStyle(fontSize: 16),
                    )),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text(
                      '5',
                      style: TextStyle(fontSize: 16),
                    )),
                    const DataCell(Text(
                      'Ride Time Fare',
                      style: TextStyle(fontSize: 16),
                    )),
                    DataCell(Text(
                      widget.car.timeFare.toString(),
                      style: const TextStyle(fontSize: 16),
                    )),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text(
                      '6',
                      style: TextStyle(fontSize: 16),
                    )),
                    const DataCell(Text(
                      'Taxes',
                      style: TextStyle(fontSize: 16),
                    )),
                    DataCell(Text(
                      widget.car.tax.toString(),
                      style: const TextStyle(fontSize: 16),
                    )),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text(
                      '7',
                      style: TextStyle(fontSize: 16),
                    )),
                    const DataCell(Text(
                      'Fuel',
                      style: TextStyle(fontSize: 16),
                    )),
                    DataCell(Text(
                      widget.car.fuel.toString(),
                      style: const TextStyle(fontSize: 16),
                    )),
                  ]),
                ],
              ),
              ElevatedButton(
                  onPressed: confirmbooking,
                  child: const Text('Confirm Booking')),
            ],
          );
        });
  }

  void confirmbooking() {
    // update seats
    print(widget.dropdown);
    int userSeats = widget.dropdown;
    widget.car.seats -= userSeats;
    dummyHistoryData.add(
      HistoryInfo(
        carNo: widget.car.carNo,
        carName: widget.car.carName,
        fare: widget.car.fare,
        driverName: widget.car.driverName,
        color: widget.car.color,
        start: widget.car.start,
        end: widget.car.end,
        url: widget.car.url,
        seats: widget.dropdown,
        time: widget.time,
        date: widget.date,
      ),
    );

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Confirmation(
              car: widget.car,
              dropdown: widget.dropdown,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Center(
          child: Row(
            children: [
              ElevatedButton(
                onPressed: breakup,
                child: const Text(
                  'Fare Break-up',
                  style: TextStyle(fontSize: 17),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: confirmbooking,
                child: const Text(
                  'Confirm Booking',
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

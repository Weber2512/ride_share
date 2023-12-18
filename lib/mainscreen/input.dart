import 'package:flutter/material.dart';
import 'package:ride_share/mainscreen/carouselitem.dart';
import 'package:ride_share/data/cardata.dart';
import 'package:ride_share/model/carinfo.dart';
import 'package:ride_share/mainscreen/search.dart';
import 'package:carousel_slider/carousel_slider.dart';

const List<int> list = [1, 2, 3, 4];

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  var _from = '';
  var _to = '';
  int _dropDownValue = list.first;
  void _searchPage(BuildContext context, List<CarInfo> filterList) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchScreen(
          fliterList: filterList,
          dropdown: _dropDownValue,
        ),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final filteredCars = dummyCarData
          .where(
            (car) =>
                car.start == _from.toLowerCase() &&
                car.end == _to.toLowerCase() &&
                car.seats >= _dropDownValue,
          )
          .toList();
      _searchPage(context, filteredCars);
      setState(() {
        _formKey.currentState!.reset();
        //_dropDownValue = list.first;
      });
    }
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.location_on_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        label: Text('From:'),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().isEmpty) {
                          return 'Enter the start location.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _from = value!.trim();
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        label: Text('To:'),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().isEmpty) {
                          return 'Enter the destiation.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _to = value!.trim();
                      },
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                label: Text('No. of Seats'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              value: _dropDownValue,
                              items: [
                                for (final value in list)
                                  DropdownMenuItem(
                                    value: value,
                                    child: Row(
                                      children: [
                                        const Icon(Icons
                                            .airline_seat_recline_normal_rounded),
                                        const SizedBox(width: 8),
                                        Text("$value"),
                                      ],
                                    ),
                                  )
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _dropDownValue = value!;
                                  print(_dropDownValue);
                                });
                              }),
                        ),
                        const SizedBox(width: 5),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _formKey.currentState!.reset();
                              _dropDownValue = list.first;
                            });
                          },
                          child: const Text('Reset'),
                        ),
                        const SizedBox(width: 5),
                        ElevatedButton(
                          onPressed: () {
                            _saveForm();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text('Search'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          CarouselSlider(
            items: const [
              CarouselItem(url: 'assets/images/slider1.jpg'),
              CarouselItem(url: 'assets/images/slider2.jpg'),
              CarouselItem(url: 'assets/images/slider3.jpg'),
              CarouselItem(url: 'assets/images/slider4.png'),
            ],
            options: CarouselOptions(
              height: 250,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 600),
              viewportFraction: 1,
            ),
          ),
        ],
      ),
    );
  }
}

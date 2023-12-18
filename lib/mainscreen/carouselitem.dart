import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  const CarouselItem({super.key, required this.url});

  final String url;

  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: AssetImage(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

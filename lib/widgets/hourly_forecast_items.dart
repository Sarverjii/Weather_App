import 'package:flutter/material.dart';

class HourlyForcastItems extends StatelessWidget {
  final String temp;
  final IconData iconn;
  final String weather;
  final String weatherdescription;
  final String time;
  const HourlyForcastItems(
      {super.key,
      required this.iconn,
      required this.temp,
      required this.weather,
      required this.weatherdescription,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      elevation: 6,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 8,
            ),
            Icon(
              iconn,
              size: 32,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              weatherdescription,
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              weather,
              style: const TextStyle(fontSize: 15),
            ),
            Text(temp,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}

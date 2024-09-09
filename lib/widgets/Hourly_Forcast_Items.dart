import 'package:flutter/material.dart';

class HourlyForcastItems extends StatelessWidget {
  final String temp;
  final IconData iconn;
  final String time;
  const HourlyForcastItems(
      {super.key, required this.iconn, required this.temp, required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      elevation: 6,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(6),
        child: Column(
          children: [
            Text(
              time,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              temp,
            )
          ],
        ),
      ),
    );
  }
}

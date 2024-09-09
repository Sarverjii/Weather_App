import 'package:flutter/material.dart';

class AdditionalInfoContainer extends StatelessWidget {
  final String heading;
  final String value;
  final IconData? iconn;

  const AdditionalInfoContainer(
      {super.key,
      required this.iconn,
      required this.value,
      required this.heading});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Column(
        children: [
          Icon(
            iconn,
            size: 32,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            heading,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            value,
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LCard extends StatelessWidget {
  final String title;
  final DateTime? startDate;
  final bool? isActive;
  final String? hostId;
  const LCard({
    super.key,
    required this.title,
    this.startDate,
    this.isActive,
    this.hostId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black87,
        ),
        width: double.infinity,
        height: 200,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(title, style: const TextStyle(color: Colors.white)),
            Text(
              startDate!.day.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              startDate!.month.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              startDate!.year.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              isActive.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              hostId.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

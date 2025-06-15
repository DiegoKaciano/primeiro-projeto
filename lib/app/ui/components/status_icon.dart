import 'package:flutter/material.dart';

class StatusIcon extends StatelessWidget {
  final IconData icon;
  final String total;

  const StatusIcon({
    super.key,
    required this.icon,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.grey,
        ),
        SizedBox(width: 4),
        Text(
          total.toString(),
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}

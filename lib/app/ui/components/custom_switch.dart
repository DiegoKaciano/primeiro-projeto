import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool isFinished;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    super.key,
    required this.isFinished,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Jogo Finalizado",
          style: TextStyle(color: Colors.white70),
        ),
        Switch(
          value: isFinished,
          onChanged: onChanged,
          activeColor: Colors.blueAccent,
        ),
      ],
    );
  }
}

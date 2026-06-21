import 'package:flutter/material.dart';

class SuccessView extends StatelessWidget {
  final String text;
  const SuccessView(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return StateView(text, icon: Icons.done, color: Colors.green);
  }
}

class StateView extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  const StateView(this.text, {super.key, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(icon, color: color, size: 50),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: color, decoration: TextDecoration.none, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

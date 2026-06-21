import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title, message;
  const ConfirmationDialog(this.title, this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(child: Text("Nein"), onPressed: () => Navigator.pop(context, false)),
        ElevatedButton(child: Text("Ja"), onPressed: () => Navigator.pop(context, true))
      ],
    );
  }

  static Future<bool> show(BuildContext context, String title, String message) async {
    return await showDialog(context: context, builder: (context) => ConfirmationDialog(title, message)) == true;
  }
}

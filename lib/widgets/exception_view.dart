import 'package:flutter/material.dart';

class ExceptionView extends StatelessWidget {
  final Object? exception;

  const ExceptionView(this.exception, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: ObjectKey(exception),
      initialValue: exception.toString(),
      maxLines: null,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    );
  }
}

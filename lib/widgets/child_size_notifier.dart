import 'dart:math';

import 'package:flutter/material.dart';

class ChildSizeNotifier extends StatelessWidget {
  final Widget Function(BuildContext context, Size size) builder;
  const ChildSizeNotifier({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return builder(
          context,
          Size(min(constraints.maxWidth, size.width), min(constraints.maxHeight, size.height)),
        );
      },
    );
  }
}

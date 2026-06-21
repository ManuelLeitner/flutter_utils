import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';

void showSnackBar(BuildContext context, String message) {
  if (context.mounted) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

FutureOr<T?> notifyAction<T>(
  BuildContext context,
  FutureOr<T> Function() action, {
  String Function(T)? messageBuilder,
  bool pop = false,
  String Function(Object error)? errorBuilder,
  String? confirmationTitle,
  String? confirmationMessage,
}) async {
  if (confirmationTitle != null &&
      confirmationMessage != null &&
      !await ConfirmationDialog.show(
        context,
        confirmationTitle,
        confirmationMessage,
      )) {
    return null;
  }

  while (true) {
    try {
      var res = await action();
      if (!context.mounted) return res;

      if (messageBuilder != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(messageBuilder(res))));
      }

      if (pop) Navigator.pop(context, res);
      return res;
    } catch (e, stack) {
      FlutterUtils.errorLogger?.call(e, stackTrace: stack);
      if (!context.mounted) return null;

      showSnackBar(
        context,
        errorBuilder != null
            ? errorBuilder(e)
            : "Ein Fehler ist aufgetreten:\n$e",
      );
    }
    break;
  }
  return null;
}

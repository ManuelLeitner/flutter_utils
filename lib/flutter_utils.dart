export 'widgets/child_size_notifier.dart';
export 'widgets/confirmation_dialog.dart';
export 'widgets/exception_view.dart';
export 'widgets/floating_action_button_spacer.dart';
export 'widgets/media_query_extension.dart';
export 'widgets/number_form_field.dart';
export 'widgets/snackbar.dart';
export 'widgets/state_view.dart';
export 'widgets/streamed_list_view.dart';
export 'widgets/string_extension.dart';

export 'extension.dart';
export 'string_comparison.dart';

class FlutterUtils {
  static void Function(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  })?
  errorLogger;
}

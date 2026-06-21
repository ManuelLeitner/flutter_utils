import 'dart:async';

import 'package:flutter/material.dart';
import '../flutter_utils.dart';
import 'exception_view.dart';

class StreamedListView<T> extends StatelessWidget {
  final Stream<List<T>> stream;
  final Axis direction;
  final Widget Function(T) builder;

  final ScrollPhysics? physics;

  const StreamedListView({
    super.key,
    this.physics,
    required this.stream,
    required this.builder,
    this.direction = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return StreamedView(
      stream: stream,
      builder: (data) {
        return ListView.builder(
          scrollDirection: direction,
          shrinkWrap: true,
          physics: physics,
          itemCount: data.length,
          itemBuilder: (context, index) => builder(data[index]),
        );
      },
    );
  }
}

class StreamedView<T> extends StatefulWidget {
  final Stream<T> stream;
  final Widget Function(T) builder;

  const StreamedView({super.key, required this.stream, required this.builder});

  @override
  State<StreamedView<T>> createState() => _StreamedViewState<T>();
}

class _StreamedViewState<T> extends State<StreamedView<T>> {
  T? data;
  dynamic exception;
  bool loaded = false;
  StreamSubscription? subscription;

  StackTrace? stack;

  @override
  void initState() {
    super.initState();
    subscription = widget.stream.listen(
      (d) => setState(() {
        data = d;
        exception = null;
        loaded = true;
      }),
      onError: (e, st) => setState(() {
        exception = e;
        stack = st;
        data = null;
        loaded = true;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      FlutterUtils.errorLogger?.call(
        "Exception caught in StreamView",
        error: exception,
        stackTrace: stack,
      );
      return ExceptionView(exception);
    }
    if (loaded) {
      return widget.builder(data as T);
    }
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    unawaited(subscription?.cancel());
    super.dispose();
  }
}

class FutureView<T> extends StatefulWidget {
  final Future<T> future;
  final Widget Function(T) builder;

  const FutureView({super.key, required this.future, required this.builder});

  @override
  State<FutureView<T>> createState() => _FutureViewState<T>();
}

class _FutureViewState<T> extends State<FutureView<T>> {
  T? data;
  dynamic exception;
  bool loaded = false;
  dynamic stackTrace;

  @override
  void initState() {
    unawaited(
      widget.future.then(
        (d) {
          if (!mounted) return;
          setState(() {
            data = d;
            exception = null;
            loaded = true;
            stackTrace = null;
          });
        },
        onError: (e, stack) {
          if (!mounted) return;
          setState(() {
            exception = e;
            data = null;
            loaded = true;
            stackTrace = stack;
          });
        },
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      FlutterUtils.errorLogger?.call(
        "Exception caught in StreamView",
        error: exception,
        stackTrace: stackTrace,
      );
      return ExceptionView(exception);
    }

    if (loaded) {
      return widget.builder(data as T);
    }

    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
}

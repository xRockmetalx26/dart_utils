// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

final class TicksWidget extends StatefulWidget {
  const TicksWidget({
    required super.key,
    required this.child,
    required this.builder,
    this.ticks = 60,
    this.interval = const Duration(seconds: 1),
    this.startOnInit = true,
  });

  final Widget child;
  final Widget Function(BuildContext context, int ticks) builder;

  final int ticks;
  final Duration interval;
  final bool startOnInit;

  @override
  State<TicksWidget> createState() => TicksWidgetState();
}

final class TicksWidgetState extends State<TicksWidget> {
  Timer? _timer;

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void initState() {
    super.initState();

    if (widget.startOnInit) run();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = (_timer?.isActive ?? false)
        ? widget.builder(context, _timer!.tick)
        : widget.child;

    return child;
  }

  void run() {
    _timer = Timer.periodic(widget.interval, (_) {
      setState(() {
        if (_timer!.tick > widget.ticks) _timer!.cancel();
      });
    });
  }
}

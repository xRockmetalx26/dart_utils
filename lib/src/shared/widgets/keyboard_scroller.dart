// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

final class KeyboardScroller extends StatelessWidget {
  const KeyboardScroller({
    super.key,
    required this.scrollController,
    required this.builder,
    this.focusNode,
  });

  final ScrollController scrollController;
  final Widget Function(BuildContext context, bool isVisible) builder;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isVisible) {
        final permission = focusNode?.hasFocus ?? true;
        if (isVisible && permission) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          });
        }

        return builder(context, isVisible);
      },
    );
  }
}

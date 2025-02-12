// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:dart_utils/src/core/utils/try.dart';

final class AsyncIconButton extends StatefulWidget {
  const AsyncIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconSize = 24,
    this.indicatorColor = Colors.white,
    this.padding,
    this.constraints,
  });

  final Icon icon;
  final Future<void> Function()? onPressed;
  final double iconSize;
  final Color indicatorColor;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;

  @override
  State<AsyncIconButton> createState() => _AsyncIconButtonState();
}

final class _AsyncIconButtonState extends State<AsyncIconButton> {
  // keys
  final _key = GlobalKey();

  // core
  var _isLoading = false;

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final onPressed = widget.onPressed is Function ? _onPressed : null;
    final icon = _isLoading
        ? SizedBox(
            width: widget.iconSize * .50,
            height: widget.iconSize * .50,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(widget.indicatorColor),
            ),
          )
        : widget.icon;

    return IconButton(
      key: _key,
      iconSize: widget.iconSize,
      padding: widget.padding,
      constraints: widget.constraints,
      onPressed: onPressed,
      icon: icon,
    );
  }

  Future<void> _onPressed() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    await Try.asyncCall(call: widget.onPressed!);

    setState(() => _isLoading = false);
  }
}

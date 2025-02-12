// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:dart_utils/src/core/utils/try.dart';

final class AsyncElevatedButton extends StatefulWidget {
  const AsyncElevatedButton({
    super.key,
    required this.style,
    required this.child,
    this.onPressed,
    this.indicatorColor = Colors.white,
  });

  final ButtonStyle style;
  final Widget child;
  final Future<void> Function()? onPressed;
  final Color indicatorColor;

  @override
  State<AsyncElevatedButton> createState() => _AsyncElevatedButtonState();
}

final class _AsyncElevatedButtonState extends State<AsyncElevatedButton> {
  // keys
  final _key = GlobalKey();

  // core
  late Size _size;
  var _isLoading = false;

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    _setSize();

    final onPressed = widget.onPressed is Function ? _onPressed : null;
    final style = _isLoading && widget.style.padding is WidgetStatePropertyAll
        ? widget.style.copyWith(
            padding: const WidgetStatePropertyAll(EdgeInsets.zero),
            minimumSize: WidgetStatePropertyAll(_size),
            maximumSize: WidgetStatePropertyAll(_size),
            fixedSize: WidgetStatePropertyAll(_size),
          )
        : widget.style;

    return ElevatedButton(
      key: _key,
      style: style.copyWith(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      onPressed: onPressed,
      child: IndexedStack(
        index: _isLoading ? 1 : 0,
        alignment: Alignment.center,
        children: [
          widget.child,
          if (_isLoading)
            SizedBox.square(
              dimension: _size.height * .5,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  widget.indicatorColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _onPressed() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    await Try.asyncCall(call: widget.onPressed!);
    // await Try.asyncCall(call: () => Future.delayed(const Duration(seconds: 1)));

    setState(() => _isLoading = false);
  }

  void _setSize() {
    if (_key.currentContext == null) return;

    final box = _key.currentContext!.findRenderObject() as RenderBox;
    _size = box.size;
  }
}

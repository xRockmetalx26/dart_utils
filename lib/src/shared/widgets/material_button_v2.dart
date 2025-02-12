// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:dart_utils/src/shared/app_colors.dart';

final class MaterialButtonV2 extends StatelessWidget {
  const MaterialButtonV2({
    super.key,
    required this.onPressed,
    required this.child,
    this.onLongPressed,
    this.backgroundColor,
    this.splashColor,
    this.highlightColor,
    this.shapeBorder,
  });

  final void Function() onPressed;
  final Widget child;
  final void Function()? onLongPressed;
  final Color? backgroundColor;
  final Color? splashColor;
  final Color? highlightColor;
  final ShapeBorder? shapeBorder;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: backgroundColor,
      splashColor: splashColor ?? AppColors.primarySplash,
      highlightColor: highlightColor ?? AppColors.primaryhighlight,
      elevation: 0,
      highlightElevation: 0,
      minWidth: 0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      shape: shapeBorder,
      onPressed: onPressed,
      onLongPress: onLongPressed,
      child: child,
    );
  }
}

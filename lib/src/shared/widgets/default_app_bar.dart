// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:dart_utils/src/shared/app_colors.dart';
import 'package:dart_utils/src/shared/constant.dart';

final class DefaultAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const DefaultAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.centerTitle = false,
    this.elevation = 0.0,
    this.backgroundColor = AppColors.primary,
    this.foregroundColor = Colors.white,
    this.borderRadius = const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
    ),
  });

  @override
  final Size preferredSize = const Size.fromHeight(80.0);

  final Widget title;
  final Widget? leading;
  final List<Widget>? actions;

  final bool centerTitle;
  final double elevation;
  final Color backgroundColor;
  final Color foregroundColor;
  final ShapeBorder borderRadius;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      toolbarHeight: preferredSize.height,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      shape: borderRadius,
      leading: leading ??
          IconButton(
            onPressed: Navigator.of(context).pop,
            icon: kBackButtonIcon,
          ),
      title: title,
      actions: actions,
    );
  }
}

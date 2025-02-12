// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:dart_utils/src/shared/app_colors.dart';
import 'package:dart_utils/src/shared/constant.dart';
import 'package:dart_utils/src/shared/widgets/async_icon_button.dart';
import 'package:dart_utils/src/shared/widgets/spaces.dart';

final class ErrorView extends StatefulWidget {
  const ErrorView({
    super.key,
    required this.text,
    required this.onRefresh,
    this.textStyle,
    this.foregroundColor = AppColors.primary,
  });

  final String text;
  final Future<void> Function() onRefresh;

  final TextStyle? textStyle;
  final Color foregroundColor;

  @override
  State<ErrorView> createState() => _ErrorViewState();
}

final class _ErrorViewState extends State<ErrorView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.text,
          textAlign: TextAlign.center,
          style: widget.textStyle?.copyWith(color: widget.foregroundColor) ??
              k20Style.copyWith(color: widget.foregroundColor),
        ),
        Spaces.height16,
        AsyncIconButton(
          onPressed: widget.onRefresh,
          iconSize: 64,
          indicatorColor: widget.foregroundColor,
          icon: Icon(
            Icons.refresh,
            color: widget.foregroundColor,
          ),
        ),
      ],
    );
  }
}

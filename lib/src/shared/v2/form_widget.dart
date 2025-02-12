// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:dart_utils/src/core/utils/strings.dart';
import 'package:dart_utils/src/shared/constant.dart';
import 'package:dart_utils/src/shared/widgets/spaces.dart';

abstract class ErrorState<T extends StatefulWidget> extends State<T> {
  String? _errorText;
  String? get errorText => _errorText;
  set errorText(String? errorText) {
    if (errorText != _errorText) {
      setState(() => _errorText = errorText);
    }
  }

  bool get hasError => errorText.isNotBlank;
  Color get errorColor => Theme.of(context).colorScheme.error;
}

final class FormWidget extends StatefulWidget {
  const FormWidget({
    super.key,
    required this.child,
    required this.enabled,
    this.labelText,
    this.labelTextStyle,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.withMargin = true,
    this.withShadow = true,
  });

  final Widget child;
  final String? labelText;
  final TextStyle? labelTextStyle;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final bool enabled;
  final bool withMargin;
  final bool withShadow;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

final class _FormWidgetState extends ErrorState<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText.isNotBlank) ...[
          Text(
            widget.labelText!,
            style: widget.labelTextStyle ?? kNormalStyle,
          ),
          Spaces.height8,
        ],
        Container(
          padding: widget.padding ?? const EdgeInsets.all(10),
          margin: widget.withMargin
              ? const EdgeInsets.symmetric(horizontal: 2)
              : null,
          decoration: BoxDecoration(
            color: widget.enabled
                ? (widget.backgroundColor ?? Colors.white)
                : Colors.grey.shade300,
            borderRadius: widget.borderRadius ??
                const BorderRadius.all(Radius.circular(10)),
            border: hasError ? Border.all(color: errorColor) : null,
            boxShadow: [
              if (widget.withShadow)
                BoxShadow(
                  color: hasError
                      ? errorColor.withOpacity(0.25)
                      : Colors.grey.shade400.withOpacity(0.65),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: widget.child,
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              errorText!,
              style: kSmallStyle.copyWith(color: errorColor),
            ),
          ),
      ],
    );
  }
}

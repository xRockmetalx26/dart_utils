// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:dart_utils/src/shared/constant.dart';
import 'package:dart_utils/src/shared/v1/text_field_v1.dart';
import 'package:dart_utils/src/shared/v2/form_widget.dart';

final class TextFieldV2 extends StatefulWidget {
  const TextFieldV2({
    super.key,
    this.controller,
    this.onChanged,
    this.onSaved,
    this.initialValue,
    this.textStyle,
    this.labelText,
    this.labelTextStyle,
    this.hintText,
    this.hintTextStyle,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.keyboardType,
    this.focusNode,
    this.validator,
    this.inputFormatters,
    this.prefix,
    this.suffix,
    this.maxLines,
    this.maxLength,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.hideCounterText = false,
    this.readOnly = false,
    this.scrollPhysics = const ClampingScrollPhysics(),
    this.withMargin = true,
    this.withShadow = true,
  });

  final TextEditingController? controller;
  final FormFieldSetter<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final TextStyle? textStyle;
  final String? labelText;
  final TextStyle? labelTextStyle;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefix;
  final Widget? suffix;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;
  final TextAlign textAlign;
  final bool obscureText;
  final bool hideCounterText;
  final bool readOnly;
  final ScrollPhysics scrollPhysics;
  final bool withMargin;
  final bool withShadow;

  @override
  State<TextFieldV2> createState() => _TextFieldV2State();
}

final class _TextFieldV2State extends ErrorState<TextFieldV2> {
  // keys
  final _errorKey = GlobalKey<ErrorState>();

  @override
  Widget build(BuildContext context) {
    return FormWidget(
      key: _errorKey,
      enabled: widget.enabled,
      labelText: widget.labelText,
      labelTextStyle: widget.labelTextStyle,
      backgroundColor: widget.backgroundColor,
      borderRadius: widget.borderRadius,
      padding: widget.padding,
      withMargin: widget.withMargin,
      withShadow: widget.withShadow,
      child: Padding(
        padding: widget.prefix is Widget || widget.suffix is Widget
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(vertical: 6.5),
        child: TextFormFieldV1(
          controller: widget.controller,
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
          validator: (value) {
            final errorText = widget.validator?.call(value);

            _errorKey.currentState?.errorText = errorText;

            return errorText;
          },
          initialValue: widget.initialValue,
          keyboardType: widget.keyboardType,
          focusNode: widget.focusNode,
          inputFormatters: widget.inputFormatters,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          enabled: widget.enabled,
          textAlign: widget.textAlign,
          obscureText: widget.obscureText,
          readOnly: widget.readOnly,
          scrollPhysics: widget.scrollPhysics,
          style: widget.textStyle ?? kBigStyle,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: widget.hintTextStyle ??
                kNormalStyle.copyWith(color: Colors.grey),
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffix,
            counterText: widget.hideCounterText ? '' : null,
            hintMaxLines: widget.maxLines,
            isCollapsed: true,
            prefixIconConstraints:
                const BoxConstraints.tightForFinite(height: 32),
            suffixIconConstraints:
                const BoxConstraints.tightForFinite(height: 32),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            errorBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

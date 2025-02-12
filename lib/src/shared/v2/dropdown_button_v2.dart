// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:dart_utils/src/core/utils/strings.dart';
import 'package:dart_utils/src/core/utils/typedef.dart';
import 'package:dart_utils/src/shared/app_colors.dart';
import 'package:dart_utils/src/shared/constant.dart';
import 'package:dart_utils/src/shared/v1/dropdown_v1.dart';
import 'package:dart_utils/src/shared/v2/form_widget.dart';

final class DropdownButtonV2<T extends Object> extends StatefulWidget {
  const DropdownButtonV2({
    super.key,
    required this.items,
    this.initialValue,
    this.onInit,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.labelText,
    this.labelTextStyle,
    this.hintText,
    this.hintTextStyle,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.enabled = true,
    this.showDivider = true,
    this.withMargin = true,
    this.withShadow = true,
  });

  final List<DropdownItem<T>> items;
  final DropdownItem<T>? initialValue;
  final void Function(T? value)? onInit;
  final void Function(DropdownItem<T>? item)? onChanged;
  final void Function(DropdownItem<T>? item)? onSaved;
  final String? Function(DropdownItem<T>? item)? validator;
  final String? labelText;
  final TextStyle? labelTextStyle;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final bool enabled;
  final bool showDivider;
  final bool withMargin;
  final bool withShadow;

  @override
  State<DropdownButtonV2<T>> createState() => _DropdownButtonV2State<T>();
}

final class _DropdownButtonV2State<T extends Object>
    extends State<DropdownButtonV2<T>> {
  // keys
  final _errorKey = GlobalKey<ErrorState>();

  // core
  late DropdownItem<T>? item = widget.initialValue;

  @override
  void initState() {
    super.initState();
    widget.onInit?.call(widget.initialValue?.value);
  }

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
      child: DropdownButtonFormFieldV1<DropdownItem<T>>(
        items: widget.showDivider
            ? _buildWithDividers()
            : widget.items
                .map(
                  (item) => DropdownMenuItemV1<DropdownItem<T>>(
                    value: item,
                    child: Text(
                      item.label,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: kNormalStyle,
                    ),
                  ),
                )
                .toList(),
        value: item,
        onChanged: widget.enabled
            ? (item) {
                if (item != this.item) {
                  setState(() {
                    this.item = item;
                    widget.onChanged?.call(item);
                  });
                }
              }
            : null,
        onSaved: widget.onSaved,
        validator: (value) {
          final errorText = widget.validator?.call(value);

          _errorKey.currentState?.errorText = errorText;

          return errorText;
        },
        hint: (widget.hintText.isNotBlank)
            ? Text(
                widget.hintText!,
                style: widget.hintTextStyle ??
                    kNormalStyle.copyWith(color: Colors.grey),
                maxLines: null,
              )
            : null,
        isExpanded: true,
        isDense: false,
        iconSize: 0,
        decoration: InputDecoration(
          hintStyle: widget.hintTextStyle,
          enabled: widget.enabled,
          isCollapsed: true,
          suffixIcon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.primary,
          ),
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
    );
  }

  List<DropdownMenuItemV1<DropdownItem<T>>> _buildWithDividers() {
    final items = <DropdownMenuItemV1<DropdownItem<T>>>[];

    for (final item in widget.items) {
      items.addAll([
        DropdownMenuItemV1<DropdownItem<T>>(
          value: item,
          child: Text(
            item.label,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: kNormalStyle,
          ),
        ),
        if (item != widget.items.last)
          DropdownMenuItemV1<DropdownItem<T>>(
            enabled: false,
            child: const Divider(thickness: 1.5, height: 1.5),
          ),
      ]);
    }

    return items;
  }
}

class DropdownItem<T extends Object> extends Equatable {
  const DropdownItem({
    required this.value,
    required this.label,
  });

  final T value;
  final String label;

  factory DropdownItem.fromJson(Json json) => DropdownItem(
        value: json['_id'] ?? json['key'],
        label: json['name'],
      );

  Json toJson() => {'key': value, 'name': label};

  const DropdownItem.same(this.value) : label = value as String;

  @override
  List<Object?> get props => [
        value,
        label,
      ];
}

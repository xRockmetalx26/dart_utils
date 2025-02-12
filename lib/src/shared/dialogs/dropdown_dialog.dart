// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fluttertoast/fluttertoast.dart';

// Project imports:
import 'package:dart_utils/src/core/app/app_toast.dart';
import 'package:dart_utils/src/shared/app_colors.dart';
import 'package:dart_utils/src/shared/constant.dart';
import 'package:dart_utils/src/shared/v2/dropdown_button_v2.dart';
import 'package:dart_utils/src/shared/widgets/spaces.dart';

final class DropdownDialog<T extends Object> extends StatefulWidget {
  const DropdownDialog({
    super.key,
    required this.iconData,
    required this.description,
    required this.items,
    this.initialValue,
    this.emptyAllowed = false,
  });

  final IconData iconData;
  final String description;
  final Iterable<DropdownItem<T>> items;
  final DropdownItem<T>? initialValue;
  final bool emptyAllowed;

  @override
  State<DropdownDialog<T>> createState() => _DropdownDialogState<T>();

  Future<T?> show(BuildContext context) => showDialog<T>(
        context: context,
        builder: (_) => this,
      );
}

class _DropdownDialogState<T extends Object> extends State<DropdownDialog<T>> {
  late T? _value = widget.initialValue?.value;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: kDialogBorder,
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(
                  widget.iconData,
                  color: AppColors.primary,
                  size: 64,
                ),
                Spaces.height8,
                Text(
                  widget.description,
                  textAlign: TextAlign.center,
                  style: kBiggestStyle,
                ),
                Spaces.height16,
                // items
                DropdownButtonV2<T>(
                  items: widget.items.toList(),
                  initialValue: widget.initialValue,
                  onChanged: (item) => _value = item?.value,
                ),
                Spaces.height16,
                Row(
                  children: [
                    // cancelar
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          if (context.mounted) Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel',
                          style: kBigStyle,
                        ),
                      ),
                    ),
                    Spaces.height16,
                    // ok
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          if (_value == null) {
                            AppToast.show(
                          'Select valid value',
                              gravity: ToastGravity.BOTTOM,
                            );
                            return;
                          }

                          if (mounted) Navigator.of(context).pop(_value);
                        },
                        child: Text(
                          'Ok',
                          style: kBigStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

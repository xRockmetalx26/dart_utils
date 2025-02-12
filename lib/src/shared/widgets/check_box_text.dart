// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:dart_utils/src/shared/constant.dart';
import 'package:dart_utils/src/shared/widgets/spaces.dart';

final class CheckBoxText extends StatefulWidget {
  const CheckBoxText({
    super.key,
    required this.text,
    required this.onInit,
    required this.onChanged,
    this.initialValue,
  });

  final String text;
  final ValueChanged<bool> onInit;
  final ValueChanged<bool> onChanged;
  final bool? initialValue;

  @override
  State<CheckBoxText> createState() => _CheckBoxTextState();
}

final class _CheckBoxTextState extends State<CheckBoxText> {
  // core
  late var _enabled = widget.initialValue ?? false;

  @override
  void initState() {
    super.initState();
    widget.onInit(_enabled);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _enabled,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: _onChanged,
        ),
        Spaces.width4,
        Text(
          widget.text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: kBigStyle,
        ),
      ],
    );
  }

  void _onChanged(bool? value) {
    if (value == null) return;

    setState(() => _enabled = value);

    widget.onChanged(_enabled);
  }
}

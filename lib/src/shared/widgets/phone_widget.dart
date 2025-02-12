// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:mask/mask/mask.dart';

// Project imports:
import 'package:dart_utils/src/core/data/form_data/phone_data.dart';
import 'package:dart_utils/src/shared/constant.dart';
import 'package:dart_utils/src/shared/v2/text_field_v2.dart';
import 'package:dart_utils/src/shared/widgets/country_picker.dart';

final class PhoneWidget extends StatefulWidget {
  const PhoneWidget({
    super.key,
    required this.onChanged,
    this.onInit,
    this.initialValue,
    this.backgroundColor,
    this.padding,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.withShadow = true,
    this.withLabel = false,
  });

  final void Function(PhoneData data) onChanged;
  final void Function(PhoneData data)? onInit;

  final String? initialValue;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final BorderRadius borderRadius;
  final bool withShadow;
  final bool withLabel;

  @override
  State<PhoneWidget> createState() => _PhoneWidgetState();
}

final class _PhoneWidgetState extends State<PhoneWidget> {
  // core
  var obscure = false;

  // data
  final _data = PhoneData();

  @override
  Widget build(BuildContext context) {
    return TextFieldV2(
      withShadow: widget.withShadow,
      withMargin: false,
      labelText: widget.withLabel ? 'appTexts.phone' : null,
      hintText: '123-123-1234',
      backgroundColor: widget.backgroundColor,
      borderRadius: widget.borderRadius,
      padding: widget.padding,
      keyboardType: TextInputType.number,
      obscureText: obscure,
      maxLines: 1,
      textAlign: TextAlign.center,
      inputFormatters: [
        LengthLimitingTextInputFormatter(14),
        Mask.generic(
          masks: [
            '###-###-####',
            '###-####-####',
            '####-####-####',
          ],
        ),
        FilteringTextInputFormatter.allow(RegExp(r'[0-9-]{0,14}')),
      ],
      validator: (_) => _data.isValid ? null : 'appTexts.invalidPhone',
      onChanged: (value) => widget.onChanged(_data..suffixPhone = value),
      prefix: CountryPicker(
        initialSelection: kDefaultCountryCode,
        foregroundColor: Colors.black54,
        onInit: (value) {
          _data.prefixPhone = value?.dialCode;
          widget.onInit?.call(_data);
        },
        onChanged: (value) {
          widget.onChanged(_data..prefixPhone = value?.dialCode);
        },
      ),
      suffix: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () => setState(() => obscure = !obscure),
        icon: Icon(
          obscure ? Icons.visibility : Icons.visibility_off,
          color: Colors.grey,
        ),
      ),
    );
  }
}

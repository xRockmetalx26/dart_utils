// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:dart_utils/src/core/data/form_data/dni_data.dart';
import 'package:dart_utils/src/core/utils/venezuela_dni.dart';
import 'package:dart_utils/src/shared//v2/dropdown_button_v2.dart';
import 'package:dart_utils/src/shared/v2/text_field_v2.dart';

final class DniWidget extends StatefulWidget {
  const DniWidget({
    super.key,
    required this.onChanged,
    this.onInit,
    this.controller,
    this.padding,
    this.backgroundColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.withShadow = true,
  });

  final void Function(DniData data) onChanged;
  final void Function(DniData data)? onInit;

  final TextEditingController? controller;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final BorderRadius borderRadius;
  final bool withShadow;

  @override
  State<DniWidget> createState() => _DniWidgetState();
}

final class _DniWidgetState extends State<DniWidget> {
  // core
  var obscure = true;

  // data
  final _data = DniData();

  @override
  Widget build(BuildContext context) {
    return TextFieldV2(
      controller: widget.controller,
      withShadow: widget.withShadow,
      withMargin: false,
      hintText: 'appTexts.dni',
      backgroundColor: widget.backgroundColor,
      borderRadius: widget.borderRadius,
      padding: widget.padding,
      keyboardType: TextInputType.number,
      obscureText: obscure,
      maxLines: 1,
      textAlign: TextAlign.center,
      inputFormatters: [
        LengthLimitingTextInputFormatter(8),
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]{0,8}')),
      ],
      validator: (_) => _data.isValid ? null : 'appTexts.invalidDni',
      onChanged: (value) => widget.onChanged(_data..suffixDni = value),
      prefix: Transform.translate(
        offset: const Offset(10, 0),
        child: SizedBox(
          width: 36,
          child: DropdownButtonV2(
            initialValue: const DropdownItem.same(VenezuelaDni.defaultPrefix),
            withShadow: false,
            withMargin: false,
            padding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            onInit: (value) {
              _data.prefixDni = value;
              widget.onInit?.call(_data);
            },
            onChanged: (item) {
              widget.onChanged(_data..prefixDni = item?.value);
            },
            items: VenezuelaDni.prefixes
                .map((prefix) => DropdownItem.same(prefix))
                .toList(),
          ),
        ),
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

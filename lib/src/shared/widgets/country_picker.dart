// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:country_code_picker/country_code_picker.dart';

// Project imports:
import 'package:dart_utils/src/shared/constant.dart';

final class CountryPicker extends StatelessWidget {
  const CountryPicker({
    super.key,
    required this.onChanged,
    this.onInit,
    this.textStyle,
    this.initialSelection = 'VE',
    this.backgroundColor = Colors.white,
    this.foregroundColor = Colors.black87,
  });

  final ValueChanged<CountryCode?>? onInit;
  final ValueChanged<CountryCode?> onChanged;

  final String initialSelection;
  final Color backgroundColor;
  final Color foregroundColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height * .75;
    final style = textStyle?.copyWith(color: foregroundColor) ??
        kNormalStyle.copyWith(color: foregroundColor);

    final border = UnderlineInputBorder(
      borderSide: BorderSide(color: foregroundColor),
    );

    return Theme(
      data: ThemeData(
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: foregroundColor),
      ),
      child: CountryCodePicker(
        barrierColor: Colors.black.withOpacity(.20),
        padding: EdgeInsets.zero,
        initialSelection: initialSelection,
        searchPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        textStyle: style,
        dialogTextStyle: style,
        searchStyle: style,
        dialogBackgroundColor: backgroundColor,
        onInit: (value) => onInit?.call(value),
        onChanged: (value) => onChanged(value),
        closeIcon: Icon(
          Icons.close,
          color: foregroundColor,
        ),
        searchDecoration: InputDecoration(
          border: border,
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border,
          disabledBorder: border,
          focusedErrorBorder: border,
          prefixIcon: Icon(
            Icons.search,
            color: foregroundColor,
          ),
        ),
        dialogSize: Size.square(size),
        emptySearchBuilder: (_) => Center(
          child: Text(
            'appTexts.noCountryFound,',
            style: style,
          ),
        ),
      ),
    );
  }
}

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:dart_utils/src/shared/constant.dart';

final class AppBarSearch extends StatefulWidget {
  const AppBarSearch({
    super.key,
    required this.onChanged,
    required this.onClear,
    this.controller,
    this.focus,
  });

  final void Function(String? value) onChanged;
  final void Function() onClear;
  final TextEditingController? controller;
  final FocusNode? focus;

  @override
  State<AppBarSearch> createState() => _AppBarSearchState();
}

final class _AppBarSearchState extends State<AppBarSearch> {
  static const defaultBarSearchHeight = 40.0;

  // widgets
  final border = const OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(defaultBarSearchHeight)),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: defaultBarSearchHeight,
      child: Theme(
        data: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: Colors.white.withOpacity(.5),
            cursorColor: Colors.white.withOpacity(.5),
            selectionHandleColor: Colors.white.withOpacity(.5),
          ),
        ),
        child: TextFormField(
          controller: widget.controller,
          scrollPhysics: const ClampingScrollPhysics(),
          focusNode: widget.focus,
          cursorColor: Colors.white,
          minLines: 1,
          expands: false,
          autocorrect: false,
          enableSuggestions: false,
          style: kBiggestStyle.copyWith(color: Colors.white),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            fillColor: Colors.white.withOpacity(.25),
            filled: true,
            alignLabelWithHint: true,
            enabledBorder: border,
            focusedBorder: border,
            border: border,
            suffixIcon: (widget.controller?.text.isEmpty ?? true)
                ? null
                : IconButton(
                    onPressed: _onClear,
                    color: Colors.white,
                    icon: const Icon(Icons.close),
                  ),
          ),
          onChanged: _onChanged,
        ),
      ),
    );
  }

  void _onChanged(String value) {
    setState(() {});
    widget.onChanged(value);
  }

  void _onClear() {
    setState(() {});
    widget.onClear();
  }
}

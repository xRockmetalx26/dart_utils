// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:url_launcher/url_launcher_string.dart';

// Project imports:
import 'package:dart_utils/src/shared/app_colors.dart';

final class TermsAndPolicies extends StatefulWidget {
  const TermsAndPolicies({
    required super.key,
    required this.policiesLink,
    required this.termsLink,
    this.style,
    this.initialValue = false,
    this.activeColor = Colors.grey,
  });

  final String policiesLink;
  final String termsLink;
  final TextStyle? style;
  final bool initialValue;
  final Color activeColor;

  @override
  State<TermsAndPolicies> createState() => TermsAndPoliciesState();
}

final class TermsAndPoliciesState extends State<TermsAndPolicies> {
  // core
  late var _accepted = widget.initialValue;
  bool get accepted => _accepted;

  var _hasError = false;
  bool get hasError => _hasError;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FittedBox(
          child: Checkbox(
            activeColor: widget.activeColor,
            side: _hasError
                ? const BorderSide(color: Colors.red, width: 2)
                : null,
            value: _accepted,
            onChanged: _onChanged,
          ),
        ),
        Expanded(
          child: Text.rich(
            style: widget.style,
            TextSpan(
              text: 'appTexts.messagePolicy',
              children: [
                TextSpan(
                  text: 'appTexts.privacyPolicy',
                  style: const TextStyle(
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      if (await canLaunchUrlString(widget.policiesLink)) {
                        launchUrlString(widget.policiesLink);
                      }
                    },
                ),
                TextSpan(text: 'appTexts.acceptMessage'),
                TextSpan(
                  text: 'appTexts.termsAndConditions',
                  style: const TextStyle(
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      if (await canLaunchUrlString(widget.termsLink)) {
                        launchUrlString(widget.termsLink);
                      }
                    },
                ),
                TextSpan(text: 'appTexts.ofCc200'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onChanged(bool? accepted) {
    setState(() => _accepted = accepted ?? false);
  }

  void onError() {
    setState(() => _hasError = true);
  }
}

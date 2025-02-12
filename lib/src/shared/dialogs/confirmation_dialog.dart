// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:dart_utils/src/shared/app_colors.dart';
import 'package:dart_utils/src/shared/constant.dart';
import 'package:dart_utils/src/shared/widgets/async_text_button.dart';
import 'package:dart_utils/src/shared/widgets/spaces.dart';

final class ConfirmationDialog extends StatefulWidget {
  const ConfirmationDialog({
    super.key,
    required this.icon,
    this.message,
    this.child,
    this.onPressed,
    this.confirmTitle = 'OK',
    this.canPop = true,
    this.dismissible = true,
  }) : assert(
          (message == null && child is Widget) ||
              (message is String && child == null),
          'You can only use the message or child parameter, not both.',
        );

  final Widget icon;
  final String? message;
  final Widget? child;
  final Future<bool> Function()? onPressed;
  final String confirmTitle;
  final bool canPop;
  final bool dismissible;

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();

  Future<bool?> show(BuildContext context) => showDialog(
        context: context,
        barrierDismissible: dismissible,
        builder: (_) => this,
      );
}

class _ConfirmationDialogState<T extends Object>
    extends State<ConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.canPop,
      child: Dialog(
        backgroundColor: Colors.white,
        shape: kDialogBorder,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox.square(
                dimension: 64,
                child: FittedBox(
                  child: IconTheme(
                    data: const IconThemeData(color: AppColors.primary),
                    child: widget.icon,
                  ),
                ),
              ),
              Spaces.height8,
              widget.message is String
                  ? Text(
                      widget.message!,
                      textAlign: TextAlign.center,
                      style: kBiggestStyle,
                    )
                  : widget.child!,
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
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(
                        'Cancel',
                        style: kBigStyle,
                      ),
                    ),
                  ),
                  Spaces.width16,
                  // continuar
                  Expanded(
                    child: AsyncTextButton(
                      indicatorColor: AppColors.primary,
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: _onPressed,
                      child: Text(
                        widget.confirmTitle,
                        style: kBigStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onPressed() async {
    if (widget.onPressed == null) {
      Navigator.of(context).pop(true);
      return;
    }

    final successful = await widget.onPressed!();
    if (!context.mounted || !mounted) return;

    if (successful) Navigator.of(context).pop(true);
  }
}

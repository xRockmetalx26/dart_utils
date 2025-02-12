//import 'package:doc_widget/doc_widget.dart';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:dart_utils/src/shared/app_colors.dart';
import 'package:dart_utils/src/shared/constant.dart';

final class PanelModalBottomSheet extends StatelessWidget {
  const PanelModalBottomSheet({
    super.key,
    required this.title,
    required this.onPressed,
    required this.child,
    this.titleButton = 'Continuar',
    this.backgroundColor = Colors.white,
    this.primaryColor = AppColors.primary,
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
  });

  final String title;
  final Function() onPressed;
  final Widget child;
  final String titleButton;
  final Color backgroundColor;
  final Color primaryColor;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: kDialogBorder,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: kBigStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                // cerrar
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      MdiIcons.closeCircleOutline,
                      color: primaryColor,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // body
          Flexible(child: child),
          // acción
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                fixedSize: const Size(kInfinityDimension, kNormalButtonHeight),
                shape: const StadiumBorder(),
              ),
              onPressed: onPressed,
              child: Text(
                titleButton,
                style: kBiggestStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

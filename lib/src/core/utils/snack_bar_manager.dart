// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:dart_utils/src/shared/app_colors.dart';

final class SnackBarManager {
  const SnackBarManager._();

  /// Muestra un `SnackBar` con el [child], si ya hay un `SnackBar`,
  /// este sera reemplazado por este.
  static void show({
    required BuildContext context,
    required Widget child,
    Color backgroundColor = AppColors.primary,
    Duration duration = const Duration(seconds: 2),
  }) {
    final width = MediaQuery.of(context).size.width * .75;
    final snackBar = SnackBar(
      width: width,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      shape: const StadiumBorder(),
      backgroundColor: backgroundColor,
      content: Center(child: child),
    );

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(snackBar);
  }
}

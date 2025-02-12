// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fluttertoast/fluttertoast.dart';

// Project imports:
import 'package:dart_utils/src/shared/app_colors.dart';

final class AppToast {
  const AppToast._();

  static void show(
    String text, {
    ToastGravity gravity = ToastGravity.BOTTOM,
    Color foregroundColor = Colors.white,
    Color backgroundColor = AppColors.primary,
    Toast? length,
  }) =>
      Fluttertoast.showToast(
        msg: text,
        textColor: foregroundColor,
        backgroundColor: backgroundColor,
        gravity: gravity,
        toastLength: length,
      );

  static void showBlack(
    String text, {
    ToastGravity gravity = ToastGravity.BOTTOM,
    Toast? length,
  }) =>
      Fluttertoast.showToast(
        msg: text,
        backgroundColor: Colors.black.withOpacity(.90),
        textColor: Colors.white,
        gravity: gravity,
        toastLength: length,
      );
}

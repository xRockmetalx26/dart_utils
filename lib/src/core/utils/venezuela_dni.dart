// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';

// Project imports:
import 'package:dart_utils/src/core/utils/strings.dart';

final class VenezuelaDni {
  const VenezuelaDni._();

  static const defaultPrefix = 'V';
  static const prefixes = ['V', 'E'];

  /// Para formato [dni] = `V12345678`.
  static bool fullDniIsValid(String? dni) {
    final prefix = getPrefix(dni);
    final suffix = getSuffix(dni);
    final isValid = dniIsValid(
      prefix: prefix,
      suffix: suffix,
    );

    return isValid;
  }

  /// Para formato  [prefix] = `V`, [suffix] = `12345678`.
  static bool dniIsValid({
    required String? prefix,
    required String? suffix,
  }) {
    final isValid = prefixIsValid(prefix) && suffixIsValid(suffix);
    return isValid;
  }

  /// Para formato [prefix] = `V`.
  static bool prefixIsValid(String? prefix) {
    if (prefix.isBlank) return false;

    final isValid = VenezuelaDni.prefixes.contains(prefix);

    return isValid;
  }

  /// Para formato [suffix] = `12345678`.
  static bool suffixIsValid(String? suffix) {
    if (suffix.isBlank) return false;

    return RegExp(r'^\d{6,8}$').hasMatch(suffix!);
  }

  /// Obtiene el prefijo `V` de `V12345678` de [dni],
  /// `null` si es inválido.
  static String? getPrefix(String? dni) {
    final first = dni?.characters.first;
    return prefixes.firstWhereOrNull((prefix) => prefix == first);
  }

  /// Obtiene el sufijo `12345678` de `V12345678` de [dni],
  /// `null` si es inválido.
  static String? getSuffix(String? dni) {
    final length = dni?.length ?? 0;
    if (length < 2) return null;

    return dni?.substring(1);
  }
}

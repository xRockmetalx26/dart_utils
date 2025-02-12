// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

extension Strings on String? {
  /// Retorna `true` si el `String` no contiene caracteres o es `null`.
  /// los espacios no cuentan como caracteres.
  bool get isBlank => this?.trim().isEmpty ?? true;

  /// Retorna `true` si el `String` no es `null` y contiene caracteres.
  /// los espacios no cuentan como caracteres.
  bool get isNotBlank => this?.trim().isNotEmpty ?? false;

  /// Retorna un `String` con la primera sílaba capitalizada.
  /// `null` si no es posible.
  String? capitalizeFirst() {
    if (isBlank) return this;

    return this![0] + this!.substring(1);
  }

  /// Intenta convertir el `String` en `int`,
  /// `null` si no es posible.
  int? toInt() {
    if (isBlank) return null;

    return int.tryParse(this!);
  }

  /// Retorna el primer `int` en el `String`.
  String? firstInt() {
    if (isBlank) return null;

    final match = RegExp(r'\d+').firstMatch(this!);

    return match?.group(0);
  }

  /// Retorna el formato `10/11/2024` dado el `String` de `DateTime`.
  String? toDMYDate() {
    if (isBlank) return null;

    final date = DateTime.parse(this!);

    return DateFormat('dd/MM/yyyy').format(date);
  }

  /// Retorna el SHA256 del `String` en notación hexadecimal.
  /// `null` si el `String` es inválido.
  String? getSha256() {
    if (isBlank) return null;

    final bytes = utf8.encode(this!);
    final digest = sha256.convert(bytes);

    return digest.toString();
  }

  /// Retorna una copia de `this` sin el ultimo caracter
  String? get removeLast {
    if (this?.isEmpty ?? true) return this;

    return this!.substring(0, this!.length - 1);
  }

  /// Retorna una copia de `this` sin el primer caracter
  String? get removeFirst {
    if (this?.isEmpty ?? true) return this;

    return this?.substring(1);
  }
}

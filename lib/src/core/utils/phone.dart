// Project imports:
import 'package:dart_utils/src/core/utils/strings.dart';

final class PhoneUtils {
  const PhoneUtils._();

  static const defaultPrefix = '+58';

  /// Para formato [phone] = `+58-123-123-123456` sin incluir guiones.
  static bool fullPhoneIsValid(String? phone) {
    if (phone.isBlank) return false;

    final regex = RegExp(r'^(\+)?[0-9]{11,14}$');

    return regex.hasMatch(phone!);
  }

  /// Para formato  [prefix] = `+58`, [suffix] = `123-123-123456` sin incluir guiones.
  static bool phoneIsValid({
    required String? prefix,
    required String? suffix,
  }) {
    if (prefix.isBlank || suffix.isBlank) return false;

    final regex = RegExp(r'^(\+)?[0-9]{11,14}$');

    return regex.hasMatch('$prefix$suffix');
  }

  /// Para formato  [prefix] = `+58`, [suffix] = `123123123456`.
  // static bool phoneIsValid({
  //   required String? prefix,
  //   required String? suffix,
  // }) {
  //   final isValid = prefixIsValid(prefix) && suffixIsValid(suffix);
  //   return isValid;
  // }

  /// Para formato [prefix] = `V`.
  // static bool prefixIsValid(String? prefix) {
  //   if (prefix.isBlank) return false;

  //   final isValid = PhoneUtils.prefixes.contains(prefix);

  //   return isValid;
  // }

  /// Para formato [suffix] = `1234-1234-1234`.
  static bool suffixIsValid(String? suffix) {
    if (suffix.isBlank) return false;

    return RegExp(r'^[0-9]{10,12}$').hasMatch(suffix!);
  }

  /// Obtiene el prefijo `V` de `V12345678` de [dni],
  /// `null` si es inválido.
  // static String? getPrefix(String? phone) {
  //   final first = phone?.characters.first;
  //   return prefixes.firstWhereOrNull((prefix) => prefix == first);
  // }

  /// Obtiene el sufijo `12345678` de `V12345678` de [dni],
  /// `null` si es inválido.
  // static String? getSuffix(String? dni) {
  //   final length = dni?.length ?? 0;
  //   if (length < 2) return null;

  //   return dni?.substring(1);
  // }
}

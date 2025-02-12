// Project imports:
import 'package:dart_utils/src/core/app/flutter_cout.dart';

/// Contiene información sobre el resultado dado por un método `Try.result`.
///
/// [value] es el valor retornado por el método `Try.result` si finalizó correctamente,
/// [exception] es la `Exception` que retorno el método `Try.result`,
/// [hasError] si ocurrió una `Exception`.
final class TryResult<T> {
  const TryResult({
    this.value,
    this.exception,
    this.hasError = false,
  });

  final T? value;
  final dynamic exception;
  final bool hasError;
}

final class Try {
  const Try._();

  /// Maneja la posible `Exception` ocurrida en el método [call].
  ///
  /// Retorna `T` en caso de finalizar correctamente,
  /// `null` en caso de ocurrir una `Exception`,
  /// se puede mostrar la `Exception` con [showExceptions] = `true`.
  static T? syncCall<T>({
    required T? Function() call,
    bool showExceptions = true,
  }) {
    try {
      return call();
    } catch (exception, trace) {
      if (showExceptions) Cout.error('$exception\n$trace');

      return null;
    }
  }

  /// Maneja la posible `Exception` ocurrida en el método [call].
  ///
  /// Retorna `Future<T>` en caso de finalizar correctamente,
  /// `null` en el `Future` en caso de ocurrir una `Exception`,
  /// se puede mostrar la `Exception` con [showExceptions] = `true`.
  static Future<T?> asyncCall<T>({
    required Future<T?> Function() call,
    bool showExceptions = true,
  }) async {
    try {
      return await call();
    } catch (exception, trace) {
      if (showExceptions) Cout.error('$exception\n$trace');

      return null;
    }
  }

  /// Maneja la posible `Exception` ocurrida en el método [call].
  ///
  /// Retorna `TryResult<T>.value` como `T` en el `Future` en caso de finalizar correctamente,
  /// `TryResult<T>.value` como `null` en caso de ocurrir una `Exception`,
  /// se puede mostrar la `Exception` con [showExceptions] = `true`.
  static TryResult<T?> syncResultCall<T>({
    required T? Function() call,
    bool showExceptions = true,
  }) {
    try {
      return TryResult(value: call());
    } catch (exception, trace) {
      if (showExceptions) Cout.error('$exception\n$trace');

      return TryResult(
        exception: exception,
        hasError: true,
      );
    }
  }

  /// Maneja la posible `Exception` ocurrida en el método [call].
  ///
  /// Retorna `TryResult<T>.value` como `T` en el `Future` en caso de finalizar correctamente,
  /// `TryResult<T>.value` como `null` en el `Future` si ocurre una `Exception`,
  /// se puede mostrar la `Exception` con [showExceptions] = `true`.
  static Future<TryResult<T?>> asyncResultCall<T>({
    required Future<T?> Function() call,
    bool showExceptions = true,
  }) async {
    try {
      return TryResult(value: await call());
    } catch (exception, trace) {
      if (showExceptions) Cout.error('$exception\n$trace');

      return TryResult(
        exception: exception,
        hasError: true,
      );
    }
  }
}

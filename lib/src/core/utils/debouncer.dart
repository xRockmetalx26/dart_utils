// Dart imports:
import 'dart:async';

final class Debouncer {
  Debouncer({this.milliseconds = 500});

  final int milliseconds;
  Timer? _timer;

  /// Realiza un [call] después de pasados los [milliseconds].
  void call(void Function() call) => run(call);

  /// Realiza un [call] después de pasados los [milliseconds].
  void run(void Function() call) {
    _timer?.cancel();

    _timer = Timer(Duration(milliseconds: milliseconds), call);
  }

  /// Cancela realizar el `call` enviado en [call] o [run].
  void cancel() => _timer?.cancel();
}

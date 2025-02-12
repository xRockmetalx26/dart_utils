// ignore_for_file: library_private_types_in_public_api

// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

/// Esta clase toma un `ChangeNotifier` de `GetIt`
/// para montarlo en el contexto usando `ChangeNotifier.value`
final class ChangeNotifierBuilder<T extends ChangeNotifier>
    extends StatefulWidget {
  const ChangeNotifierBuilder({
    super.key,
    required this.builder,
    this.postFrameCallback,
    this.listen = false,
  });

  /// [builder] Método al que se llamara para construir el widget.
  final Widget Function(BuildContext context, T provider) builder;

  /// [postFrameCallback] Método al que se llamara después de finalizar el método `build`.
  final void Function(T provider)? postFrameCallback;

  /// [listen] Para escuchar los cambios de estado.
  final bool listen;

  /// Igual que `ChangeNotifierBuilder` pero con [listen] = `true`.
  const ChangeNotifierBuilder.listen({
    super.key,
    required this.builder,
    this.postFrameCallback,
    this.listen = true,
  });

  @override
  _StatefulProviderState<T> createState() => _StatefulProviderState<T>();
}

final class _StatefulProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierBuilder<T>> {
  final T _provider = GetIt.instance<T>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.postFrameCallback?.call(_provider));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: _provider,
      child: widget.listen
          ? Consumer<T>(
              builder: (context, provider, _) {
                return widget.builder(context, provider);
              },
            )
          : widget.builder(context, _provider),
    );
  }
}

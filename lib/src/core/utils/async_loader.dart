// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Project imports:
import 'package:dart_utils/src/core/app/app_toast.dart';

/// Clase que permite visualizar un diálogo de espera,
/// mientras se ejecuta un método [call] asyncrono que retorna
/// un tipo [T].
///
/// [autoPop] Permite decidir si el loader se debe cerrar solo después de finalizar
/// el método show.
/// [canPop] Permite decidir si el loader se debe cerrar al pulsar el pop.
/// [dissmisible] Permite decidir si el loader sera dissmisible.
final class AsyncLoader<T> extends StatefulWidget {
  const AsyncLoader({
    super.key,
    required this.call,
    this.autoPop = false,
    this.canPop = false,
    this.dissmisible = false,
  });

  final Future<T> Function() call;
  final bool autoPop;
  final bool canPop;
  final bool dissmisible;

  /// Lo mismo que el constructor por defecto, pero usando [autoPop] = `true`.
  const AsyncLoader.autoPop({
    super.key,
    required this.call,
    this.canPop = false,
    this.dissmisible = false,
  }) : autoPop = true;

  @override
  State<AsyncLoader<T>> createState() => _AsyncLoaderState<T>();

  Future<T?> show(BuildContext context) {
    return showDialog<T>(
      context: context,
      barrierDismissible: dissmisible,
      builder: (context) => this,
    );
  }
}

final class _AsyncLoaderState<T> extends State<AsyncLoader<T>> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PopScope(
        canPop: widget.canPop,
        child: FutureBuilder(
          future: widget.call(),
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              AppToast.show('Error en operación asíncrona.');

              if (mounted) Navigator.of(context).pop();
            } else {
              final callCompleted =
                  snapshot.connectionState == ConnectionState.done;
              if (callCompleted && mounted && widget.autoPop) {
                Navigator.of(context).pop(snapshot.data);
              }
            }

            return SpinKitPumpingHeart(
              duration: const Duration(seconds: 1),
              itemBuilder: (context, index) => SizedBox.square(
                dimension: 64,
                child: Icon(Icons.flutter_dash),
              ),
            );
          },
        ),
      ),
    );
  }
}

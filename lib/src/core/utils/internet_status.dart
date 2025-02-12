// Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';

// Project imports:
import 'package:dart_utils/src/core/app/app_toast.dart';

final class InternetStatus {
  const InternetStatus._();

  /// Revisa si hay conexión de internet.
  ///
  /// [showToast] = `true` notificara si no hay conexión,
  /// [includeEthernet] = `true` si debe incluir la red ethernet.
  static Future<bool> hasInternet({
    bool showToast = false,
    bool includeEthernet = true,
  }) async {
    final availableConnections = await Connectivity().checkConnectivity();
    final connections = [
      ConnectivityResult.wifi,
      ConnectivityResult.mobile,
      if (includeEthernet) ConnectivityResult.ethernet,
    ];

    final hasInternet = availableConnections
        .any((connection) => connections.contains(connection));
    if (!hasInternet && showToast) {
      AppToast.show('No se ha detectado una conexión de internet.');
    }

    return hasInternet;
  }
}

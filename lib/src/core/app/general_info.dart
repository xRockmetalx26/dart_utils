// Dart imports:
import 'dart:io';

// Package imports:
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:package_info_plus/package_info_plus.dart';

final class GeneralInfo extends Equatable {
  const GeneralInfo._({
    required this.appName,
    required this.appPackage,
    required this.appVersion,
    required this.appBuild,
    required this.osName,
    required this.osVersion,
    required this.osSdkVersion,
  });

  final String appName;
  final String appPackage;
  final String appVersion;
  final String appBuild;
  final String osName;
  final String osVersion;
  final String osSdkVersion;

  static GeneralInfo? _instance;
  static GeneralInfo get instance {
    if (_instance == null) {
      throw Exception(
        'GeneralInfo instance is null, First call GeneralInfo.initialize()',
      );
    }

    return _instance!;
  }

  /// Retorna información resumida de del app.
  String get shortInfo => '$appName $appVersion ($appBuild).';

  /// Inicializa `GeneralInfo` con la configuración del dispositivo/app.
  static Future<GeneralInfo> initialize() async {
    if (_instance == null) {
      final packageInfo = await PackageInfo.fromPlatform();
      final deviceInfo = DeviceInfoPlugin();
      final osVersion = Platform.isAndroid
          ? (await deviceInfo.androidInfo).version.release
          : (await deviceInfo.iosInfo).systemVersion;

      final osSdkVersion = Platform.isAndroid
          ? (await deviceInfo.androidInfo).version.sdkInt.toString()
          : (await deviceInfo.iosInfo).systemVersion;

      _instance = GeneralInfo._(
        appName: packageInfo.appName,
        appPackage: packageInfo.packageName,
        appVersion: packageInfo.version,
        appBuild: packageInfo.buildNumber,
        osName: Platform.operatingSystem,
        osVersion: osVersion,
        osSdkVersion: osSdkVersion,
      );
    }

    return _instance!;
  }

  @override
  List<Object?> get props => [
        appName,
        appPackage,
        appVersion,
        appBuild,
        osName,
        osVersion,
        osSdkVersion,
      ];
}

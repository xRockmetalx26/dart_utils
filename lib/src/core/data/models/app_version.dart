// Package imports:
import 'package:equatable/equatable.dart';

final class AppVersion extends Equatable {
  const AppVersion({
    required this.appVersion,
    required this.osVersion,
    required this.mandatory,
  });

  final String appVersion;
  final String osVersion;
  final bool mandatory;

  int get buildNumber {
    if (appVersion.isEmpty || !appVersion.contains(RegExp(r'(|)'))) {
      return 0;
    }

    final start = appVersion.indexOf('(') + 1;
    final end = appVersion.indexOf(')');

    return int.parse(appVersion.substring(start, end));
  }

  @override
  List<Object?> get props => [
        appVersion,
        osVersion,
        mandatory,
      ];
}

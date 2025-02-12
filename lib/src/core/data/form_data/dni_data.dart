// Project imports:
import 'package:dart_utils/src/core/utils/typedef.dart';
import 'package:dart_utils/src/core/utils/venezuela_dni.dart';

final class DniData {
  String get dni => '${prefixDni ?? ''}${suffixDni ?? ''}';
  bool get isValid => VenezuelaDni.fullDniIsValid(dni);

  Json toJson() => {'dni': dni};

  String? prefixDni;
  String? suffixDni;
}

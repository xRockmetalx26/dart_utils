// Package imports:
import 'package:either_dart/either.dart';
import 'package:geolocator/geolocator.dart';

// Project imports:
import 'package:dart_utils/src/core/error/errors.dart';
import 'package:dart_utils/src/core/utils/typedef.dart';

final class GeolocatorUtils {
  const GeolocatorUtils._();

  static FEValue<Position> getCurrentPosition() async {
    final errorOrPermission = await _getGeolocatorPermission();
    if (errorOrPermission.hasError) return Left(errorOrPermission.error);

    final position = await Geolocator.getCurrentPosition();
    return Right(position);
  }

  static FEValue<void> _getGeolocatorPermission() async {
    final locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationServiceEnabled) {
      return const Left(
        PermissionError('Active el servicio de ubicación para continuar.'),
      );
    }

    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return const Left(
        PermissionError('Permiso de ubicación requerido para continuar.'),
      );
    }

    if (permission == LocationPermission.deniedForever) {
      return const Left(
        PermissionError(
          'Active el permiso de ubicación manualmente para continuar.',
          AppError.defaultCode,
          true,
        ),
      );
    }

    return const Right(null);
  }
}

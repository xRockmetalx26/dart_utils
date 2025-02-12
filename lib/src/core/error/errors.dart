// Package imports:
import 'package:equatable/equatable.dart';

abstract final class AppError extends Equatable {
  const AppError(
    this.message, [
    this.code,
  ]);

  static const defaultCode = null;

  final String message;
  final int? code;

  String get description =>
      '$message${code is int ? ' (${code! + 1000})' : ''}';

  @override
  List<Object?> get props => [
        message,
        code,
      ];
}

final class UnexpectedError extends AppError {
  const UnexpectedError([
    super.message = 'Error inesperado.',
    super.code,
  ]);
}

final class ConnectionError extends AppError {
  const ConnectionError([
    super.message = 'No se ha detectado una conexión de internet.',
    super.code,
  ]);
}

final class ParamsFailure extends AppError {
  const ParamsFailure([
    super.message = 'Error al obtener los parámetros remotos.',
    super.code,
  ]);
}

final class AddError extends AppError {
  const AddError([
    super.message = 'Error al agregar los datos.',
    super.code,
  ]);
}

final class GetError extends AppError {
  const GetError([
    super.message = 'Error al obtener los datos del servidor.',
    super.code,
  ]);
}

final class EditError extends AppError {
  const EditError([
    super.message = 'Error al editar los datos.',
    super.code,
  ]);
}

final class DeleteError extends AppError {
  const DeleteError([
    super.message = 'Error al eliminar los datos.',
  ]);
}

final class UploadError extends AppError {
  const UploadError([
    super.message = 'Error al subir los datos.',
    super.code,
  ]);
}

final class DownloadError extends AppError {
  const DownloadError([
    super.message = 'Error al descargar los datos.',
    super.code,
  ]);
}

final class IgnorableError extends AppError {
  const IgnorableError([
    super.message = 'Error ignorable.',
    super.code,
  ]);
}

final class AuthError extends AppError {
  const AuthError([
    super.message = 'Error de autenticación.',
    super.code,
  ]);
}

final class SignInError extends AppError {
  const SignInError([
    super.message = 'Error al iniciar sesión (BE).',
    super.code,
  ]);
}

final class SignUpError extends AppError {
  const SignUpError([
    super.message = 'Error al registrarse (BE).',
    super.code,
  ]);
}

final class SignOutError extends AppError {
  const SignOutError([
    super.message = 'Error al cerrar sesión (BE).',
    super.code,
  ]);
}

final class FileError extends AppError {
  const FileError([
    super.message = 'Error al procesar archivo.',
    super.code,
  ]);
}

final class ExistsError extends AppError {
  const ExistsError([
    super.message = 'Error de registro ya existente.',
    super.code,
  ]);
}

final class NotFoundError extends AppError {
  const NotFoundError([
    super.message = 'Error al encontrar los datos.',
    super.code,
  ]);
}

final class PermissionError extends AppError {
  const PermissionError([
    super.message = 'Error de permiso.',
    super.code,
    this.permanentlyDenied,
  ]);

  final bool? permanentlyDenied;
}

final class LocationError extends AppError {
  const LocationError([
    super.message = 'Error de localización.',
    super.code,
  ]);
}

final class TermsError extends AppError {
  const TermsError(
    this.version, [
    super.message =
        'Hemos actualizado nuestras políticas de privacidad, términos y condiciones de uso.',
    super.code,
  ]);

  final int version;
}

final class DeviceError extends AppError {
  const DeviceError([
    super.message = 'Todos los permisos del app son requeridos para continuar.',
    super.code,
  ]);
}

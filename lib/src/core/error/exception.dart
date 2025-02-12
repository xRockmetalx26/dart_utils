abstract final class AppException implements Exception {
  final String? error;
  final String? prefix;
  final String? message;

  AppException([this.error, this.prefix, this.message]);

  @override
  String toString() => '$prefix$error';
}

final class AuthUserException extends AppException {
  AuthUserException([
    String? error,
    String? message,
  ]) : super(
          error,
          'Auth User Error: ',
          message,
        );
}

final class UserNotFoundException extends AppException {
  UserNotFoundException([
    String? error,
    String? message,
  ]) : super(
          error,
          'User Not Found: ',
          message,
        );
}

final class NotConnectionException extends AppException {
  NotConnectionException([
    String? error,
    String? message,
  ]) : super(error, "Device isn't conntected: ");
}

final class ServerException extends AppException {
  ServerException([
    String? error,
    String? message,
  ]) : super(
          error,
          'Error During Communication: ',
          message,
        );
}

final class BadRequestException extends AppException {
  BadRequestException([
    String? error,
    String? message,
  ]) : super(
          error,
          'Invalid Request: ',
          message,
        );
}

final class UnauthorisedException extends AppException {
  UnauthorisedException([
    String? error,
    String? message,
  ]) : super(
          error,
          'Unauthorised: ',
          message,
        );
}

final class NotTokenException extends AppException {
  NotTokenException([
    String? error,
    String? message,
  ]) : super(
          error,
          'Error No token: ',
          message,
        );
}

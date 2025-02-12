// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:dart_utils/src/core/utils/typedef.dart';

final class ResponseModel<T> extends Equatable {
  const ResponseModel({
    required this.success,
    required this.message,
    required this.code,
    required this.data,
  });

  final bool success;
  final String message;
  final int code;
  final T data;

  /// Construye una instancia de `AppResponse` dado un `Json`.
  factory ResponseModel.fromJson(Json json) => ResponseModel(
        success: json['success'] ?? false,
        message: json['message'],
        code: json['status_code'],
        data: json['data'],
      );

  @override
  List<Object?> get props => [
        success,
        message,
        code,
        data,
      ];
}

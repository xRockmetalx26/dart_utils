// Project imports:
import 'package:dart_utils/src/core/utils/typedef.dart';

/// Método que convierte una instancia de `T` a `Json`.
typedef ToJsonCall<T> = Json Function(T);

/// Método que construye una instancia de `T` dado un `Json`.
typedef FromJsonCall<T> = T Function(Json);

final class Listing<T> extends Iterable<T> {
  const Listing({
    required this.totalCount,
    required this.values,
    this.link,
  });

  final int totalCount;
  final List<T> values;
  final String? link;

  @override
  Iterator<T> get iterator => values.iterator;

  /// Crea una instancia de `Listing<T>` con valores por defecto.
  factory Listing.empty() => const Listing(totalCount: 0, values: []);

  /// Crea una instancia de `Listing<T>` con los valores del [json].
  ///
  /// [fromJson] es el método contructor de `T` dado un `Json`,
  /// [linkKey] es el nombre del campo del link del listado.
  factory Listing.fromJson({
    required Json json,
    required FromJsonCall<T> fromJson,
    String? linkKey,
  }) =>
      Listing(
        totalCount: json['totalCount'],
        values: (json['data'] as List).map((value) => fromJson(value)).toList(),
        link: json[linkKey],
      );

  /// Crea una instancia de `Json` con los valores del `Listing<T>`.
  ///
  /// [toJson] es el método con convierte `T` a `Json`.
  Json toJson({required ToJsonCall<T> toJson}) => {
        'totalCount': totalCount,
        'data': values.map((value) => toJson(value)).toList(),
        'link': link,
      };
}

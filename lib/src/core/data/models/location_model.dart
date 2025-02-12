// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:dart_utils/src/core/utils/typedef.dart';

final class LocationModel extends Equatable {
  LocationModel.fromJson(Json json)
      : id = json['location']?['_id'] ?? json['_id'],
        name = json['location']?['name'] ?? json['name'],
        keyInt = json['keyInt'];

  final String id;
  final String name;
  final String? keyInt;

  Json toJson() => {
        '_id': id,
        'name': name,
        'keyInt': keyInt,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        keyInt,
      ];
}

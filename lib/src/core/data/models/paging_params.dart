// Package imports:
import 'package:equatable/equatable.dart';

class PagingParams extends Equatable {
  const PagingParams({
    this.page,
    this.count,
    this.criteria,
    this.filter,
    this.sort,
  });

  final int? page;
  final int? count;
  final String? criteria;
  final String? filter;
  final String? sort;

  @override
  List<Object?> get props => [
        page,
        count,
        criteria,
        filter,
        sort,
      ];
}

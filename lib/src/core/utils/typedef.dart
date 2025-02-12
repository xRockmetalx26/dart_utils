// Package imports:
import 'package:either_dart/either.dart';

// Project imports:
import 'package:dart_utils/src/core/data/models/listing.dart';
import 'package:dart_utils/src/core/error/errors.dart';

/// Json format
typedef Json = Map<String, dynamic>;

/// Future void Function
typedef FVCallback = Future<void> Function();

/// Either of Failure or T
typedef EValue<T> = Either<AppError, T>;

/// Future of Either of Failure or T
typedef FEValue<T> = Future<EValue<T>>;

/// Either of Failure or List of T
typedef EList<T> = Either<AppError, List<T>>;

/// Future of Either of Failure or List of T
typedef FEList<T> = Future<EList<T>>;

/// Either of Failure or Listing of T
typedef EListing<T> = Either<AppError, Listing<T>>;

/// Future of Either of Failure or Listing of T
typedef FEListing<T> = Future<EListing<T>>;

/// List of Either of Failure or T
typedef ListEValue<T> = List<EValue<T>>;

/// Future of List of Either of Failure or T
typedef FListEValue<T> = Future<ListEValue<T>>;

/// Either of Failure or List of Either of Failure or T
typedef EListEValue<T> = Either<AppError, List<EValue<T>>>;

/// Future of Either of Failure or List of Either of Failure or T
typedef FEListEValue<T> = Future<EListEValue<T>>;

extension EValueExt<T> on EValue<T> {
  bool get hasError => isLeft;
  bool get hasValue => isRight;

  AppError get error => left;
  T get value => right;

  String get string => (hasError ? error : value).toString();
}

extension EListExt<T> on EList<T> {
  bool get hasError => isLeft;
  bool get hasValue => isRight;

  AppError get error => left;
  List<T> get value => right;

  String get string => (hasError ? error : value).toString();
}

extension EListingExt<T> on EListing<T> {
  bool get hasError => isLeft;
  bool get hasValue => isRight;

  AppError get error => left;
  Listing<T> get value => right;

  String get string => (hasError ? error : value).toString();
}

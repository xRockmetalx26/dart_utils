extension Lists on List? {
  bool get isBlank => this?.isEmpty ?? true;

  bool get isNotEmptyAndNotNull => this?.isNotEmpty ?? false;
}

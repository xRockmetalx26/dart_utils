enum Hashtag {
  numbers,
  letters,
  numbersAndLetters,
  allCharacters;

  RegExp get reg => switch (this) {
        Hashtag.numbers => RegExp(r'[^0-9]'),
        Hashtag.letters => RegExp(r'[^a-zA-Z]'),
        Hashtag.numbersAndLetters => RegExp(r'[^0-9a-zA-Z]'),
        Hashtag.allCharacters => RegExp(r''),
      };
}

final class Masked {
  const Masked({
    required this.masks,
    this.hashtag = Hashtag.numbers,
  });

  final List<String> masks;
  final Hashtag hashtag;

  String getMasked(String value) {
    final hashString = value.replaceAll(hashtag.reg, '');
    var maskToUse = masks.first;

    for (final mask in masks) {
      final count = mask.split('').where((element) => element == '#').length;
      if (count >= hashString.length) {
        maskToUse = mask;
        break;
      }
    }

    var formatted = maskToUse;
    final characters = hashString.split('');

    for (final character in characters) {
      formatted = formatted.replaceFirst('#', character);
    }

    final lastHash = formatted.indexOf('#');
    if (lastHash != -1) {
      formatted = formatted.split('').getRange(0, lastHash).join();
      if (RegExp(r'\W$').hasMatch(formatted)) {
        formatted = formatted.substring(0, formatted.length - 1);
      }
    }

    return formatted;
  }
}

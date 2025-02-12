// Project imports:
import 'package:dart_utils/src/core/utils/phone.dart';
import 'package:dart_utils/src/core/utils/typedef.dart';

final class PhoneData {
  String get phone => '${prefixPhone ?? ''}${_suffixPhone ?? ''}';
  bool get isValid => PhoneUtils.fullPhoneIsValid(phone);
  String? get suffixPhone => _suffixPhone;
  set suffixPhone(String? suffixPhone) {
    _suffixPhone = suffixPhone?.replaceAll('-', '');
  }

  Json toJson() => {'phone': phone};

  String? prefixPhone;
  String? _suffixPhone;
}

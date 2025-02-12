// // Package imports:
// import 'package:equatable/equatable.dart';

// // Project imports:
// import 'package:dart_utils/src/core/env/env.dart';
// import 'package:dart_utils/src/core/utils/typedef.dart';

// enum Flavor { dev, prod }

// final class FlavorConfig {
//   const FlavorConfig._(this.flavor, this.values);

//   final Flavor flavor;
//   final FlavorValues values;

//   static FlavorConfig? _instance;
//   static FlavorConfig get instance {
//     if (_instance == null) {
//       throw Exception(
//         'FlavorConfig instance is null, First call FlavorConfig.initialize()',
//       );
//     }

//     return _instance!;
//   }

//   /// Inicializa con el [flavor] la configuración del `FlavorConfig` del app.
//   static Future<void> init(Flavor flavor) async {
//     final Json envJson = switch (flavor) {
//       Flavor.dev => {
//           'BASE_API_URL': DevEnv.baseApiUrl,
//           'PUBLIC_API_TOKEN': DevEnv.publicApiToken,
//           'GOOGLE_PLACES_API_KEY': DevEnv.googlePlacesApiKey,
//           'ENCRYPT_KEY': DevEnv.encryptKey,
//           'ENCRYPT_IV': DevEnv.encryptIv,
//         },
//       Flavor.prod => {
//           'BASE_API_URL': ProdEnv.baseApiUrl,
//           'PUBLIC_API_TOKEN': ProdEnv.publicApiToken,
//           'GOOGLE_PLACES_API_KEY': ProdEnv.googlePlacesApiKey,
//           'ENCRYPT_KEY': ProdEnv.encryptKey,
//           'ENCRYPT_IV': ProdEnv.encryptIv,
//         },
//     };

//     _instance = FlavorConfig._(
//       flavor,
//       FlavorValues(
//         baseApiUrl: envJson['BASE_API_URL'],
//         publicApiToken: envJson['PUBLIC_API_TOKEN'],
//         googlePlacesApiKey: envJson['GOOGLE_PLACES_API_KEY'],
//         key: envJson['ENCRYPT_KEY'],
//         iv: envJson['ENCRYPT_IV'],
//       ),
//     );
//   }

//   /// Retorna `true` si es desarrollo.
//   static bool get isDev => instance.flavor == Flavor.dev;

//   /// Retorna `true` si es producción.
//   static bool get isProd => instance.flavor == Flavor.prod;
// }

// final class FlavorValues extends Equatable {
//   const FlavorValues({
//     required this.baseApiUrl,
//     required this.publicApiToken,
//     required this.googlePlacesApiKey,
//     required this.key,
//     required this.iv,
//   });

//   final String baseApiUrl;
//   final String publicApiToken;
//   final String googlePlacesApiKey;
//   final String key;
//   final String iv;

//   @override
//   List<Object?> get props => [
//         baseApiUrl,
//         publicApiToken,
//         googlePlacesApiKey,
//         key,
//         iv,
//       ];
// }

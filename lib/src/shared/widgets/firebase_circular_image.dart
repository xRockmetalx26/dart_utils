// // Flutter imports:
// import 'package:flutter/material.dart';

// // Package imports:
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:hive/hive.dart';

// // Project imports:
// import 'package:dart_utils/src/core/utils/strings.dart';

// final class FirebaseCircularImage extends StatefulWidget {
//   const FirebaseCircularImage({
//     super.key,
//     required this.referenceUrl,
//     this.fromHive = false,
//     this.size = 64,
//     this.padding = 0,
//     this.backgroundColor = Colors.white,
//   });

//   final String? referenceUrl;
//   final bool fromHive;
//   final double size;
//   final double padding;
//   final Color backgroundColor;

//   @override
//   State<FirebaseCircularImage> createState() => _FirebaseCircularImageState();
// }

// final class _FirebaseCircularImageState extends State<FirebaseCircularImage> {
//   // core
//   late final _futurePublicUrl = _fectPublicUrl();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _futurePublicUrl,
//       builder: (_, snapshot) {
//         return SizedBox(
//           width: widget.size,
//           height: widget.size,
//           child: Builder(
//             builder: (_) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 final publicUrl = snapshot.data;
//                 final imageSize = widget.size - widget.padding;
//                 const placeholder = Image(
//                   image: AssetImage(AppImagePaths.placeholder),
//                   fit: BoxFit.cover,
//                 );

//                 return Container(
//                   width: widget.size,
//                   height: widget.size,
//                   decoration: ShapeDecoration(
//                     shape: CircleBorder(
//                       side: BorderSide(
//                         width: widget.padding,
//                         color: widget.backgroundColor,
//                       ),
//                     ),
//                   ),
//                   child: FittedBox(
//                     child: ClipOval(
//                       child: FadeInImage(
//                         width: imageSize,
//                         height: imageSize,
//                         fit: BoxFit.cover,
//                         placeholderFit: BoxFit.cover,
//                         placeholder: placeholder.image,
//                         image: (publicUrl.isNotBlank)
//                             ? CachedNetworkImageProvider(publicUrl!)
//                             : placeholder.image,
//                       ),
//                     ),
//                   ),
//                 );
//               }

//               return const SizedBox.shrink();
//             },
//           ),
//         );
//       },
//     );
//   }

//   Future<String?> _fectPublicUrl() async {
//     final refUrl = widget.referenceUrl;
//     // Referencia inválida
//     if (refUrl.isBlank) return null;

//     final refsBox = gi<Box<String>>(instanceName: referencesBoxIdConst);
//     var publicUrl = widget.fromHive ? refsBox.get(refUrl) : null;
//     // Referencia en cache
//     if (publicUrl.isNotBlank) return publicUrl;

//     if (refUrl!.startsWith('gs://')) {
//       final ref = gi<FirebaseStorage>().refFromURL(refUrl);

//       await ref.getDownloadURL().then((url) async {
//         publicUrl = url;

//         await refsBox.put(refUrl, url);
//       }).catchError((_) {});
//     } else if (refUrl.startsWith('https://')) {
//       // URL pública eliminada
//       if (refUrl.contains('Expires=')) return null;

//       publicUrl = refUrl;
//     }

//     return publicUrl;
//   }
// }

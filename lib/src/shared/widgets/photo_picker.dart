// // Dart imports:
// import 'dart:io';

// // Flutter imports:
// import 'package:flutter/material.dart';

// // Project imports:
// import 'package:dart_utils/src/core/util/image_util.dart';
// import 'package:dart_utils/src/shared/app_colors.dart';
// import 'package:dart_utils/src/shared/app_images.dart';

// final class ProfilePhotoPicker extends StatefulWidget {
//   const ProfilePhotoPicker({
//     super.key,
//     required this.onChanged,
//     this.size = 130,
//   });

//   final void Function(File? file) onChanged;
//   final double size;

//   @override
//   State<ProfilePhotoPicker> createState() => _ProfilePhotoPickerState();
// }

// final class _ProfilePhotoPickerState extends State<ProfilePhotoPicker> {
//   File? _file;

//   @override
//   Widget build(BuildContext context) {
//     final photoSize = widget.size - 20;
//     final radius = photoSize / 2;

//     return SizedBox(
//       height: widget.size,
//       child: Stack(
//         alignment: Alignment.topCenter,
//         clipBehavior: Clip.none,
//         children: [
//           CircleAvatar(
//             radius: radius,
//             backgroundColor: Colors.white,
//             foregroundColor: AppColors.primary,
//             child: CircleAvatar(
//               radius: radius - 2, // - 2 for padding
//               backgroundImage: _file is File
//                   ? Image.file(_file!).image
//                   : AppImages.placeholder.image,
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primaryLight2,
//                 padding: const EdgeInsets.all(5),
//                 shape: const CircleBorder(),
//                 minimumSize: const Size.square(20),
//                 tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//               ),
//               onPressed: () => ImageUtil.showPhotoDialog(
//                 context,
//                 (filePhoto) {
//                   setState(() => _file = filePhoto);
//                   widget.onChanged(filePhoto);
//                 },
//               ),
//               child: const Icon(
//                 Icons.camera_alt,
//                 color: Colors.white,
//                 size: 20,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

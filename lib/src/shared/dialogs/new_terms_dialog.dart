// // Flutter imports:
// import 'package:flutter/material.dart';

// // Project imports:
// import 'package:dart_utils/src/core/error/errors.dart';
// import 'package:dart_utils/src/shared/app_colors.dart';
// import 'package:dart_utils/src/shared/constant.dart';
// import 'package:dart_utils/src/shared/widgets/async_elevated_button.dart';
// import 'package:dart_utils/src/shared/widgets/spaces.dart';
// import 'package:dart_utils/src/shared/widgets/terms_and_privacy.dart';

// final class NewTermsDialog<T extends Object> extends StatefulWidget {
//   const NewTermsDialog({
//     super.key,
//     required this.failure,
//     this.onPressed,
//     this.autoPop = false,
//     this.canPop = false,
//     this.dismissible = false,
//   });

//   final TermsError failure;
//   final Future<bool> Function(TermsError failure)? onPressed;
//   final bool autoPop;
//   final bool canPop;
//   final bool dismissible;

//   @override
//   State<NewTermsDialog<T>> createState() => _NewTermsDialogState<T>();

//   Future<bool?> show(BuildContext context) => showDialog(
//         context: context,
//         barrierDismissible: this.dismissible,
//         builder: (_) => this,
//       );
// }

// class _NewTermsDialogState<T extends Object> extends State<NewTermsDialog<T>> {
//   // keys
//   final _termsKey = GlobalKey<TermsAndPoliciesState>();

//   // core
//   final termsAndConditionsLink = remoteParams['terms_and_conditions'];
//   final privacyPoliciesLink = remoteParams['privacy_policies'];

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: widget.canPop,
//       child: Dialog(
//         backgroundColor: Colors.white,
//         shape: kDialogBorder,
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Icon(
//                 Icons.admin_panel_settings,
//                 color: AppColors.primary,
//                 size: 64,
//               ),
//               Spaces.height8,
//               Column(
//                 children: [
//                   Text(
//                     widget.failure.description,
//                     textAlign: TextAlign.center,
//                     style: kBigStyle,
//                   ),
//                   Spaces.height16,
//                   TermsAndPolicies(
//                     key: _termsKey,
//                     policiesLink: privacyPoliciesLink,
//                     termsLink: termsAndConditionsLink,
//                   ),
//                 ],
//               ),
//               Spaces.height16,
//               // aceptar
//               AsyncElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primary,
//                   foregroundColor: Colors.white,
//                   shape: const StadiumBorder(),
//                 ),
//                 onPressed: () async {
//                   final termsAccepted =
//                       _termsKey.currentState?.accepted ?? false;
//                   if (!termsAccepted) {
//                     _termsKey.currentState?.onError();
//                     return;
//                   }

//                   final succes = await widget.onPressed?.call(widget.failure);
//                   if (widget.autoPop && mounted && context.mounted) {
//                     Navigator.of(context).pop(succes);
//                   }
//                 },
//                 child: Text(
//                   appTexts.accept,
//                   style: kBigStyle,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Package imports:
import 'package:path/path.dart' as pth;

// Project imports:
import 'package:dart_utils/src/core/utils/strings.dart';
import 'package:dart_utils/src/core/utils/try.dart';

enum FileTypes {
  document,
  audio,
  video,
  image,
  other,
}

final class Extensions {
  static const all = [
    'ai',
    'doc',
    'docx',
    'xls',
    'xlsx',
    'jpg',
    'jpeg',
    'mov',
    'mp3',
    'mp4',
    'mpeg3',
    'odt',
    'opus',
    'pdf',
    'png',
    'ppt',
    'pptx',
    'psd',
    'rtf',
    'txt',
    'webm',
    'wma',
    '3gp',
  ];

  static const documents = [
    'doc',
    'docx',
    'odt',
    'pdf',
    'ppt',
    'pptx',
    'rtf',
    'txt',
    'xls',
    'xlsx',
  ];

  static const audios = [
    'mp3',
    'mpga',
    'opus',
    'wma',
  ];

  static const videos = [
    'avi',
    'webm',
    'mov',
    'mp4',
    'mpeg3',
    '3gp',
  ];

  static const images = [
    'ai',
    'jpg',
    'jpeg',
    'png',
    'psd',
  ];

  static const map = {
    FileTypes.document: {...documents},
    FileTypes.audio: {...audios},
    FileTypes.video: {...videos},
    FileTypes.image: {...images},
  };

  static get defaultPath => 'assets/images/files/other.png';

  static FileTypes? getFileType(String? filename) {
    if (filename.isBlank) return null;

    return map.entries.firstWhere(
      (fileType) {
        final ext = pth.extension(filename!).substring(1).toLowerCase();
        return fileType.value.contains(ext);
      },
      orElse: () => const MapEntry(FileTypes.other, {}),
    ).key;
  }

  static String? imagePathFromExtension(String? filename) {
    if (filename.isBlank) return null;

    final fileExtension = Try.syncCall(
      call: () => pth.extension(filename!).substring(1).toLowerCase(),
    );
    if (fileExtension.isBlank) return null;

    String? path;

    if (audios.contains(fileExtension)) {
      path = 'assets/images/files/audio.png';
    } else if (videos.contains(fileExtension)) {
      path = 'assets/images/files/video.png';
    } else if (images.contains(fileExtension)) {
      path = 'assets/images/files/image.png';
    } else {
      path = switch (fileExtension) {
        'pdf' => 'assets/images/files/pdf.png',
        'doc' => 'assets/images/files/doc.png',
        'docx' => 'assets/images/files/doc.png',
        'xls' => 'assets/images/files/xls.png',
        'xlsx' => 'assets/images/files/xls.png',
        'ppt' => 'assets/images/files/ppt.png',
        'pptx' => 'assets/images/files/ppt.png',
        _ => 'assets/images/files/other.png',
      };
    }

    return path;
  }
}

// Dart imports:
import 'dart:io';

// Package imports:
import 'package:ffmpeg_kit_flutter_full/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full/return_code.dart';

// Project imports:
import 'package:dart_utils/src/core/app/flutter_cout.dart';

final class AudioConverter {
  /// Convierte el archivo de audio [aacFilePath] con formato `AAC`
  /// a formato `MP3` y lo guarda en [mp3FilePath].
  ///
  /// [deleteAcc] = `true` para borrar el archivo [aacFilePath].
  static Future<String?> aacToMp3({
    required String aacFilePath,
    required String mp3FilePath,
    bool deleteAcc = true,
  }) async {
    final ffmpegCommand = '-i $aacFilePath $mp3FilePath';
    final session = await FFmpegKit.execute(ffmpegCommand);
    final returnCode = await session.getReturnCode();
    if (!ReturnCode.isSuccess(returnCode)) {
      Cout.info('Result: ${await session.getAllLogsAsString()}');
      return null;
    }

    if (deleteAcc) File(aacFilePath).deleteSync();

    return mp3FilePath;
  }
}

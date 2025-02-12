// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:android_path_provider/android_path_provider.dart';
import 'package:either_dart/either.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

// Project imports:
import 'package:dart_utils/src/core/error/errors.dart';
import 'package:dart_utils/src/core/utils/strings.dart';
import 'package:dart_utils/src/core/utils/try.dart';
import 'package:dart_utils/src/core/utils/typedef.dart';
import 'package:dart_utils/src/shared/app_colors.dart';

final class RemoteFile {
  const RemoteFile({
    required this.fileUrl,
    required this.filename,
  });

  final String fileUrl;
  final String filename;
}

final class Files {
  const Files._();

  static const range = 1024;

  // 1 gigabyte
  static const bytesOnGiga = 1073741824;
  static const kilobytesOnGiga = 1048576;
  static const megabytesOnGiga = 1024;

  /// Retorna el nombre de un archivo, dado [url],
  /// `null` si es inválido.
  static String? filenameFromUrl(String? url) {
    if (url is! String) return null;

    final begin = url.lastIndexOf('/') + 1;
    final filename = url.substring(begin);

    return filename;
  }

  /// Intenta descargar [remoteFiles], en caso de haber un error en el listado o
  /// no poder acceder al path para guardar los archivos, retorna `Failure`.
  ///
  /// Cada intento de descargar un `RemoteFile`, guardara el `File` o un `Failure`,
  /// [saveInTemporary] = `true` guarda los archivos en la carpeta temporal,
  /// [showToast] = `true` notificará los estados de la descarga.
  static FEListEValue<File> filesFromUrl({
    required List<RemoteFile>? remoteFiles,
    bool saveInTemporary = false,
    bool showToast = true,
  }) async {
    var downloadError = false;

    if (remoteFiles?.isEmpty ?? true) {
      return const Left(DownloadError('No hay archivos para descargar.'));
    }

    final directory = await Try.asyncCall(
      call: () async {
        if (saveInTemporary) {
          final temporaryDirectory = await getTemporaryDirectory();
          final existsDownloadsDirectory =
              Directory(temporaryDirectory.path).existsSync();

          if (!existsDownloadsDirectory) {
            Directory(temporaryDirectory.path).createSync();
          }

          return temporaryDirectory.path;
        }

        if (Platform.isAndroid) {
          final androidDownloadsDirectory =
              await AndroidPathProvider.downloadsPath;
          final existsDownloadsDirectory =
              Directory(androidDownloadsDirectory).existsSync();

          if (!existsDownloadsDirectory) {
            Directory(androidDownloadsDirectory).createSync();
          }

          return androidDownloadsDirectory;
        } else {
          final iosDownloadsDirectory =
              await getApplicationDocumentsDirectory();
          final existsDownloadsDirectory =
              Directory(iosDownloadsDirectory.path).existsSync();

          if (!existsDownloadsDirectory) {
            Directory(iosDownloadsDirectory.path).createSync();
          }

          return iosDownloadsDirectory.path;
        }
      },
    );
    if (directory == null) {
      return const Left(
        DownloadError('Error al obtener directorio de descargas.'),
      );
    }

    if (showToast) {
      Fluttertoast.showToast(
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        backgroundColor: AppColors.primary,
        msg: 'Iniciando descarga.',
      );
    }

    final failuresOrFiles = <EValue<File>>[];

    for (final remoteFile in remoteFiles!) {
      final fileUrlIsValid = remoteFile.fileUrl.isNotEmpty;
      final filenameIsValid = remoteFile.filename.isNotEmpty;
      if (!fileUrlIsValid || !filenameIsValid) {
        downloadError = true;
        failuresOrFiles.add(
          const Left(GetError('URL o Nombre de archivo inválido.')),
        );
        continue;
      }

      final response = await Try.asyncCall(
        call: () => http.get(Uri.parse(remoteFile.fileUrl)),
      );
      if (response?.statusCode != 200) {
        downloadError = true;
        failuresOrFiles.add(
          const Left(GetError('No se ha podido descargar el archivo.')),
        );
        continue;
      }

      final path = await _generateFilename(
        directory: directory,
        filename: remoteFile.filename,
      );
      if (path == null) {
        downloadError = true;
        failuresOrFiles.add(
          const Left(GetError('Error al generar el nombre del archivo.')),
        );
        continue;
      }

      final file = Try.syncCall(
        call: () {
          final file = File(path)..writeAsBytesSync(response!.bodyBytes);
          return file;
        },
      );

      downloadError = file == null;
      failuresOrFiles.add(
        downloadError
            ? const Left(GetError('Error al guardar archivo.'))
            : Right(file),
      );
    }

    if (showToast) {
      Fluttertoast.showToast(
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        backgroundColor: AppColors.primary,
        msg: downloadError
            ? 'No se ha podido descargar algunos archivos.'
            : 'Descarga completada.',
      );
    }

    return Right(failuresOrFiles);
  }

  /// Retorna una instancia de `File`, dado un [remoteFile].
  static FEValue<File> fileFromUrl(RemoteFile? remoteFile) async {
    final fileUrlIsValid = remoteFile?.fileUrl.isNotEmpty ?? false;
    final filenameIsValid = remoteFile?.filename.isNotEmpty ?? false;
    if (!fileUrlIsValid || !filenameIsValid) {
      return const Left(
        DownloadError('Error al procesar el nombre del archivo.'),
      );
    }

    final response = await Try.asyncCall(
      call: () => http.get(Uri.parse(remoteFile!.fileUrl)),
    );
    if (response == null) {
      return const Left(DownloadError('Error al descargar archivo.'));
    }

    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = File(path.join(documentDirectory.path, remoteFile!.filename));

    file.writeAsBytesSync(response.bodyBytes);

    return Right(file);
  }

  /// Genera un path válido para un archivo en [directory] usando
  /// como referencia [filename].
  ///
  /// genera: file(1).txt si ya existe el archivo file.txt.
  static Future<String?> _generateFilename({
    required String? directory,
    required String? filename,
  }) async {
    final directoryIsValid = directory.isNotBlank;
    final filenameIsValid = filename.isNotBlank;
    if (!directoryIsValid || !filenameIsValid) return null;

    late String path;
    late bool exits;
    var counter = 0;
    final filenamesInDirectory = Directory(directory!)
        .listSync()
        .where((directory) => FileSystemEntity.isFileSync(directory.path))
        .map((directory) => directory.path.split('/').last)
        .toList();

    final pointIndex = filename!.lastIndexOf('.');
    final savePermission = pointIndex > 0 && pointIndex < filename.length - 1;
    if (!savePermission) return null;

    final name = filename.substring(0, pointIndex);
    final extension = filename.substring(pointIndex + 1);

    do {
      final outputName = counter != 0 ? '$name($counter)' : name;
      path = '$directory${Platform.pathSeparator}$outputName.$extension';
      exits = filenamesInDirectory
          .any((filename) => filename == '$outputName.$extension');
      counter++;
    } while (exits);

    return path;
  }
}

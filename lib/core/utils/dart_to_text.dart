import 'dart:io';

import 'package:flutter/widgets.dart';

void extractText() async {
  final sourceDir = Directory('lib');
  final outputDir = Directory('text_output');

  if (!await outputDir.exists()) {
    await outputDir.create(recursive: true);
  }

  await for (var file in sourceDir.list(recursive: true, followLinks: false)) {
    if (file is File && file.path.endsWith('.dart')) {
      final content = await file.readAsString();

      final relativePath = file.path.replaceFirst('lib/', '');
      final txtPath =
          '${outputDir.path}/${relativePath.replaceAll('.dart', '.txt')}';

      final txtFile = File(txtPath);
      await txtFile.create(recursive: true);
      await txtFile.writeAsString(content);

      debugPrint('Converted: ${file.path} -> $txtPath');
    }
  }

  debugPrint('Conversion completed.');
}

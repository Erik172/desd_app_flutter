import 'dart:io';
import 'package:flutter/material.dart';
import 'package:desd_app_flutter/src/sources.dart';

import '../core/core.dart';

class FileProcessor {
  static Future<void> processFiles({
    required BuildContext context,
    required String mainDirectory,
    required List<String> selectedModels,
    required List<Map<String, dynamic>> files,
    required Function(Map<String, dynamic>) statusUpdater,
    required Function(String) workIdUpdater,
  }) async {
    if (selectedModels.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecciona al menos un modelo para procesar'),
        ),
      );
      return;
    }

    final workId = generateId(path: mainDirectory, models: selectedModels);
    workIdUpdater(workId);

    desd(workId, selectedModels, files.map((e) => File(e['path'])).toList());

    await Future.delayed(const Duration(seconds: 2));

    var status = await getStatusDetails(id: workId);
    statusUpdater(status);

    while (status['status'] != 'completed') {
      await Future.delayed(const Duration(seconds: 2));
      status = await getStatusDetails(id: workId);
      statusUpdater(status);
    }

    if (status['status'] == 'completed') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Proceso completado'),
        ),
      );
      downloadResultDirectory(id: workId, directory: mainDirectory);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al procesar los archivos'),
        ),
      );
    }
  }
}

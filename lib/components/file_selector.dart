import 'package:flutter/material.dart';

class FileSelector extends StatelessWidget {
  final Function onDirectoryPicked;
  final int fileCount;

  const FileSelector({
    required this.onDirectoryPicked,
    required this.fileCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton.icon(
          onPressed: () => onDirectoryPicked(),
          label: const Text('Seleccionar directorio'),
          icon: const Icon(Icons.folder_open),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 70),
            side: const BorderSide(width: 1, color: Colors.blue),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Archivos seleccionados: $fileCount',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

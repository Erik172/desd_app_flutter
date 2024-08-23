import 'package:flutter/material.dart';

class FileSelector extends StatelessWidget {
  final Function onDirectoryPicked;
  final List<Map<String, dynamic>> files;

  const FileSelector({
    required this.onDirectoryPicked,
    required this.files,
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
          'Archivos seleccionados: ${files.length}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          constraints: const BoxConstraints(
            maxHeight: 200,
          ),

          child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: SelectableText(files[index]['name']),
                      subtitle: SelectableText(
                        files[index]['path'],
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                      trailing: Text(files[index]['extension']),
                    );
                  },
                ), 
        ),
      ],
    );
  }
}

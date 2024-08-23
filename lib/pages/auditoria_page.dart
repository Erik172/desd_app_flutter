import 'package:desd_app_flutter/components/components.dart';
import 'package:desd_app_flutter/src/sources.dart';
import 'package:desd_app_flutter/core/core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


class AuditoriaPage extends StatefulWidget {
  const AuditoriaPage({super.key});

  @override
  State<AuditoriaPage> createState() => _AuditoriaPageState();
}

class _AuditoriaPageState extends State<AuditoriaPage> {
  String mainDirectory = '';
  List<Map<String, dynamic>> files = [];
  Map<String, dynamic> status = {};
  List<String> models = ['rotacion', 'inclinacion', 'corte_informacion'];
  List<String> selectedModels = [];
  String workId = '';

  Future<void> pickDirectory() async {
    await FileProcessor.pickDirectory(
      context: context,
      onFilesPicked: (pickedFiles, directory) {
        setState(() {
          files = pickedFiles;
          mainDirectory = directory;
        });
      },
    );
  }

  Future<void> processFiles() async {
    await FileProcessor.processFiles(
      context: context,
      mainDirectory: mainDirectory,
      selectedModels: selectedModels,
      files: files,
      statusUpdater: (newStatus) {
        setState(() {
          status = newStatus;
        });
      },
      workIdUpdater: (newWorkId) {
        setState(() {
          workId = newWorkId;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 15),
            const Text(
              'Auditoria',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            FileSelector(onDirectoryPicked: pickDirectory, files: files),
            const SizedBox(height: 20),
            if (files.isNotEmpty) ...{
              // selecionar un modelo o varios modelos
              ModelSelector(
                models: models,
                selectedModels: selectedModels,
                onModelSelected: (selected) {
                  setState(() {
                    selectedModels = selected;
                  });
                },
              ),

              const SizedBox(height: 21),

              OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    files = [];
                    mainDirectory = '';
                    selectedModels = [];
                    status = {};
                    workId = '';

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Archivos limpiados'),
                      ),
                    );
                  });
                },
                label: const Text('Limpiar archivos'),
                icon: const Icon(Icons.delete),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 70),
                  // side: const BorderSide(width: 1, color: Colors.blue),
                ),
              ),

              const SizedBox(height: 20),

              FilledButton(
                onPressed: processFiles,
                style: ButtonStyle(
                  minimumSize:
                      WidgetStateProperty.all(const Size(double.infinity, 70)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.upload),
                    SizedBox(width: 10),
                    Text('Procesar Archivos'),
                  ],
                ),
              ),

              const SizedBox(height: 19),

              if (workId.isNotEmpty) ...{
                infoAlert(context, 'Identificador (ID)',
                    workId.replaceAll('_!1_', '\\')),
              },

              const SizedBox(height: 11),
            } else ...{
              const SizedBox(),
            },
            const SizedBox(height: 20),
            if (status.isNotEmpty) ...{
              Text(
                'Status: ${status['status']}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              percentageIndicator(
                  percentage: status['percentage'].toDouble(),
                  totalFiles: status['total_files'],
                  processedFiles: status['files_processed']),
              const SizedBox(height: 20),
            } else ...{
              const SizedBox(),
            },
            if (status.isNotEmpty && status['status'] == 'completed') ...{
              ElevatedButton.icon(
                onPressed: () async {
                  DateTime now = DateTime.now();
                  String? outputFile = await FilePicker.platform.saveFile(
                    allowedExtensions: ['csv'],
                    type: FileType.custom,
                    dialogTitle: 'Guardar resultados',
                    fileName:
                        'result_${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}__${workId.split('__')[1]}.csv',
                  );

                  if (outputFile != null) {
                    await downloadResultDirectory(
                        id: workId,
                        filename: outputFile.split('\\').last,
                        directory: outputFile
                            .split('\\')
                            .sublist(0, outputFile.split('\\').length - 1)
                            .join('\\'));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Resultados descargados'),
                      ),
                    );
                  }
                },
                label: const Text('Descargar resultados'),
                icon: const Icon(Icons.download),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 70),
                  side: const BorderSide(width: 1, color: Colors.blue),
                ),
              ),
            } else ...{
              const SizedBox(),
            },
          ],
        ),
      ),
    );
  }
}

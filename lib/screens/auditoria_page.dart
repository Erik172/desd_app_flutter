import 'package:desd_app_flutter/components/components.dart';
import 'package:flutter/material.dart';

import '../src/sources.dart';

class AuditoriaPage extends StatefulWidget {
  const AuditoriaPage({super.key});

  @override
  State<AuditoriaPage> createState() => _AuditoriaPageState();
}

class _AuditoriaPageState extends State<AuditoriaPage> {
  String mainDirectory = '';
  List<Map<String, dynamic>> files = [];
  Map<String, dynamic> status = {};
  List<String> selectedModels = [];
  String workId = '';
  List<String> models = ['rotacion', 'inclinacion', 'corte_informacion'];

  // Future<void> pickDirectory() async {
  //   mainDirectory = await DirectoryPicker.pickDirectory();
  //   setState(() {
  //     files = DirectoryPicker.getFiles(mainDirectory);
  //   });
  // }

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auditoria'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
          child: Column(
            children: <Widget>[
              // FileSelector(onDirectoryPicked: pickDirectory, fileCount: files.length),
              const SizedBox(height: 20),
              if (files.isNotEmpty) ...{
                ModelSelector(
                  models: models,
                  selectedModels: selectedModels,
                  onModelSelected: (selected) {
                    setState(() {
                      selectedModels = selected;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ProcessStatus(
                  status: status,
                  workId: workId,
                  onProcessFiles: processFiles,
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}

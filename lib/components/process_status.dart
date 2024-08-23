import 'package:flutter/material.dart';

class ProcessStatus extends StatelessWidget {
  final Map<String, dynamic> status;
  final String workId;
  final Function onProcessFiles;

  const ProcessStatus({
    required this.status,
    required this.workId,
    required this.onProcessFiles,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FilledButton(
          onPressed: () => onProcessFiles(),
          style: ButtonStyle(
            minimumSize: WidgetStateProperty.all(const Size(double.infinity, 70)),
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
        const SizedBox(height: 20),
        if (workId.isNotEmpty) ...{
          Text('ID del trabajo: $workId'),
        },
        const SizedBox(height: 10),
        if (status.isNotEmpty) ...{
          Text('Status: ${status['status']}'),
        },
      ],
    );
  }
}

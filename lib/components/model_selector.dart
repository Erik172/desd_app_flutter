import 'package:flutter/material.dart';

class ModelSelector extends StatelessWidget {
  final List<String> models;
  final List<String> selectedModels;
  final Function(List<String>) onModelSelected;

  const ModelSelector({
    required this.models,
    required this.selectedModels,
    required this.onModelSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Seleccionar modelos:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 10),
          Center(
            child: Wrap(
              spacing: 10,
              children: models.map((model) {
                return FilterChip(
                  label: Text(model),
                  selected: selectedModels.contains(model),
                  onSelected: (selected) {
                    final updatedModels = List<String>.from(selectedModels);
                    if (selected) {
                      updatedModels.add(model);
                    } else {
                      updatedModels.remove(model);
                    }
                    onModelSelected(updatedModels);
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

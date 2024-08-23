import 'package:flutter/material.dart';

Widget percentageIndicator({
  required double percentage,
  int totalFiles = 0,
  int processedFiles = 0,
}) {
  return Stack(
    alignment: Alignment.center,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10), // Borde curvo
        child: LinearProgressIndicator(
          value: percentage / 100,
          minHeight: 25, // Ajusta la altura del indicador aquí
          backgroundColor: Colors.grey[300], // Color de fondo
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.redAccent),
        ),
      ),
      Text(
        '${percentage.toStringAsFixed(1)}% - $processedFiles/$totalFiles archivos procesados',
        style: const TextStyle(
          color: Colors.white, // Color del texto
          fontWeight: FontWeight.bold, // Estilo de texto
        ),
      ),
    ],
  );
}

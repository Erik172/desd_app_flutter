import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

Future<List<dynamic>> getResult({required String id, String host = 'http://localhost:5000'}) async {
  final response = await http.get(Uri.parse('$host/v1/resultados/$id'));
  return jsonDecode(response.body);
}

Future<void> downloadResult({required String id, String host = 'http://localhost:5000'}) async {
  final response = await http.get(Uri.parse('$host/v2/export/$id'));
  final file = File('result_$id.csv');
  await file.writeAsBytes(response.bodyBytes);
}

Future<void> downloadResultDirectory({required String id, required String directory, String? filename, String host = 'http://localhost:5000'}) async {
  final response = await http.get(Uri.parse('$host/v2/export/$id'));
  DateTime now = DateTime.now();
  String models = id.split('.csv')[0].split('__')[1];

  if (filename == null) {
    filename = 'result_${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}__$models.csv';
  } else if (!filename.endsWith('.csv')) {
    filename = '$filename.csv';
  }

  final file = File('$directory/$filename');
  await file.writeAsBytes(response.bodyBytes);
}
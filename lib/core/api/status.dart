import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> getStatus({String host = 'http://localhost:5000'}) async {
  final response = await http.get(Uri.parse('$host/v2/status'));
  return jsonDecode(response.body);
}

Future<Map<String, dynamic>> getStatusDetails({required String id, String host = 'http://localhost:5000'}) async {
  final response = await http.get(Uri.parse('$host/v2/status/$id'));
  return jsonDecode(response.body);
}
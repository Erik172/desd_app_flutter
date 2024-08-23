import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

Future<void> desd(String resultId, List<String> modelNames, List<File> files, [String host = 'http://localhost:5000']) async {
  final uri = Uri.parse('$host/v2/desd');

  var request = http.MultipartRequest('POST', uri);

  request.fields['result_id'] = resultId;
  request.fields['models'] = modelNames.join(',');

  for (var file in files) {
    var fileStream = http.ByteStream(file.openRead());
    var length = await file.length();
    var multipartFile = http.MultipartFile(
      'files',
      fileStream,
      length,
      filename: file.uri.pathSegments.last,
    );
    request.files.add(multipartFile);
  }

  var response = await request.send();

  if (response.statusCode == 200) {
    print('Files uploaded successfully.');
    var responseBody = jsonDecode(await response.stream.bytesToString());
    print('Response: ${responseBody["message"]}');
  } else {
    print('Failed to upload files. Status code: ${response.statusCode}');
    print('Response: ${jsonDecode(await response.stream.bytesToString())["message"]}');
    exit(1);
  }
}
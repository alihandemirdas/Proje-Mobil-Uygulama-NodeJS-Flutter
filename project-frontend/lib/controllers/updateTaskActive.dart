import 'dart:convert';
import 'package:http/http.dart' as http;

Future updateTaskActive(String id, String active) async {

  final response = await http.post(Uri.parse("http://10.0.2.2:3000/work/update-task-active"),
      headers: {"Accept":"Application/json"},
      body: {"id":id, "active":active}
  );

  var decodedData = jsonDecode(response.body);
  return decodedData;

}
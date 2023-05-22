import 'dart:convert';
import 'package:http/http.dart' as http;

Future getAllTasks(String workid) async {

  final response = await http.get(Uri.parse("http://10.0.2.2:8080/work/get-all-tasks?workid=${workid}"),
    headers: {"Accept":"Application/json"},
  );

  var decodedData = jsonDecode(response.body);
  return decodedData;

}
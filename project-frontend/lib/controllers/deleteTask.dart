import 'dart:convert';
import 'package:http/http.dart' as http;

Future deleteTask(String taskid) async {

  final response = await http.post(Uri.parse("http://10.0.2.2:3000/work/delete-task"),
      headers: {"Accept":"Application/json"},
      body: {"taskid":taskid}
  );

  var decodedData = jsonDecode(response.body);
  return decodedData;

}
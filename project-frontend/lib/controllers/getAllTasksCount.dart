import 'dart:convert';
import 'package:http/http.dart' as http;

Future getAllTasksCount(String id) async {

  final response = await http.post(Uri.parse("http://10.0.2.2:3000/work/get-all-task-counts"),
    headers: {"Accept":"Application/json"},
      body: {"id":id}
  );

  var decodedData = jsonDecode(response.body);
  return decodedData;

}
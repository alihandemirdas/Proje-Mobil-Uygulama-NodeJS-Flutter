import 'dart:convert';
import 'package:http/http.dart' as http;

Future addTaskToWork (String userid, String workid, String title, String long) async {

  final response = await http.post(Uri.parse("http://10.0.2.2:3000/work/add-task-to-work"),
      headers: {"Accept":"Application/json"},
      body: {'userid':userid, 'workid':workid, 'title':title, 'long':long}
  );

  var decodedData = jsonDecode(response.body);
  return decodedData;

}
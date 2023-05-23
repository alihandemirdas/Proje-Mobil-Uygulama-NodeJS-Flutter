import 'dart:convert';
import 'package:http/http.dart' as http;

Future updateWorkStatus(String id, String status) async {

  final response = await http.post(Uri.parse("http://10.0.2.2:3000/work/update-work-status"),
      headers: {"Accept":"Application/json"},
      body: {"id":id, "status":status}
  );

  var decodedData = jsonDecode(response.body);
  return decodedData;

}
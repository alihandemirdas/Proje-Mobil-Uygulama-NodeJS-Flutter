import 'dart:convert';
import 'package:http/http.dart' as http;

Future deleteWork (String workid) async {

  final response = await http.post(Uri.parse("http://10.0.2.2:3000/work/delete-work"),
      headers: {"Accept":"Application/json"},
      body: {"workid":workid}
  );

  var decodedData = jsonDecode(response.body);
  return decodedData;

}
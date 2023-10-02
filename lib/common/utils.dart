import 'package:http/http.dart' as http;
import 'dart:convert';

const baseUrl = 'https://api.hgbrasil.com/finance?key=fa305e48';

Future<Map> getApiData() async {
  http.Response response = await http.get(Uri.parse(baseUrl));

  return json.decode(response.body);
}

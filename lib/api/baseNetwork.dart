import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:japan_front/api/api.dart';
import 'package:japan_front/model/Kangi.dart';

class BaseNetWork {
  Future<Map<String, dynamic>> getAllWordsAndCnt(http.Client client) async {
    String newUrl = Api.getAllWordsAndCnt;

    print(newUrl);
    var url = Uri.parse(newUrl);

    var response = await client.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load Kangi");
    }
  }
}
